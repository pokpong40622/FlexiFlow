import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_kit/l10n/app_localizations.dart';
import 'package:motion_kit/theme/wcag_utils.dart';
import 'package:google_generative_ai/google_generative_ai.dart' as google_ai;
import '../fake_var.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({Key? key}) : super(key: key);

  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage>
    with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isTyping = false;
  bool _isBotTyping = false;
  List<String> randomSuggestions = [];
  Locale? _lastLocale;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late google_ai.GenerativeModel _model;

  @override
  void initState() {
    super.initState();
    // Convert seconds to a more human-readable format (minutes)
    final timeSpentTodayMin = (Globals.timeSpentTD / 60).floor();
    final timeSpentWeeklyMin = (Globals.timeSpentWK / 60).floor();
    final timeSpentMonthlyMin = (Globals.timeSpentMH / 60).floor();
    final unlockedSumItUpStr = Globals.unlockedSumItUp ? 'Yes' : 'No';

    final userDataContext = '''
[User Profile & Current Progress]
- App Usage Today: $timeSpentTodayMin minutes
- App Usage This Week: $timeSpentWeeklyMin minutes
- App Usage This Month: $timeSpentMonthlyMin minutes
- Daily Steps Today: ${Globals.totalStepsTD} steps
- Current Daily Streak: ${Globals.streak} days
- Currency (Coins): ${Globals.coins}
- Experience (Exp): ${Globals.exp} (Current Level: ${Globals.level})
- Brain Score: ${Globals.brainScore}
- 'Sum It Up' Game Unlocked: $unlockedSumItUpStr

*(System Note: Use this background context to playfully encourage the user and personalize recommendations. Do not recite these exact stats back to the user unless directly relevant to their question.)*
''';
    _model = google_ai.GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: "AIzaSyDgsAKMeDN3q4rxrXuu9jqUKAz4njKLIyY",
      systemInstruction: google_ai.Content.system(
          '''You are Lexi, the official AI Cognitive Coach and Support Assistant for FlexiFlow. FlexiFlow is an EdTech application dedicated to improving cognitive function, enhancing mental flexibility, and promoting brain health to help delay or manage cognitive decline, such as dementia.

Your tone is empathetic, encouraging, professional, and accessible. You are speaking to users who may be older adults, caregivers, or individuals looking to proactively train their brains. You must be patient, clear, and easy to understand. Do not use overly complex medical jargon unless you immediately explain it.

Core Knowledge Base about the FlexiFlow App

What is FlexiFlow: FlexiFlow is a cognitive training app that uses interactive games and routines to improve working memory, executive function, and cognitive flexibility.

Time Commitment: We recommend spending 15 to 20 minutes a day on FlexiFlow for optimal brain health benefits.

Improving Flexibility: Flexibility in FlexiFlow refers to cognitive flexibility, the brain's ability to switch between thinking about two different concepts. Users improve this by playing our shifting-logic puzzles.

Benefits: Regular use helps build cognitive reserve, sharpens focus, improves daily memory recall, and provides a fun, stimulating workout for the brain.

Tracking Progress: Users can view their daily streaks, accuracy scores, and cognitive growth charts in the Progress tab of the app.

Equipment Needed: Just a smartphone, tablet, or computer. No extra equipment is required.

Behavioral Guidelines and Guardrails

Handling Routines: If a user asks for a routine, ask them about their current energy level and suggest a specific short sequence of FlexiFlow brain games. For example, let them start with a 5-minute memory recall warmup, followed by a 10-minute pattern recognition game.

Handling Pain or Frustration: If a user expresses feeling mental fatigue, brain pain, or frustration, be deeply empathetic. Advise them to take a break, hydrate, and remind them that cognitive growth happens during rest. If they express actual physical pain or severe medical distress, advise them to stop using the device and consult a healthcare professional immediately.

Motivation: If a user is unmotivated, remind them of the reasons to play. Mention that just like physical exercise, brain training takes time to show results. Celebrate small wins.

No Hallucinations: Do not invent features that FlexiFlow does not have. If a user asks a question about a feature you do not know about, politely state that you are still learning and direct them to the human support team.

Language Adaptability: If the user speaks in Thai, seamlessly switch to polite, encouraging Thai using polite particles appropriately.

Interaction Format

Always greet the user warmly if it is the start of a conversation.

Keep responses concise, usually under 3 to 4 short paragraphs.

Do not use bullet points or markdown formatting in your responses, use plain text only.

End your response with a gentle, encouraging question to keep the user engaged, such as asking if they would like to start a 5-minute warmup game now.

$userDataContext'''),
    );
    _controller.addListener(_onTextChanged);
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _fadeController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    if (_lastLocale != locale) {
      _lastLocale = locale;
      final l10n = AppLocalizations.of(context)!;
      final localizedSuggestions = _localizedSuggestions(l10n)..shuffle();
      randomSuggestions = localizedSuggestions.take(4).toList();
    }
  }

  void _onTextChanged() {
    setState(() {
      _isTyping = _controller.text.isNotEmpty;
    });
  }

  Future<void> _sendMessage([String? customMessage]) async {
    final message = customMessage ?? _controller.text;
    if (message.isNotEmpty) {
      final l10n = AppLocalizations.of(context)!;
      setState(() {
        _messages.add({
          'text': message,
          'isUser': true,
          'timestamp': DateTime.now(),
        });
        _controller.clear();
        _isTyping = false;
        _isBotTyping = true;
      });

      try {

        final requestPrompt = '$message';
        final stream = _model
            .generateContentStream([google_ai.Content.text(requestPrompt)]);

        print('Started stream requesting...');
        int? messageIndex;

        await for (final chunk in stream) {
          print(
              'Received chunk: "${chunk.text}" (length: ${chunk?.text?.length ?? 0})');
          if (!mounted) break;
          if (chunk.text != null && chunk.text!.isNotEmpty) {
            setState(() {
              if (_isBotTyping) {
                _isBotTyping = false;
                messageIndex = _messages.length;
                _messages.add({
                  'text': chunk.text,
                  'isUser': false,
                  'timestamp': DateTime.now(),
                });
              } else if (messageIndex != null) {
                _messages[messageIndex!]['text'] += chunk.text;
              }
            });
          }
        }
        print('Stream finished.');
      } catch (e) {
        print('Error in stream: $e');
        if (mounted) {
          setState(() {
            _messages.add({
              'text': l10n.chatbotConnectionError(e.toString()),
              'isUser': false,
              'timestamp': DateTime.now(),
            });
            _isBotTyping = false;
          });
        }
      }
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 22,
          ),
          color: Colors.grey[700],
          onPressed: () => Navigator.pop(context),
          tooltip: l10n.goBack,
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0397FD), Color(0xFF0373CC)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0397FD).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  'assets/images/flexiflow_white.png',
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.chatbotTitleLexiAssistant,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  l10n.chatbotSubtitleAlwaysHere,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!, width: 1),
            ),
            child: WcagTapTarget(
              child: IconButton(
                icon: const Icon(
                  Icons.more_vert,
                  size: 20,
                ),
                color: Colors.grey[700],
                onPressed: () {
                  _showOptionsMenu(context);
                },
                tooltip: l10n.chatbotMoreOptions,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey[300],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey[50]!,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: _messages.isEmpty ? _buildEmptyState() : _buildChatList(),
            ),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    final l10n = AppLocalizations.of(context)!;
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            Hero(
              tag: 'chatbot_logo',
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [],
                ),
                child: CircleAvatar(
                  radius: 90,
                  backgroundColor: const Color(0xFF0397FD),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Image.asset(
                      'assets/images/flexiflow_white.png',
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.chatbotHowCanWeHelp,
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0397FD),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _buildSuggestionChips(),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionChips() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Wrap(
        spacing: 12.0,
        runSpacing: 12.0,
        alignment: WrapAlignment.center,
        children: randomSuggestions.map((suggestion) {
          return TweenAnimationBuilder<double>(
            duration: Duration(
                milliseconds:
                    300 + (randomSuggestions.indexOf(suggestion) * 100)),
            tween: Tween<double>(begin: 0.0, end: 1.0),
            curve: Curves.elasticOut,
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.grey[50]!,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.grey[200]!,
                      width: 1,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(25),
                      onTap: () {
                        _sendMessage(suggestion);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        child: Text(
                          suggestion,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildChatList() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: _messages.length + (_isBotTyping ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _messages.length && _isBotTyping) {
                return _buildTypingIndicator();
              }
              final message = _messages[index];
              return _buildMessageBubble(message);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    final isUser = message['isUser'] as bool;
    final text = message['text'] as String;
    final timestamp = message['timestamp'] as DateTime;

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 300),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 20),
          child: Opacity(
            opacity: value,
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment:
                    isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (!isUser) ...[
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF0397FD), Color(0xFF0373CC)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF0397FD).withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          child: Image.asset(
                            'assets/images/flexiflow_white.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Flexible(
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      decoration: BoxDecoration(
                        color: isUser ? const Color(0xFF0397FD) : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(20),
                          topRight: const Radius.circular(20),
                          bottomLeft: Radius.circular(isUser ? 20 : 4),
                          bottomRight: Radius.circular(isUser ? 4 : 20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            text,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: isUser ? Colors.white : Colors.black87,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _formatTime(timestamp),
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: isUser ? Colors.white70 : Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isUser) ...[
                    const SizedBox(width: 8),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.grey[300],
                      child: Icon(
                        Icons.person_outline,
                        color: Colors.grey[600],
                        size: 16,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTypingIndicator() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0397FD), Color(0xFF0373CC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0397FD).withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(6),
                child: Image.asset(
                  'assets/images/flexiflow_white.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(4),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTypingDot(0),
                const SizedBox(width: 4),
                _buildTypingDot(1),
                const SizedBox(width: 4),
                _buildTypingDot(2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingDot(int index) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 600),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300 + (index * 100)),
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[400]!.withOpacity(0.5 + (value * 0.5)),
          ),
        );
      },
    );
  }

  Widget _buildInputArea() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey[300],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Attachment button with better styling
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.grey[200]!,
                        width: 1,
                      ),
                    ),
                    child: WcagTapTarget(
                      child: IconButton(
                        onPressed: () {
                          // Add attachment functionality
                        },
                        icon: Icon(
                          Icons.attach_file,
                          color: Colors.grey[600],
                          size: 20,
                        ),
                        tooltip: l10n.chatbotAttachFile,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Text input field with improved styling
                  Expanded(
                    child: Container(
                      constraints: const BoxConstraints(
                        minHeight: 48,
                        maxHeight: 120,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1.5,
                        ),
                      ),
                      child: TextField(
                        controller: _controller,
                        maxLines: null,
                        textCapitalization: TextCapitalization.sentences,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 14.0,
                          ),
                          border: InputBorder.none,
                          hintText: l10n.chatbotInputHint,
                          hintStyle: GoogleFonts.inter(
                            color: Colors.grey[500],
                            fontSize: 16,
                          ),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Send button with animation
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: _isTyping
                            ? const LinearGradient(
                                colors: [Color(0xFF0397FD), Color(0xFF0373CC)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : LinearGradient(
                                colors: [Colors.grey[300]!, Colors.grey[400]!],
                              ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: _isTyping
                            ? [
                                BoxShadow(
                                  color:
                                      const Color(0xFF0397FD).withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : [],
                      ),
                      child: WcagTapTarget(
                        child: IconButton(
                          onPressed: _isTyping ? () => _sendMessage() : null,
                          icon: Icon(
                            Icons.send_rounded,
                            color: _isTyping ? Colors.white : Colors.grey[500],
                            size: 20,
                          ),
                          tooltip: l10n.chatbotSendMessage,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    final l10n = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return l10n.chatbotJustNow;
    } else if (difference.inMinutes < 60) {
      return l10n.chatbotMinutesAgo('${difference.inMinutes}');
    } else if (difference.inHours < 24) {
      return l10n.chatbotHoursAgo('${difference.inHours}');
    } else {
      return '${timestamp.day}/${timestamp.month}';
    }
  }

  void _showOptionsMenu(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.red[600],
                  size: 20,
                ),
              ),
              title: Text(
                l10n.chatbotClearChatHistory,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                _clearChatHistory();
              },
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.help_outline,
                  color: Colors.blue[600],
                  size: 20,
                ),
              ),
              title: Text(
                l10n.chatbotHelpSupport,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                _showHelpDialog();
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _clearChatHistory() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          l10n.chatbotClearChatHistory,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          l10n.chatbotClearHistoryConfirm,
          style: GoogleFonts.inter(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              l10n.cancel,
              style: GoogleFonts.inter(
                color: Colors.grey[600],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _messages.clear();
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[600],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              l10n.chatbotClear,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.help_outline,
                color: Colors.blue[600],
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              l10n.chatbotHelpTipsTitle,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.chatbotHelpTipsHeader,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 12),
            _buildHelpItem('💬', l10n.chatbotHelpTipSpecificQuestions),
            _buildHelpItem('🎯', l10n.chatbotHelpTipPersonalizedRoutine),
            _buildHelpItem('📝', l10n.chatbotHelpTipFormTechnique),
            _buildHelpItem('⏰', l10n.chatbotHelpTipSchedules),
            _buildHelpItem('🔄', l10n.chatbotHelpTipSuggestionChips),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0397FD),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              l10n.chatbotGotIt,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<String> _localizedSuggestions(AppLocalizations l10n) {
    return [
      l10n.chatbotSuggestion1,
      l10n.chatbotSuggestion2,
      l10n.chatbotSuggestion3,
      l10n.chatbotSuggestion4,
      l10n.chatbotSuggestion5,
      l10n.chatbotSuggestion6,
      l10n.chatbotSuggestion7,
      l10n.chatbotSuggestion8,
      l10n.chatbotSuggestion9,
      l10n.chatbotSuggestion10,
      l10n.chatbotSuggestion11,
      l10n.chatbotSuggestion12,
      l10n.chatbotSuggestion13,
      l10n.chatbotSuggestion14,
    ];
  }

  Widget _buildHelpItem(String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

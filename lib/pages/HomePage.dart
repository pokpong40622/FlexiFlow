import 'package:carousel_slider/carousel_slider.dart';
import 'package:motion_kit/fake_var.dart';
import 'package:motion_kit/figma/chatbot.dart';
import 'package:motion_kit/pages/LeaderboardPage.dart';
import 'package:motion_kit/pages/ProfilePage.dart';
import 'package:shimmer/shimmer.dart';
import 'package:motion_kit/theme/app_tokens.dart';
import 'package:motion_kit/theme/wcag_utils.dart';
import 'package:motion_kit/l10n/app_localizations.dart';
import 'package:motion_kit/exam/visual_pal_remember_page.dart';
import 'package:motion_kit/exam/exam_state.dart';
import 'GetStarted.dart';
import 'ShopPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ── Helper model ─────────────────────────────────────────────────────────────
class _BodyPart {
  final String text;
  final bool highlight;
  const _BodyPart(this.text, this.highlight);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeIndex = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _showAwarenessPopup());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ModalRoute.of(context);
  }

  // ── Popup cycling logic ───────────────────────────────────────────────────

  Future<void> _showAwarenessPopup() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Check if popup was already shown today
    final now = DateTime.now();
    final todayStr = '${now.year}-${now.month}-${now.day}';
    final lastShownDate = prefs.getString('last_exam_popup_date');

    /*
    if (lastShownDate == todayStr) {
      return; // Already shown today
    }

     */
    
    await prefs.setString('last_exam_popup_date', todayStr);

    final int idx = prefs.getInt('awareness_popup_index') ?? 0;
    await prefs.setInt('awareness_popup_index', (idx + 1) % 2);
    if (!mounted) return;

    if (idx == 0) {
      _showPopup(
        emoji: '🧠',
        tag: 'สุขภาพสมอง',
        title: 'วันนี้คุณ\nทดสอบสมองหรือยัง?',
        bodyParts: const [
          _BodyPart('ทำแบบทดสอบประจำวันเพียง ', false),
          _BodyPart('ใช้เวลาไม่นาน ', true),
          _BodyPart('เพื่อติดตามและประเมินสุขภาพสมองของคุณอย่างสม่ำเสมอ', false),
        ],
        bodyExtra: 'ความสม่ำเสมอคือกุญแจสำคัญ',
        ctaText: 'เริ่มทดสอบเลย',
        onCta: () {
          ExamState.reset();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const VisualPalRememberPage(roundIndex: 0)),
          );
        },
      );
    } else {
      _showPopup(
        emoji: '📝',
        tag: 'การทดสอบประจำวัน',
        title: 'ถึงเวลา\nเช็คความจำแล้ว!',
        bodyParts: const [
          _BodyPart('มาทำการทดสอบของเรา ', true),
          _BodyPart('เพื่อประเมินความสามารถในการจดจำและการรับรู้ของคุณ', false),
        ],
        bodyExtra: 'ทำได้ทุกที่ ทุกเวลา',
        ctaText: 'เข้าสู่การทดสอบ',
        onCta: () {
          ExamState.reset();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const VisualPalRememberPage(roundIndex: 0)),
          );
        },
      );
    }
  }

  void _showPopup({
    required String emoji,
    required String tag,
    required String title,
    required List<_BodyPart> bodyParts,
    required String bodyExtra,
    required String ctaText,
    required VoidCallback onCta,
  }) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.55),
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: sw * 0.06),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Gradient header
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: sh * 0.032),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    Text(emoji, style: TextStyle(fontSize: sw * 0.14)),
                    SizedBox(height: sh * 0.012),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.22),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        tag,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: sw * 0.032,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── White body
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: sw * 0.06, vertical: sh * 0.026),
                child: Column(
                  children: [
                    // Title
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: sw * 0.058,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF1A1A1A),
                        height: 1.35,
                      ),
                    ),
                    SizedBox(height: sh * 0.016),

                    // Divider
                    Container(
                      width: sw * 0.1,
                      height: 3,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(height: sh * 0.016),

                    // Body with highlights
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: GoogleFonts.inter(
                          fontSize: sw * 0.04,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF555555),
                          height: 1.75,
                        ),
                        children: bodyParts
                            .map((part) => TextSpan(
                                  text: part.text,
                                  style: part.highlight
                                      ? GoogleFonts.inter(
                                          fontSize: sw * 0.04,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF1E88E5),
                                          height: 1.75,
                                        )
                                      : null,
                                ))
                            .toList(),
                      ),
                    ),
                    SizedBox(height: sh * 0.01),

                    // Extra body
                    Text(
                      bodyExtra,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: sw * 0.037,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF888888),
                        height: 1.7,
                      ),
                    ),
                    SizedBox(height: sh * 0.026),

                    // CTA button
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(ctx);
                        onCta();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: sh * 0.018),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF1E88E5).withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          ctaText,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: sw * 0.042,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: sh * 0.012),

                    // Close
                    GestureDetector(
                      onTap: () => Navigator.pop(ctx),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          'ปิด',
                          style: GoogleFonts.inter(
                            color: const Color(0xFFBBBBBB),
                            fontSize: sw * 0.036,
                            fontWeight: FontWeight.w500,
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
      ),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final l10n = AppLocalizations.of(context)!;

    final List<String> slideImages = [
      'assets/ImagesliderFlexicoin.png',
      'assets/ImagesliderGrandma.png',
      'assets/ImagesliderGrandpa.png',
    ];

    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.015,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Picture with subtle styling
                  Semantics(
                    button: true,
                    label: l10n.homeOpenProfile,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfilePage()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.15),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/FlexiFlowProfilePic.png',
                            width: screenWidth * 0.12,
                            height: screenWidth * 0.12,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Title with improved styling
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        l10n.navHome,
                        style: GoogleFonts.inter(
                          fontSize: screenWidth * 0.065,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF2C2C2C),
                          letterSpacing: 0.5,
                        ),
                      ),
                      Container(
                        height: 2,
                        width: screenWidth * 0.1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                  // Logo with improved styling
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Image.asset(
                      'assets/FlexiFlowLogoColor.png',
                      width: screenWidth * 0.1,
                      height: screenWidth * 0.1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.026),
            CarouselSlider(
              options: CarouselOptions(
                height: screenHeight * 0.21836,
                autoPlay: true,
                viewportFraction: screenWidth * 0.808 / screenWidth,
                onPageChanged: (index, reason) =>
                    setState(() => activeIndex = index),
              ),
              items: slideImages.map((slideImage) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      slideImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: screenHeight * 0.0134),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.043),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        l10n.homeServicesTitle,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: screenWidth * 0.054,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.0098),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildServiceAction(
                        label: l10n.homeServiceDiscoverPosture,
                        onTap: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => Getstarted(),
                            ),
                          );
                        },
                        child: _buildServicesButton(
                          icon: Icons.travel_explore,
                          label: l10n.homeServiceDiscoverPosture,
                          ColorCode: Color(0xFF0397FD),
                        ),
                      ),
                      _buildServiceAction(
                        label: l10n.homeServiceLeaderboard,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const LeaderboardPage()),
                          );
                        },
                        child: _buildServicesButton(
                          icon: Icons.leaderboard,
                          label: l10n.homeServiceLeaderboard,
                          ColorCode: Color(0xFF0397FD),
                        ),
                      ),
                      _buildServiceAction(
                        label: l10n.homeServiceChatbot,
                        onTap: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => ChatBotPage(),
                            ),
                          );
                        },
                        child: _buildServicesButton(
                          icon: Icons.support_agent,
                          label: l10n.homeServiceChatbot,
                          ColorCode: Color(0xFF0397FD),
                        ),
                      ),
                      _buildServiceAction(
                        label: l10n.homeServiceShop,
                        onTap: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => ShopPage(),
                            ),
                          );
                        },
                        child: _buildServicesButton(
                            icon: Icons.shopping_cart_outlined,
                            label: l10n.homeServiceShop,
                            ColorCode: Color(0xFF0397FD)),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.019),
                  Row(
                    children: [
                      Text(
                        l10n.homeOthersTitle,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: screenWidth * 0.054,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.012),
                  _FeedbackSummary(),
                  SizedBox(height: screenHeight * 0.02),
                  _StreakWidget(),
                  SizedBox(height: screenHeight * 0.03),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Sub-widgets ───────────────────────────────────────────────────────────

  Widget _buildServicesButton(
      {required IconData icon,
      required String label,
      required Color ColorCode}) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: screenWidth * 0.178,
          height: screenWidth * 0.178,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(300),
            color: Color(0xFFFFFFFF),
          ),
          child: Icon(
            icon,
            size: MediaQuery.of(context).size.width * 0.072,
            color: ColorCode,
          ),
        ),
        SizedBox(height: screenHeight * 0.008),
        Center(
          child: Container(
            width: screenWidth * 0.178,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: screenWidth * 0.027,
                height: 1.04,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceAction({
    required String label,
    required Widget child,
    required VoidCallback onTap,
  }) {
    final tokens =
        Globals.wcagModeEnabled ? AppTokens.wcag : AppTokens.standard;
    final l10n = AppLocalizations.of(context)!;
    return Semantics(
      button: true,
      label: l10n.homeOpenService(label),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: tokens.minTapTargetSize,
            minHeight: tokens.minTapTargetSize,
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _FeedbackSummary() {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final l10n = AppLocalizations.of(context)!;
    return Container(
      child: Stack(
        children: [
          Container(
            width: screenWidth * 0.93333,
            margin: EdgeInsets.only(top: 22),
            padding:
                EdgeInsets.only(top: 28, left: 18, right: 18, bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.08),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: _isLoading
                ? Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Row(
                      children: [
                        Container(
                          width: screenWidth * 0.142,
                          height: screenWidth * 0.142,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              SizedBox(height: 8),
                              Container(
                                width: screenWidth * 0.4,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Row(
                    children: [
                      Container(
                        width: screenWidth * 0.142,
                        height: screenWidth * 0.142,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/FlexiFlowLogoWhite.png',
                            width: screenWidth * 0.066,
                            height: screenHeight * 0.066,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          Globals.brainActivityFeedbackText,
                          style: GoogleFonts.inter(
                            color: Color(0xFF2C2C2C),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 1.16,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
          ),
          // Blue overlapping label
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF1E88E5).withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              l10n.homeFeedbackSummary,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _StreakWidget() {
    double screenWidth = MediaQuery.of(context).size.width;
    final tokens = tokensOf(context);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      child: Stack(
        children: [
          Container(
            width: screenWidth * 0.93333,
            margin: EdgeInsets.only(top: 22),
            padding:
                EdgeInsets.only(top: 28, left: 18, right: 18, bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.08),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(children: [
              // Fire icon and number section
              Container(
                width: screenWidth * 0.25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: screenWidth * 0.15,
                      height: screenWidth * 0.15,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: Globals.isStreakActive
                              ? [Color(0xFFFF6B35), Color(0xFFFF8E53)]
                              : [Colors.grey[300]!, Colors.grey[400]!],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.local_fire_department,
                        color: Colors.white,
                        size: screenWidth * 0.08,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      l10n.homeStreakDaysCount('${Globals.streak}'),
                      style: GoogleFonts.inter(
                        color: Globals.isStreakActive
                            ? const Color(0xFFFF6B35)
                            : wcagColor(
                                context,
                                standard: Colors.grey[500]!,
                                wcag: tokens.textMuted,
                              ),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              // Bar chart section
              Expanded(
                child: Container(
                  height: screenWidth * 0.2,
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ...Globals.past10DaysBars
                                .map((val) => _buildBar(
                                    val,
                                    screenWidth,
                                    val == Globals.past10DaysBars.last))
                                .toList(),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        l10n.homeTimeSpentPastTenDays,
                        style: GoogleFonts.inter(
                          color: wcagColor(
                            context,
                            standard: Colors.grey[500]!,
                            wcag: tokens.textMuted,
                          ),
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
          // Blue overlapping label
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF1E88E5).withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              l10n.homeStreak,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(double heightFactor, double screenWidth, bool isLast) {
    bool isZero = heightFactor == 0.0;
    double minHeight = screenWidth * 0.015;
    double maxHeight = screenWidth * 0.12;
    double height = isZero ? minHeight : (maxHeight * heightFactor);
    if (height < minHeight) height = minHeight;

    return AnimatedContainer(
      duration: Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      width: screenWidth * 0.032,
      height: height,
      margin: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isZero
              ? [Colors.grey[300]!, Colors.grey[400]!]
              : (isLast && Globals.isStreakActive
                  ? [Color(0xFFFF8E53), Color(0xFFFF6B35)]
                  : [Color(0xFF64B5F6), Color(0xFF1E88E5)]),
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(6),
        boxShadow: !isZero
            ? [
                BoxShadow(
                  color: (isLast && Globals.isStreakActive
                          ? Color(0xFFFF6B35)
                          : Color(0xFF1E88E5))
                      .withOpacity(0.3),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                )
              ]
            : [],
      ),
    );
  }
}
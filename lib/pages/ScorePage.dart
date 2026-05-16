import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_kit/l10n/app_localizations.dart';

class ScorePage extends StatefulWidget {
  final int score;
  final int timeSpent;
  final int highScore;
  final String? aiFeedback;

  const ScorePage({
    super.key,
    required this.score,
    required this.timeSpent,
    required this.highScore,
    this.aiFeedback,
  });

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<int> _scoreAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _scoreAnimation = IntTween(begin: 0, end: widget.score).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: Column(
                      children: [
                        // Curved Blue Header
                        ClipPath(
                          clipper: HeaderClipper(),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.41,
                            width: double.infinity,
                            color: const Color(0xFF0096FF),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Transform.scale(
                                  scale: _scaleAnimation.value,
                                  child: Container(
                                    padding: const EdgeInsets.all(25.0),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                      'assets/trophy.png',
                                      width: 130,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        Opacity(
                          opacity: _opacityAnimation.value,
                          child: Text(
                            l10n.scoreCongratsYouScore,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),

                        const SizedBox(height: 4),

                        // Score Row
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '${_scoreAnimation.value}',
                                style: GoogleFonts.montserrat(
                                  fontSize: 110,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF005DAE),
                                  height: 1.0,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Opacity(
                                opacity: _opacityAnimation.value,
                                child: Text(
                                  l10n.scorePointsWord,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Opacity(
                          opacity: _opacityAnimation.value,
                          child: Text(
                            l10n.scoreInSeconds('${widget.timeSpent}'),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // High Score
                        Opacity(
                          opacity: _opacityAnimation.value,
                          child: Text(
                            l10n.scoreHighScore('${widget.highScore}'),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // AI Insights Section
                        Opacity(
                          opacity: _opacityAnimation.value,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF0F8FF),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: const Color(0xFF0096FF).withOpacity(0.3)),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF0096FF).withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  )
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.auto_awesome, color: Color(0xFF0096FF), size: 20),
                                      const SizedBox(width: 8),
                                      Text(
                                        "การวิเคราะห์ด้วย AI",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF005DAE),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    widget.aiFeedback ?? _generateFallbackFeedback(),
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 16,
                        ),
                        // Back Button - Wide with minimal side padding
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 6, 16, 24),
                          child: SizedBox(
                            width: double.infinity,
                            height: 68,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0096FF),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                l10n.goBack,
                                style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  String _generateFallbackFeedback() {
    if (widget.score > widget.highScore && widget.highScore > 0) {
      return "ยอดเยี่ยมมาก! คุณเพิ่งทำสถิติใหม่ ความเร็วในการประมวลผลและความจำของคุณดีขึ้นอย่างเห็นได้ชัด";
    } else if (widget.score > 80) {
      if (widget.timeSpent < 30) {
        return "ทำได้ดีมาก! ทั้งความแม่นยำและความเร็วของคุณอยู่ในระดับท็อปวันนี้ ทำต่อไปนะ";
      }
      return "ความแม่นยำดีมาก! เพื่อท้าทายตัวเองเพิ่มเติม ลองพยายามตัดสินใจให้เร็วขึ้นอีกนิดในครั้งหน้าโดยไม่ลดความแม่นยำลง";
    } else if (widget.score > 50) {
      return "ทำได้ดี! คุณกำลังก้าวหน้าอย่างมั่นคง มุ่งเน้นไปที่การจดจำรูปแบบเพื่อเพิ่มคะแนนและลดเวลาลงสองสามวินาที";
    } else {
      return "พยายามได้ดี! ความสม่ำเสมอคือกุญแจสำคัญในการฝึกสมองของคุณ การฝึกฝนเป็นประจำจะช่วยปรับปรุงความเร็วในการจดจำของคุณได้อย่างชัดเจน";
    }
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.8);
    var controlPoint = Offset(size.width / 2, size.height * 1.1);
    var endPoint = Offset(size.width, size.height * 0.8);
    path.quadraticBezierTo(
      controlPoint.dx,
      controlPoint.dy,
      endPoint.dx,
      endPoint.dy,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
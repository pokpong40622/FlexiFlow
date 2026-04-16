import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScorePage extends StatefulWidget {
  final int score;
  final int timeSpent;
  final int highScore;

  const ScorePage({
    super.key,
    required this.score,
    required this.timeSpent,
    required this.highScore,
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
                            'Congrats!  You score',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),

                        const SizedBox(height: 4),

                        // Score Row - Centering the score
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              // This SizedBox helps offset the "points" text
                              // to keep the number exactly in the center of the screen
                              const SizedBox(width: 60),
                              Text(
                                '${_scoreAnimation.value}',
                                style: GoogleFonts.montserrat(
                                  fontSize: 110,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF005DAE),
                                ),
                              ),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 60, // Match the offset width
                                child: Opacity(
                                  opacity: _opacityAnimation.value,
                                  child: Text(
                                    'points',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Opacity(
                          opacity: _opacityAnimation.value,
                          child: Text(
                            'in ${widget.timeSpent} seconds',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // High Score - Positioned just above the button
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'High score: ${widget.highScore}',
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 8,
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
                                'Back',
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
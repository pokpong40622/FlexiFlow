import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_kit/pages/HomePage.dart';

class ScorePage extends StatefulWidget {
  final int score;
  final int timeSpent;
  final int highScore;

  const ScorePage({
    super.key,
    this.score = 0,
    this.timeSpent = 0,
    this.highScore = 0,
  });

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1200), vsync: this);
    _scaleAnimation = CurvedAnimation(
        parent: _controller, curve: const Interval(0.0, 0.6, curve: Curves.elasticOut));
    _fadeAnimation = CurvedAnimation(
        parent: _controller, curve: const Interval(0.4, 1.0, curve: Curves.easeIn));
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
      backgroundColor: const Color(0xFFF0F4F8),
      body: Stack(
        children: [
          // Bubbly Background Elements
          Positioned(
            top: -50,
            right: -50,
            child: _buildBubble(200, const Color(0xFFB3E5FC).withOpacity(0.5)),
          ),
          Positioned(
            top: 100,
            left: -40,
            child: _buildBubble(150, const Color(0xFFFFCCBC).withOpacity(0.4)),
          ),
          Positioned(
            bottom: 80,
            right: -20,
            child: _buildBubble(120, const Color(0xFFC8E6C9).withOpacity(0.4)),
          ),
          Positioned(
            bottom: -60,
            left: 20,
            child: _buildBubble(180, const Color(0xFFFFF9C4).withOpacity(0.6)),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Header with Trophy
                Expanded(
                  flex: 4,
                  child: Center(
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.15),
                              blurRadius: 30,
                              spreadRadius: 10,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/trophy.png',
                          width: 140,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),

                // Score Section
                Expanded(
                  flex: 5,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Awesome Job!',
                          style: GoogleFonts.nunito(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF455A64),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: const Color(0xFFE1F5FE), width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF0288D1).withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                '${widget.score}',
                                style: GoogleFonts.nunito(
                                  fontSize: 80,
                                  fontWeight: FontWeight.w900,
                                  color: const Color(0xFF0288D1),
                                  height: 1,
                                ),
                              ),
                              Text(
                                'points',
                                style: GoogleFonts.nunito(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF78909C),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildStatChip(
                              icon: Icons.timer_outlined,
                              label: '${widget.timeSpent}s',
                              color: const Color(0xFFFFA726),
                              bgColor: const Color(0xFFFFF3E0),
                            ),
                            const SizedBox(width: 20),
                            _buildStatChip(
                              icon: Icons.emoji_events_outlined,
                              label: 'Best: ${widget.highScore}',
                              color: const Color(0xFFEF5350),
                              bgColor: const Color(0xFFFFEBEE),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Button Section
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SizedBox(
                      width: double.infinity,
                      height: 64,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF039BE5),
                          foregroundColor: Colors.white,
                          elevation: 8,
                          shadowColor: const Color(0xFF039BE5).withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        child: Text(
                          'Back to Home',
                          style: GoogleFonts.nunito(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBubble(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildStatChip({
    required IconData icon,
    required String label,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.nunito(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

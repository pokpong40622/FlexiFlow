import 'package:flexiflow/Pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScorePage extends StatelessWidget {
  const ScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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

          const SizedBox(height: 40),

          Text(
            'Congrats!  You score',
            style: GoogleFonts.montserrat(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 4),

          // Score Row - Centering the '9'
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              // This SizedBox helps offset the "points" text
              // to keep the "9" exactly in the center of the screen
              const SizedBox(width: 60),
              Text(
                '9',
                style: GoogleFonts.montserrat(
                  fontSize: 110,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF005DAE),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 60, // Match the offset width
                child: Text(
                  'points',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),

          Text(
            'in 90 seconds',
            style: GoogleFonts.montserrat(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),

          const Spacer(),

          // High Score - Positioned just above the button
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'High score: 10',
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
          ), // Minimal gap between high score and button
          // Back Button - Wide with minimal side padding
          Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              6,
              16,
              24,
            ), // Low horizontal padding (16)
            child: SizedBox(
              width: double.infinity,
              height: 68,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => HomePage(),
                    ),
                  );
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

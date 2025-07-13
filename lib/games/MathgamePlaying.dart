import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MathgamePlaying extends StatefulWidget {
  const MathgamePlaying({super.key});

  @override
  State<MathgamePlaying> createState() => _MathgamePlayingState();
}

class _MathgamePlayingState extends State<MathgamePlaying> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0425),
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.017),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          size: screenWidth * 0.066,
                          color: Colors.black,
                        ),
                        Text(
                          'Back',
                          style: GoogleFonts.inter(
                            fontSize: screenWidth * 0.0594,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.6), // Spacer
                        Icon(
                          Icons.info_outline,
                          size: screenWidth * 0.081,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.022),
                    Container(
                      width: screenWidth * 0.794,
                      height: screenHeight * 0.0818,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0397FD),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.32),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '41 + 14 = ?',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w800,
                          fontSize: screenWidth * 0.07,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.0286),
                    Container(
                      width: screenWidth * 0.88,
                      height: screenHeight * 0.558,
                      color: Colors.black,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  height: screenHeight * 0.27,
                  width: screenWidth * 1,
                  decoration: const BoxDecoration(
                    color: Color(0xFF0397FD),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: screenHeight * 0.07616,
                            width: screenWidth * 0.4515,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '23',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w800,
                                    fontSize: screenWidth * 0.072,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.01),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: screenHeight * 0.02,
                                  ),
                                  child: Text(
                                    'sec',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w800,
                                      fontSize: screenWidth * 0.034,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Exit button
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: screenHeight * 0.07616,
                              width: screenWidth * 0.4515,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                                color: Color(0xFFF1615D),
                              ),
                              child: Icon(
                                Icons.exit_to_app_outlined,
                                size: screenWidth * 0.072,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.032,
                      ), // Padding at the bottom
                    ],
                  ),
                ),
              ),
            ],
          ),

          // SCORE box
          Positioned(
            top: screenHeight * 0.692,
            left: (screenWidth * 1 - screenWidth * 0.346) / 2,
            child: Container(
              width: screenWidth * 0.346,
              height: screenHeight * 0.15958,
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.009),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Score',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      fontSize: screenWidth * 0.042,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '9',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w800,
                      fontSize: screenWidth * 0.11,
                      color: const Color(0xFF0262A4),
                      height: screenHeight * 0.00138,
                    ),
                  ),
                  Text(
                    'Pts',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      fontSize: screenWidth * 0.042,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

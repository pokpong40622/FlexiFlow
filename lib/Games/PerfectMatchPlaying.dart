import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PerfectMatchPlaying extends StatefulWidget {
  const PerfectMatchPlaying({super.key});

  @override
  State<PerfectMatchPlaying> createState() => _PerfectMatchPlayingState();
}

class _PerfectMatchPlayingState extends State<PerfectMatchPlaying> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
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
                        SizedBox(width: screenWidth * 0.6),
                        Icon(
                          Icons.info_outline,
                          size: screenWidth * 0.081,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.018),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: screenWidth * 0.12),
                        Text(
                          '23',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w800,
                            fontSize: screenWidth * 0.11,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsGeometry.only(
                            top: screenHeight * 0.029,
                            left: screenWidth * 0.012,
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
                    SizedBox(height: screenHeight * 0.022),
                    Container(
                      width: screenWidth * 0.8394,
                      height: screenHeight * 0.51,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsGeometry.only(
                          top: screenHeight * 0.096,
                          bottom: screenHeight * 0.0302,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Name: ',
                              style: GoogleFonts.montserrat(
                                fontSize: screenWidth * 0.054,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'L + fingertip pinch: ',
                              style: GoogleFonts.montserrat(
                                fontSize: screenWidth * 0.054,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: screenHeight * 0.07616,
                            width: screenWidth * 0.4515,
                            child: Icon(
                              Icons.pause_circle_outlined,
                              size: screenWidth * 0.072,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: screenHeight * 0.07616,
                              width: screenWidth * 0.4515,
                              child: Icon(
                                Icons.exit_to_app_outlined,
                                size: screenWidth * 0.072,
                                color: Colors.white,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                                color: Color(0xFFF1615D),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF0397FD),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28),
                    ),
                  ),
                ),
              ),
            ],
          ),

          //Do this Box
          Positioned(
            top: screenHeight * 0.072,
            right: screenWidth * 0.021,
            child: Container(
              width: screenWidth * 0.40462,
              height: screenHeight * 0.23035,
              padding: EdgeInsets.all(screenWidth * 0.0262),
              decoration: BoxDecoration(
                color: Color(0xFF0397FD),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'Do this',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      fontSize: screenWidth * 0.0516,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.008),
                  Container(
                    height: screenHeight * 0.159166,
                    width: screenWidth * 0.3462,
                    child: Expanded(
                      child: Image.asset(
                        'assets/DoctorGraphicExample1.png'
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // SCORE box
          Positioned(
            top: screenHeight * 0.634,
            left: (screenWidth * 1 - screenWidth * 0.346) / 2,
            child: Container(
              width: screenWidth * 0.346,
              height: screenHeight * 0.15958,
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.009),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
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
                      color: Color(0xFF0262A4),
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

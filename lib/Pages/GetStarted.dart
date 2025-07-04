import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Getstarted extends StatefulWidget {
  const Getstarted({super.key});

  @override
  State<Getstarted> createState() => _GetstartedState();
}

class _GetstartedState extends State<Getstarted> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: screenHeight * 0.03),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0425),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            'assets/FlexiFlowLogoFull.png',
                            width: screenWidth * 0.36,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.027),
                    Container(
                      width: screenWidth * 0.8981,
                      height: screenHeight * 0.73,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsGeometry.only(
                              top: screenHeight * 0.08,
                              bottom: screenHeight * 0.062,
                            ),
                            child: Text(
                              'L + Fingertip pinch',
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: screenWidth * 0.061,
                              ),
                            ),
                          ),
                          Container(
                            width: screenWidth * 0.56111,
                            height: screenHeight * 0.281363,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset('assets/DoctorExample.png'),
                          ),
                          SizedBox(height: screenHeight * 0.068),
                          Container(
                            child: Text(
                              'Enhances movements skills and hand-eye coordination.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: screenWidth * 0.050,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                height: screenHeight * 0.0018,
                              ),
                            ),
                            color: Colors.transparent,
                            width: screenWidth * 0.6,
                            height: screenHeight * 0.12,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsetsGeometry.only(
                            top: screenHeight * 0.027,
                            right: screenWidth * 0.026,
                          ),
                          child: Text(
                            '1/7',
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: screenWidth * 0.043,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.03),
              child: GestureDetector(
                onTap: () {
                  
                },
                child: Container(
                  width: screenWidth * 0.92,
                  height: screenHeight * 0.072,
                  decoration: BoxDecoration(
                    color: Color(0xFF0397FD),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      'Next',
                      style: GoogleFonts.inter(
                        fontSize: screenWidth * 0.044,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
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

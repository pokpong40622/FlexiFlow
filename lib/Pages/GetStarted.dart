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
              SizedBox(height: screenHeight * 0.033),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0425),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/FlexiFlowLogoFull.png',
                          width: screenWidth * 0.36,
                        )
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.029,),
                    Container(
                      width: screenWidth *0.8981,
                      height: screenHeight * 0.73,
                      decoration: BoxDecoration(
                        color: Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(12)
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.03),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
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
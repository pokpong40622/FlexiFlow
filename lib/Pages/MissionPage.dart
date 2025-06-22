import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MissionPage extends StatefulWidget {
  const MissionPage({super.key});

  @override
  State<MissionPage> createState() => _MissionPageState();
}

class _MissionPageState extends State<MissionPage> {
  int selectedButtonIndex = 0; 

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Column(
        children: [
          Container(
            width: screenWidth * 1,
            height: screenHeight * 0.195,
            color: const Color(0xFF0397FD),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: screenWidth * 0.066),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: screenHeight * 0.034),
                        Text(
                          'YOUR',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: screenWidth * 0.076,
                            color: Colors.white,
                            height: 1,
                          ),
                        ),
                        Text(
                          'MISSIONS',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: screenWidth * 0.076,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: screenWidth * 0.108),
                    Image.asset(
                      'assets/goldmedal.png', // Ensure you have this asset
                      width: screenWidth * 0.30,
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.0225),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedButtonIndex = 0;
                        });
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.50,
                            height: 30,
                            alignment: Alignment.topCenter,
                            child: Text(
                              'Daily',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w700,
                                  fontSize: screenWidth * 0.037,
                                  color: Colors.white),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.50,
                            height: 5.6,
                            color: selectedButtonIndex == 0
                                ? const Color(0xFFFFE07D)
                                : Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedButtonIndex = 1;
                        });
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.50,
                            height: 30,
                            alignment: Alignment.topCenter,
                            child: Text(
                              'All',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w700,
                                  fontSize: screenWidth * 0.037,
                                  color: Colors.white),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.50,
                            height: 5.6,
                            color: selectedButtonIndex == 1
                                ? const Color(0xFFFFE07D)
                                : Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.016,),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero, // Remove default ListView padding
              children: [
                _buildMissionItem(
                  context,
                  title: 'Add your profile picture',
                  coins: 40,
                  isCompleted: true,
                  borderColor: const Color(0xFF62DA30),
                ),
                _buildMissionItem(
                  context,
                  title: 'Start your first exercise',
                  coins: 50,
                  isCompleted: false,
                  borderColor: const Color(0xFF0397FD),
                ),
                _buildMissionItem(
                  context,
                  title: 'Start your first exercise',
                  coins: 50,
                  isCompleted: false,
                  borderColor: const Color(0xFFBBBBBB),
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionItem(
    BuildContext context, {
    required String title,
    required int coins,
    required bool isCompleted,
    required Color borderColor,
  }) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05, vertical: screenHeight * 0.01),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: borderColor,
            width: 3,
          ),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: screenWidth * 0.04,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    'Claim $coins Flexi Coin',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: screenWidth * 0.035,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: screenWidth * 0.03),
            isCompleted
                ? Icon(
                    Icons.check_box,
                    color: borderColor,
                    size: screenWidth * 0.07,
                  )
                : Icon(
                    Icons.check_box_outline_blank,
                    color: borderColor,
                    size: screenWidth * 0.07,
                  ),
          ],
        ),
      ),
    );
  }
}
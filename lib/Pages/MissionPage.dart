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
                        ),
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
                                color: Colors.white,
                              ),
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
                                color: Colors.white,
                              ),
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
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.016),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero, // Remove default ListView padding
              children: [
                _buildMissionItem(
                  context,
                  title: 'Add your profile picture',
                  coins: 40,
                  isCompleted: true,
                ),
                _buildMissionItem(
                  context,
                  title: 'Start your first exercise',
                  coins: 50,
                  isCompleted: false,
                ),
                _buildMissionItem(
                  context,
                  title: 'Start your first exercise',
                  coins: 50,
                  isCompleted: false,
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
  }) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenHeight * 0.012,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.12),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.045,
          vertical: screenHeight * 0.02,
        ),
        child: Row(
          children: [
            // Checkbox or Completion Badge
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted
                    ? const Color(0xFF62DA30).withOpacity(0.15)
                    : const Color(0xFFDDDDDD).withOpacity(0.3),
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(
                isCompleted ? Icons.check : Icons.check_box_outline_blank,
                color: isCompleted ? const Color(0xFF62DA30) : Colors.grey[500],
                size: screenWidth * 0.06,
              ),
            ),
            SizedBox(width: screenWidth * 0.04),

            // Text and Coin Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: screenWidth * 0.042,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF1D6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.03,
                          vertical: screenHeight * 0.005,
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/CoinsLogo.png',
                              width: screenWidth * 0.04,
                            ),
                            SizedBox(width: screenWidth * 0.012),
                            Text(
                              '+$coins Flexi Coin',
                              style: GoogleFonts.inter(
                                fontSize: screenWidth * 0.034,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFFFAA600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

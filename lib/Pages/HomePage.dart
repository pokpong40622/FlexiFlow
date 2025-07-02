import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override

  int activeIndex = 0; 

  void didChangeDependencies() {
  super.didChangeDependencies();

  final route = ModalRoute.of(context);
}
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    
    final List<String> slideImages = [

      'assets/ImagesliderFlexicoin.png',
      'assets/ImagesliderGrandma.png',
      'assets/ImagesliderGrandpa.png',
    ];

    

    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Fixed Header Section
          SizedBox(height: screenHeight * 0.025),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0425),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/FlexiFlowProfilePic.png',
                  width: screenWidth * 0.1453,
                ),
                Text(
                  'Home',
                  style: GoogleFonts.inter(
                    fontSize: screenWidth * 0.062,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Image.asset(
                  'assets/FlexiFlowLogoColor.png',
                  width: screenWidth * 0.13333,
                ),
              ],
            ),
          ),
          // Scrollable Content Section
          SizedBox(height: screenHeight * 0.026),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: screenHeight * 0.21836,
                      autoPlay: true,
                      viewportFraction: screenWidth * 0.808 / screenWidth,
                      onPageChanged: (index, reason) => setState(() {
                        activeIndex = index;
                      }),
                    ),
                    items: slideImages.map((slideImage) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ), //control the space between each image in the slide
                        child: Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              slideImage,
                              fit: BoxFit
                                  .cover, //make the image fit but not stretched i think (not sure)
                              width: double.infinity,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: screenHeight * 0.0134),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.043,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Services',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                fontSize: screenWidth * 0.054,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.0098),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildServicesButton(
                              icon: Icons.travel_explore,
                              label: "Discover Posture",
                            ),
                            _buildServicesButton(
                              icon: Icons.checklist,
                              label: "Check Posture",
                            ),
                            _buildServicesButton(
                              icon: Icons.support_agent,
                              label: "Chatbot",
                            ),
                            _buildServicesButton(
                              icon: Icons.shopping_cart_outlined,
                              label: "Shop",
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.019),
                        Row(
                          children: [
                            Text(
                              'Others',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                fontSize: screenWidth * 0.054,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.012),
                        _FeedbackSummary(),
                        SizedBox(height: screenHeight * 0.02),
                        _StreakWidget(),
                        SizedBox(height: screenHeight * 0.03),
                      ],
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

  //Widget section

  Widget _buildServicesButton({required IconData icon, required String label}) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: screenWidth * 0.178,
          height: screenWidth * 0.178,
          child: Icon(
            icon,
            size: MediaQuery.of(context).size.width * 0.072,
            color: Colors.black,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(300),
            color: Color(0xFFFFFFFF),
          ),
        ),
        SizedBox(height: screenHeight * 0.008),
        Center(
          child: Container(
            width: screenWidth * 0.178,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: screenWidth * 0.0286,
                height: 1.04,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _FeedbackSummary() {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Stack(
        children: [
          Container(
            width: screenWidth * 0.93333,
            margin: EdgeInsets.only(top: 22),
            padding: EdgeInsets.only(top: 28, left: 18, right: 18, bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.08),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: screenWidth * 0.142,
                  height: screenWidth * 0.142,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/FlexiFlowLogoWhite.png',
                      width: screenWidth * 0.066,
                      height: screenHeight * 0.066,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    'Your brain power has increased by 6% over the last 3 days',
                    style: GoogleFonts.inter(
                      color: Color(0xFF2C2C2C),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.16,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          ),
          // Blue overlapping container
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF1E88E5).withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              'Feedback Summary',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _StreakWidget() {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Stack(
        children: [
          Container(
            width: screenWidth * 0.93333,
            margin: EdgeInsets.only(top: 22),
            padding: EdgeInsets.only(top: 28, left: 18, right: 18, bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.08),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Fire icon and number section
                Container(
                  width: screenWidth * 0.25,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: screenWidth * 0.15,
                        height: screenWidth * 0.15,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFFF6B35), Color(0xFFFF8E53)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.local_fire_department,
                          color: Colors.white,
                          size: screenWidth * 0.08,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '67',
                        style: GoogleFonts.inter(
                          color: Color(0xFFFF6B35),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                // Bar chart section
                Expanded(
                  child: Container(
                    height: screenWidth * 0.2,
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              _buildBar(0.3, screenWidth),
                              _buildBar(0.5, screenWidth),
                              _buildBar(0.4, screenWidth),
                              _buildBar(0.6, screenWidth),
                              _buildBar(0.55, screenWidth),
                              _buildBar(0.7, screenWidth),
                              _buildBar(0.85, screenWidth),
                              _buildBar(1.0, screenWidth),
                              _buildBar(0.65, screenWidth),
                              _buildBar(0.75, screenWidth),
                              _buildBar(0.8, screenWidth),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Time used in the past 10 days',
                          style: GoogleFonts.inter(
                            color: Colors.grey[500],
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Blue overlapping container
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF1E88E5).withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              'Streak',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(double heightFactor, double screenWidth) {
    return Container(
      width: screenWidth * 0.025,
      height: (screenWidth * 0.12) * heightFactor,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF42A5F5), Color(0xFF1E88E5)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

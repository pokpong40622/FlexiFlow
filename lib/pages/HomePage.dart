import 'package:carousel_slider/carousel_slider.dart';
import 'package:motion_kit/fake_var.dart';
import 'package:motion_kit/figma/chatbot.dart';
import 'package:motion_kit/pages/LeaderboardPage.dart';
import 'package:motion_kit/pages/ProfilePage.dart';
import 'package:shimmer/shimmer.dart';
import 'package:motion_kit/theme/app_tokens.dart';
import 'package:motion_kit/theme/wcag_utils.dart';
import 'GetStarted.dart';
import 'ShopPage.dart';
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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.015,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Picture with subtle styling
                  Semantics(
                    button: true,
                    label: 'Open profile',
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ProfilePage()),
                        );
                      },
                      child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/FlexiFlowProfilePic.png',
                        width: screenWidth * 0.12,
                        height: screenWidth * 0.12,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                    ),
                  ),
                  // Title with improved styling
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Home',
                        style: GoogleFonts.inter(
                          fontSize: screenWidth * 0.065,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF2C2C2C),
                          letterSpacing: 0.5,
                        ),
                      ),
                      Container(
                        height: 2,
                        width: screenWidth * 0.1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                  // Logo with improved styling
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Image.asset(
                      'assets/FlexiFlowLogoColor.png',
                      width: screenWidth * 0.1,
                      height: screenWidth * 0.1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Scrollable Content Section
            SizedBox(height: screenHeight * 0.026),
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
                        fit: BoxFit.cover,
                        //make the image fit but not stretched i think (not sure)
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
                      _buildServiceAction(
                        label: "Discover Posture",
                        onTap: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => Getstarted(),
                            ),
                          );
                        },
                        child: _buildServicesButton(
                          icon: Icons.travel_explore,
                          label: "Discover Posture",
                          ColorCode: Color(0xFF0397FD),
                        ),
                      ),
                      _buildServiceAction(
                        label: "Leaderboard",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LeaderboardPage()),
                          );
                        },
                        child: _buildServicesButton(
                          icon: Icons.leaderboard,
                          label: "Leaderboard",
                          ColorCode: Color(0xFF0397FD),
                        ),
                      ),
                      _buildServiceAction(
                        label: "Chatbot",
                        onTap: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => ChatBotPage(),
                            ),
                          );
                        },
                        child: _buildServicesButton(
                          icon: Icons.support_agent,
                          label: "Chatbot",
                          ColorCode: Color(0xFF0397FD),
                        ),
                      ),
                      _buildServiceAction(
                        label: "Shop",
                        onTap: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => ShopPage(),
                            ),
                          );
                        },
                        child: _buildServicesButton(
                            icon: Icons.shopping_cart_outlined,
                            label: "Shop",
                            ColorCode: Color(0xFF0397FD)),
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
    );
  }

  //Widget section

  Widget _buildServicesButton(
      {required IconData icon,
      required String label,
      required Color ColorCode}) {
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
            color: ColorCode,
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
                fontSize: screenWidth * 0.027,
                height: 1.04,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceAction({
    required String label,
    required Widget child,
    required VoidCallback onTap,
  }) {
    final tokens = Globals.wcagModeEnabled ? AppTokens.wcag : AppTokens.standard;
    return Semantics(
      button: true,
      label: 'Open $label',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: tokens.minTapTargetSize,
            minHeight: tokens.minTapTargetSize,
          ),
          child: child,
        ),
      ),
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
            child: _isLoading
                ? Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Row(
                      children: [
                        Container(
                          width: screenWidth * 0.142,
                          height: screenWidth * 0.142,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              SizedBox(height: 8),
                              Container(
                                width: screenWidth * 0.4,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Row(
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
                          Globals.brainActivityFeedbackText,
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
    final tokens = tokensOf(context);

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
                            colors: Globals.isStreakActive ? [Color(0xFFFF6B35), Color(0xFFFF8E53)] : [Colors.grey[300]!, Colors.grey[400]!],
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
                          '${Globals.streak} days',
                          style: GoogleFonts.inter(
                          color: Globals.isStreakActive
                              ? const Color(0xFFFF6B35)
                              : wcagColor(
                                  context,
                                  standard: Colors.grey[500]!,
                                  wcag: tokens.textMuted,
                                ),
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
                              ...Globals.past10DaysBars.map((val) => _buildBar(val, screenWidth, val == Globals.past10DaysBars.last)).toList(),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Time spent in the past 10 days',
                          style: GoogleFonts.inter(
                            color: wcagColor(
                              context,
                              standard: Colors.grey[500]!,
                              wcag: tokens.textMuted,
                            ),
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

  Widget _buildBar(double heightFactor, double screenWidth, bool isLast) {
    bool isZero = heightFactor == 0.0;
    double minHeight = screenWidth * 0.015;
    double maxHeight = screenWidth * 0.12;
    double height = isZero ? minHeight : (maxHeight * heightFactor);
    if (height < minHeight) height = minHeight;

    return AnimatedContainer(
      duration: Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      width: screenWidth * 0.032,
      height: height,
      margin: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isZero 
              ? [Colors.grey[300]!, Colors.grey[400]!] 
              : (isLast && Globals.isStreakActive 
                  ? [Color(0xFFFF8E53), Color(0xFFFF6B35)] 
                  : [Color(0xFF64B5F6), Color(0xFF1E88E5)]),
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(6),
        boxShadow: !isZero ? [
          BoxShadow(
            color: (isLast && Globals.isStreakActive ? Color(0xFFFF6B35) : Color(0xFF1E88E5)).withOpacity(0.3),
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ] : [],
      ),
    );
  }
}

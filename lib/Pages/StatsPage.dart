import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class StatsPage extends StatefulWidget {
  StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  // State variable to manage the selected time filter (today, week, month)
  String _selectedTimeFilter = 'today';
  late Timer _timer;
  DateTime _currentDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Update time every second
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentDateTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDate(DateTime dateTime) {
    List<String> weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    String weekday = weekdays[dateTime.weekday - 1];
    String month = months[dateTime.month - 1];

    return '$weekday, ${dateTime.day} $month';
  }

  String _formatTime(DateTime dateTime) {
    String hour = dateTime.hour.toString().padLeft(2, '0');
    String minute = dateTime.minute.toString().padLeft(2, '0');
    return '${dateTime.year}  $hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    // Screen dimensions for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.046),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //statsrow
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: screenWidth * 0.3796,
                        height: screenHeight * 0.07291,
                        decoration: BoxDecoration(
                          color: Color(0xFF0397FD),
                          borderRadius: BorderRadius.circular(
                            screenWidth * 0.03,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Stats',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: screenWidth * 0.053,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: screenWidth * 0.02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              _formatDate(_currentDateTime),
                              style: GoogleFonts.inter(
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              _formatTime(_currentDateTime),
                              style: GoogleFonts.inter(
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //statsrow
                SizedBox(height: screenHeight * 0.022),
                //ai suggestion
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.0140),
                      child: Text(
                        'AI Suggestion',
                        style: GoogleFonts.inter(
                          fontSize: screenWidth * 0.048,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.933333,
                      height: screenHeight * 0.0991666,
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(screenWidth * 0.04),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: screenWidth * 0.1,
                            height: screenWidth * 0.1,
                            decoration: BoxDecoration(
                              color: Color(0xFF0397FD),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                'W',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.045,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.03),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: GoogleFonts.inter(
                                  fontSize: screenWidth * 0.04,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        'Try getting a little bit more score on ',
                                  ),
                                  TextSpan(
                                    text: 'minigame#1',
                                    style: GoogleFonts.inter(
                                      color: Color(0xFFE91E63),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                //ai suggestion
                // Recent and Brain Score/Steps Row
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Recent Section
                      Container(
                        width: screenWidth * 0.426,
                        height: screenHeight * 0.444,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            screenWidth * 0.04,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Recent',
                                style: GoogleFonts.inter(
                                  fontSize: screenWidth * 0.048,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.sentiment_neutral_outlined,
                                        size: screenWidth * 0.12,
                                        color: Colors.grey[400],
                                      ),
                                      SizedBox(height: screenHeight * 0.01),
                                      Text(
                                        'Nothing to\nshow',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.inter(
                                          color: Colors.grey[400],
                                          fontSize: screenWidth * 0.035,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(width: screenWidth * 0.05),

                      // Brain Score and Steps Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Brain Score
                          Container(
                            width: screenWidth * 0.427, // 480/1125 = 0.427
                            height: screenHeight * 0.206, // 432/2100 = 0.206
                            padding: EdgeInsets.all(screenWidth * 0.05),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                screenWidth * 0.04,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Brain score',
                                      style: GoogleFonts.inter(
                                        fontSize: screenWidth * 0.048,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Center(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '163',
                                          style: GoogleFonts.inter(
                                            fontSize: screenWidth * 0.08,
                                            fontWeight: FontWeight.w800,
                                            color: Color(0xFF0397FD),
                                          ),
                                        ),
                                        Text(
                                          ' pts',
                                          style: GoogleFonts.inter(
                                            fontSize: screenWidth * 0.03,
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: screenHeight * 0.03),

                          // Steps
                          Container(
                            width: screenWidth * 0.427, // 480/1125 = 0.427
                            height: screenHeight * 0.206, // 432/2100 = 0.206
                            padding: EdgeInsets.all(screenWidth * 0.05),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                screenWidth * 0.04,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Steps',
                                  style: GoogleFonts.inter(
                                    fontSize: screenWidth * 0.048,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '872',
                                          style: GoogleFonts.inter(
                                            fontSize: screenWidth * 0.08,
                                            fontWeight: FontWeight.w800,
                                            color: Color(0xFF0397FD),
                                          ),
                                        ),
                                        Text(
                                          ' steps',
                                          style: GoogleFonts.inter(
                                            fontSize: screenWidth * 0.035,
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
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
                // Time Used Section
                Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: screenWidth * 0.93240, // 1007/1125 = 0.895
                        height: screenHeight * 0.184166, // 442/2100 = 0.210
                        padding: EdgeInsets.all(screenWidth * 0.04),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            screenWidth * 0.04,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start  ,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Time Used',
                                  style: GoogleFonts.inter(
                                    fontSize: screenWidth * 0.048,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.038),
                                _buildTimeFilter(
                                  'today',
                                  _selectedTimeFilter == 'today',
                                  screenWidth,
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                _buildTimeFilter(
                                  'week',
                                  _selectedTimeFilter == 'week',
                                  screenWidth,
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                _buildTimeFilter(
                                  'month',
                                  _selectedTimeFilter == 'month',
                                  screenWidth,
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.018,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  '14',
                                  style: GoogleFonts.inter(
                                    fontSize: screenWidth * 0.118,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF0397FD),
                                  ),
                                ),
                                Text(
                                  ' min ',
                                  style: GoogleFonts.inter(
                                    fontSize: screenWidth * 0.06,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '51',
                                  style: GoogleFonts.inter(
                                    fontSize: screenWidth * 0.118,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF0397FD),
                                  ),
                                ),
                                Text(
                                  ' sec',
                                  style: GoogleFonts.inter(
                                    fontSize: screenWidth * 0.06,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeFilter(String text, bool isSelected, double screenWidth) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTimeFilter = text;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.03,
          vertical: screenWidth * 0.015,
        ),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF0397FD) : Colors.grey[200],
          borderRadius: BorderRadius.circular(screenWidth * 0.04),
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
            color: isSelected ? Colors.white : Colors.grey[600],
            fontSize: screenWidth * 0.03,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

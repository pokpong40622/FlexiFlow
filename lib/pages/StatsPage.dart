import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:async';
import 'dart:math';

import '../fake_var.dart';

class StatsPage extends StatefulWidget {
  StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  // State variable to manage the selected time filter (today, week, month)
  String _selectedTimeFilter = 'today';
  bool _isLoading = true;
  bool _isAISuggestionLoading = true;
  bool _isTimeFilterLoading = false;
  late Timer _timer;
  late Timer _suggestionTimer;
  int _currentSuggestionIndex = 0;
  DateTime _currentDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Update time every second
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _currentDateTime = DateTime.now();
        });
      }
    });

    // Rotate AI suggestion every 6 seconds
    _suggestionTimer = Timer.periodic(Duration(seconds: 6), (timer) {
      if (mounted) {
        setState(() {
          _currentSuggestionIndex = (_currentSuggestionIndex + 1) % 2;
        });
      }
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _isAISuggestionLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _suggestionTimer.cancel();
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

    int shownSecond = 0;
    int shownMinute = 0;
    int shownHour = 0;

    if (_selectedTimeFilter == 'today') {
      shownSecond = Globals.timeSpentTD % 60;
      shownMinute = (Globals.timeSpentTD ~/ 60) % 60;
      shownHour = Globals.timeSpentTD ~/ 3600;
    } else if (_selectedTimeFilter == 'week') {
      shownSecond = Globals.timeSpentWK % 60;
      shownMinute = (Globals.timeSpentWK ~/ 60) % 60;
      shownHour = Globals.timeSpentWK ~/ 3600;
    } else if (_selectedTimeFilter == 'month') {
      shownSecond = Globals.timeSpentMH % 60;
      shownMinute = (Globals.timeSpentMH ~/ 60) % 60;
      shownHour = Globals.timeSpentMH ~/ 3600;
    }

    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
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
                horizontal: screenWidth * 0.1,
                vertical: screenHeight * 0.015 + 4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title with improved styling
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Stats',
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
                  Column(
                    mainAxisSize: MainAxisSize.min,
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
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.046),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                              child: Image.asset(
                                'assets/FlexiFlowLogoWhite.png',
                                width: screenWidth * 0.05,
                                height: screenWidth * 0.05,
                              ),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.03),
                          Expanded(
                            child: _isAISuggestionLoading
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _buildSkeleton(
                                          screenWidth * 0.5, screenWidth * 0.04),
                                      SizedBox(height: screenWidth * 0.02),
                                      _buildSkeleton(
                                          screenWidth * 0.3, screenWidth * 0.04),
                                    ],
                                  )
                                : AnimatedSwitcher(
                                    // Apply a cubic easing curve
                                    switchInCurve: Curves.easeInOut,
                                    switchOutCurve: Curves.easeInOut,
                                    duration: const Duration(milliseconds: 400),
                                    layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
                                      return Stack(
                                        alignment: Alignment.centerLeft,
                                        children: <Widget>[
                                          ...previousChildren,
                                          if (currentChild != null) currentChild,
                                        ],
                                      );
                                    },
                                    transitionBuilder: (Widget child, Animation<double> animation) {
                                      final bool isNewText = (child.key as ValueKey<int>).value == _currentSuggestionIndex;
                                      return ClipRect(
                                        child: FadeTransition(
                                          opacity: animation,
                                          child: SlideTransition(
                                            position: Tween<Offset>(
                                              begin: Offset(0.0, isNewText ? -1.0 : 1.0),
                                              end: Offset.zero,
                                            ).animate(animation),
                                            child: child,
                                          ),
                                        ),
                                      );
                                    },
                                    child: RichText(
                                      key: ValueKey<int>(_currentSuggestionIndex),
                                      text: TextSpan(
                                        style: GoogleFonts.inter(
                                          fontSize: screenWidth * 0.04,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: _currentSuggestionIndex == 0
                                                ? 'Try getting a little bit more score on '
                                                : 'Might be a little bit faster on ',
                                          ),
                                          TextSpan(
                                            text: _currentSuggestionIndex == 0
                                                ? 'Perfect Match'
                                                : 'Sum It Up',
                                            style: GoogleFonts.inter(
                                              color: Color(0xFFE91E63),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
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
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.035,
                            vertical: screenWidth * 0.04,
                          ),
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
                              SizedBox(height: screenHeight * 0.012),
                              if (_isLoading)
                                Expanded(
                                  child: Column(
                                    children: [
                                      Expanded(
                                          child:
                                              _buildSkeleton(double.infinity, double.infinity)),
                                      SizedBox(height: screenHeight * 0.008),
                                      Expanded(
                                          child:
                                              _buildSkeleton(double.infinity, double.infinity)),
                                      SizedBox(height: screenHeight * 0.008),
                                      Expanded(
                                          child:
                                              _buildSkeleton(double.infinity, double.infinity)),
                                    ],
                                  ),
                                )
                              else if (Globals.exercisesList.isEmpty)
                                Expanded(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.sentiment_neutral_outlined,
                                          size: screenWidth * 0.12,
                                          color: Colors.grey[400],
                                        ),
                                        SizedBox(
                                            height: screenHeight * 0.01),
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
                                )
                              else
                                ..._buildRecentTiles(
                                    screenWidth, screenHeight),
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
                                    child: _isLoading
                                        ? _buildSkeleton(
                                            screenWidth * 0.25, screenWidth * 0.08)
                                        : Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.baseline,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${Globals.brainScore}',
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
                                    child: _isLoading
                                        ? _buildSkeleton(
                                            screenWidth * 0.25, screenWidth * 0.08)
                                        : Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.baseline,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${Globals.totalStepsTD}',
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
                                  'Time Spent',
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
                            if (_isLoading || _isTimeFilterLoading)
                              Row(
                                children: [
                                  Expanded(
                                      child: _buildSkeleton(
                                          double.infinity, screenWidth * 0.12)),
                                  SizedBox(width: screenWidth * 0.02),
                                  Expanded(
                                      child: _buildSkeleton(
                                          double.infinity, screenWidth * 0.12)),
                                  SizedBox(width: screenWidth * 0.02),
                                  Expanded(
                                      child: _buildSkeleton(
                                          double.infinity, screenWidth * 0.12)),
                                ],
                              )
                            else
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  if (shownHour != 0) ...[
                                    Text(
                                      '$shownHour',
                                      style: GoogleFonts.inter(
                                        fontSize: screenWidth * 0.118,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF0397FD),
                                      ),
                                    ),
                                    Text(
                                      ' hour ',
                                      style: GoogleFonts.inter(
                                        fontSize: screenWidth * 0.06,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                  Text(
                                    shownMinute.toString(),
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
                                    shownSecond.toString().padLeft(2, '0'),
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
        if (_selectedTimeFilter != text) {
          setState(() {
            _selectedTimeFilter = text;
            _isTimeFilterLoading = true;
          });
          
          Future.delayed(Duration(milliseconds: 500), () {
            if (mounted) {
              setState(() {
                _isTimeFilterLoading = false;
              });
            }
          });
        }
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

  Widget _buildSkeleton(double width, double height) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  // ── Recent-exercise tiles ─────────────────────────────────────────────────

  /// Returns up to 3 Expanded tiles that fill all remaining vertical space.
  List<Widget> _buildRecentTiles(double screenWidth, double screenHeight) {
    final exercises = Globals.exercisesList.reversed.take(3).toList();
    final List<Widget> tiles = [];

    for (int i = 0; i < exercises.length; i++) {
      if (i > 0) tiles.add(SizedBox(height: screenHeight * 0.008));
      tiles.add(
        Expanded(
          child: _buildRecentExerciseTile(
              exercises[i], screenWidth, screenHeight),
        ),
      );
    }
    return tiles;
  }

  Widget _buildRecentExerciseTile(
    ExerciseMetadata exercise,
    double screenWidth,
    double screenHeight,
  ) {
    final int mins = exercise.timeSpent ~/ 60;
    final int secs = exercise.timeSpent % 60;
    final String timeLabel =
        mins > 0 ? '${mins}m ${secs.toString().padLeft(2, '0')}s' : '${secs}s';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ── Background Image ──
            Image.asset(
              _exerciseAsset(exercise.type),
              fit: BoxFit.cover,
            ),

            // ── White Gradient Overlay ──
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.4, 1.0],
                  colors: [
                    Colors.white.withOpacity(0.0),
                    Colors.white.withOpacity(0.6),
                    Colors.white,
                  ],
                ),
              ),
            ),

            // ── Info Content (Bottom) ──
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.035),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Game Name
                    Text(
                      _exerciseLabel(exercise.type),
                      style: GoogleFonts.inter(
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    
                    // Time Row
                    Row(
                      children: [
                        Icon(Icons.access_time_rounded,
                            size: screenWidth * 0.03, color: Colors.grey[800]),
                        SizedBox(width: 4),
                        Text(
                          timeLabel,
                          style: GoogleFonts.inter(
                            fontSize: screenWidth * 0.028,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: screenHeight * 0.002),
                    
                    // Score Row
                    Row(
                      children: [
                        Icon(Icons.emoji_events_rounded,
                            size: screenWidth * 0.03, color: Colors.grey[800]),
                        SizedBox(width: 4),
                        Text(
                          '${exercise.score} pts',
                          style: GoogleFonts.inter(
                            fontSize: screenWidth * 0.028,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  String _exerciseLabel(ExerciseType type) {
    switch (type) {
      case ExerciseType.PerfectMatch:
        return 'Perfect Match';
      case ExerciseType.SumItUp:
        return 'Sum It Up';
      case ExerciseType.Wander:
        return 'Wander';
    }
  }

  String _exerciseAsset(ExerciseType type) {
    switch (type) {
      case ExerciseType.PerfectMatch:
        return 'assets/PerfectMatchLogo.png';
      case ExerciseType.SumItUp:
        return 'assets/SumItUpLogo.png';
      case ExerciseType.Wander:
        return 'assets/WanderLogo.png';
    }
  }
}
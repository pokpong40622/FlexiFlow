import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:motion_kit/services/gesture_classification.dart';
import '../services/hand_landmarker_service.dart';
import '../views/painters/hand_painter.dart';
import '../views/embedded_camera_view.dart';
import '../pages/ScorePage.dart';
import '../fake_var.dart';

enum MathGameLevel { easy, normal, hard, extreme }

class MathgamePlaying extends StatefulWidget {
  const MathgamePlaying({super.key});

  @override
  State<MathgamePlaying> createState() => _MathgamePlayingState();
}

class _MathgamePlayingState extends State<MathgamePlaying> with SingleTickerProviderStateMixin {
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  var _cameraLensDirection = CameraLensDirection.front;
  final GestureClassification _gestureClassification = GestureClassification();

  int _secondsRemaining = 90;
  int _score = 0;
  Timer? _gameTimer;
  Timer? _countdownTimer;
  bool _isPaused = false;
  bool _isResumeCountdown = false;
  int _resumeCountdownValue = 3;

  int _currentAnswer = 0;
  String _currentEquation = "";
  
  MathGameLevel? _selectedLevel;

  late AnimationController _flashController;

  @override
  void initState() {
    super.initState();
    _flashController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _flashController.dispose();
    _canProcess = false;
    _gameTimer?.cancel();
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _generateEquation() {
     var random = Random();
     if (_selectedLevel == null) return;

     if (_selectedLevel == MathGameLevel.extreme) {
       int type = random.nextInt(5);
       if (type == 0) {
         // Difference of Squares: A^2 - B^2
         int a, b, tempAnswer;
         do {
           a = random.nextInt(15) + 1; // 1 to 15
           b = random.nextInt(a + 1);  // 0 to a
           tempAnswer = (a * a) - (b * b);
         } while (tempAnswer > 99 || tempAnswer < 0);
         
         _currentAnswer = tempAnswer;
         if (mounted) setState(() => _currentEquation = "$a\u00B2 - $b\u00B2 = ?");
       } else if (type == 1) {
         // Perfect Square Trinomial: A^2 + 2AB + B^2
         int a = random.nextInt(8) + 1;
         int b = random.nextInt(9 - a) + 1; // ensures A + B <= 9, so (A+B)^2 <= 81
         int mid = 2 * a * b;
         _currentAnswer = (a + b) * (a + b);
         if (mounted) setState(() => _currentEquation = "$a\u00B2 + $mid + $b\u00B2 = ?");
       } else if (type == 2) {
         // Factorials
         int a = random.nextInt(2) + 3; // 3 or 4 (3! = 6, 4! = 24)
         int fact = (a == 3) ? 6 : 24;
         int operator = random.nextInt(2); // 0: +, 1: x
         if (operator == 0) {
           int b = random.nextInt(100 - fact);
           _currentAnswer = fact + b;
           if (mounted) setState(() => _currentEquation = "$a! + $b = ?");
         } else {
           int maxMultiplier = 99 ~/ fact;
           int b = random.nextInt(maxMultiplier + 1);
           _currentAnswer = fact * b;
           if (mounted) setState(() => _currentEquation = "$a! x $b = ?");
         }
       } else if (type == 3) {
         // Percentages
         List<int> percs = [10, 20, 25, 30, 40, 50, 60, 75, 80];
         int p = percs[random.nextInt(percs.length)];
         int maxN = (9900 ~/ p);
         int n;
         do {
            n = random.nextInt(maxN) + 1;
         } while ((p * n) % 100 != 0); // ensure integer result
         _currentAnswer = (p * n) ~/ 100;
         if (mounted) setState(() => _currentEquation = "$p% of $n = ?");
       } else {
         // Square Roots
         int x = random.nextInt(9) + 1; // 1 to 9
         int sq = x * x;
         int operator = random.nextInt(2); // 0: +, 1: x
         if (operator == 0) {
            int b = random.nextInt(100 - x);
            _currentAnswer = x + b;
            if (mounted) setState(() => _currentEquation = "\u221A$sq + $b = ?");
         } else {
            int maxB = 99 ~/ x;
            int b = random.nextInt(maxB + 1);
            _currentAnswer = x * b;
            if (mounted) setState(() => _currentEquation = "\u221A$sq x $b = ?");
         }
       }
     } else {
       _currentAnswer = random.nextInt(100); // 0 to 99
       
       if (_selectedLevel == MathGameLevel.easy) {
         int a = random.nextInt(_currentAnswer + 1);
         int b = _currentAnswer - a;
         if (mounted) setState(() => _currentEquation = "$a + $b = ?");
       } else if (_selectedLevel == MathGameLevel.normal) {
         bool isAdd = random.nextBool();
         if (isAdd) {
           int a = random.nextInt(_currentAnswer + 1);
           int b = _currentAnswer - a;
           if (mounted) setState(() => _currentEquation = "$a + $b = ?");
         } else {
           int b = random.nextInt(50);
           int a = _currentAnswer + b;
           if (mounted) setState(() => _currentEquation = "$a - $b = ?");
         }
       } else {
         int op = random.nextInt(4);
         if (op == 0) {
           int a = random.nextInt(_currentAnswer + 1);
           int b = _currentAnswer - a;
           if (mounted) setState(() => _currentEquation = "$a + $b = ?");
         } else if (op == 1) {
           int b = random.nextInt(50);
           int a = _currentAnswer + b;
           if (mounted) setState(() => _currentEquation = "$a - $b = ?");
         } else if (op == 2) {
           List<int> factors = [];
           for (int i = 1; i <= _currentAnswer; i++) {
             if (_currentAnswer % i == 0) factors.add(i);
           }
           if (factors.isEmpty || _currentAnswer == 0) {
             factors = [0];
             if (_currentAnswer != 0) factors = [1, _currentAnswer];
           }
           int a = factors[random.nextInt(factors.length)];
           int b = a == 0 ? random.nextInt(10) : _currentAnswer ~/ a;
           if (a == 0) _currentAnswer = 0;
           if (mounted) setState(() => _currentEquation = "$a x $b = ?");
         } else {
           int b = random.nextInt(10) + 1;
           int a = _currentAnswer * b;
           if (mounted) setState(() => _currentEquation = "$a ÷ $b = ?");
         }
       }
     }
  }

  void _startGameTimer() {
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_secondsRemaining > 0) {
            _secondsRemaining--;
          } else {
            _endGame();
          }
        });
      }
    });
  }

  void _endGame() {
    _gameTimer?.cancel();
    _canProcess = false;

    if (!Globals.isStreakActive) {
      Globals.isStreakActive = true;
      Globals.streak += 1;
    }

    Globals.timeSpentTD += 90 - _secondsRemaining;
    Globals.brainScore += _score;
    Globals.totalExercisesCompletedTD += 1;
    Globals.todayExercises.add(ExerciseMetadata(
      type: ExerciseType.SumItUp, // Assuming SumItUp is the type for Math Game
      timeSpent: 90 - _secondsRemaining,
      score: _score,
    ));
    
    Globals.save();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ScorePage(
          score: _score,
          timeSpent: 90 - _secondsRemaining,
          highScore: 33, // Pass actual high score logic if available
        ),
      ),
    );
  }

  void _pauseGame() {
    if (_isPaused || _isResumeCountdown) return;
    _gameTimer?.cancel();
    setState(() {
      _isPaused = true;
    });
  }

  void _resumeGame() {
    setState(() {
      _isPaused = false;
      _isResumeCountdown = true;
      _resumeCountdownValue = 3;
    });

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_resumeCountdownValue > 1) {
            _resumeCountdownValue--;
          } else {
            _countdownTimer?.cancel();
            _isResumeCountdown = false;
            _startGameTimer();
          }
        });
      }
    });
  }

  int? _gestureToNumber(GestureType type) {
    switch (type) {
      case GestureType.zero: return 0;
      case GestureType.one: return 1;
      case GestureType.two: return 2;
      case GestureType.three: return 3;
      case GestureType.four: return 4;
      case GestureType.five: return 5;
      case GestureType.six: return 6;
      case GestureType.seven: return 7;
      case GestureType.eight: return 8;
      case GestureType.nine: return 9;
      default: return null;
    }
  }

  void _selectLevel(MathGameLevel level) {
    setState(() {
      _selectedLevel = level;
    });
    _generateEquation();
    _startGameTimer();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    if (_selectedLevel == null) {
      return Scaffold(
        backgroundColor: const Color(0xFFF8FBFA),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: screenWidth * 0.12,
                        height: screenWidth * 0.12,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(screenWidth * 0.03),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x1A000000), // black with 10% opacity
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                          size: screenWidth * 0.06,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Sum It Up',
                          style: GoogleFonts.montserrat(
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.12), // Balances the row
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: screenHeight * 0.05),
                        Text(
                          'Select Difficulty',
                          style: GoogleFonts.montserrat(
                            fontSize: screenWidth * 0.07,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF0397FD),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          'Choose a level to start the game',
                          style: GoogleFonts.montserrat(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.06),
                        _buildLevelButton('Easy (Addition)', MathGameLevel.easy, screenWidth, screenHeight),
                        SizedBox(height: screenHeight * 0.025),
                        _buildLevelButton('Normal (+, -)', MathGameLevel.normal, screenWidth, screenHeight),
                        SizedBox(height: screenHeight * 0.025),
                        _buildLevelButton('Hard (+, -, x, ÷)', MathGameLevel.hard, screenWidth, screenHeight),
                        SizedBox(height: screenHeight * 0.025),
                        _buildLevelButton('Extreme (Advanced Math)', MathGameLevel.extreme, screenWidth, screenHeight),
                        SizedBox(height: screenHeight * 0.015),
                        Text(
                          '* Note: You might need a piece of paper for this one!',
                          style: GoogleFonts.montserrat(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: screenHeight * 0.05),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

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
                    SizedBox(height: screenHeight * 0.062),
                    SizedBox(height: screenHeight * 0.018),
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
                        _currentEquation, // dynamic equation
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w800,
                          fontSize: screenWidth * 0.07,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.0286),
                    // Camera View with Overlays
                    Container(
                      width: screenWidth * 0.88,
                      height: screenHeight * 0.558,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          children: [
                            EmbeddedCameraView(
                              customPaint: _customPaint,
                              onImage: _processImage,
                              initialCameraLensDirection: _cameraLensDirection,
                              onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
                            ),
                            AnimatedBuilder(
                              animation: _flashController,
                              builder: (context, child) {
                                return Container(
                                  color: Colors.green.withOpacity(_flashController.value * 0.7),
                                );
                              },
                            ),
                            if (_isPaused)
                              BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                child: Container(
                                  color: Colors.black.withOpacity(0.4),
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.pause_circle_filled,
                                          color: Colors.white,
                                          size: 80,
                                        ),
                                        SizedBox(height: 16),
                                        Text(
                                          'PAUSED',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 48,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            letterSpacing: 2.0,
                                            shadows: [
                                              Shadow(
                                                blurRadius: 10.0,
                                                color: Colors.black45,
                                                offset: Offset(2.0, 2.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            if (_isResumeCountdown)
                              BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                child: Container(
                                  color: Colors.black.withOpacity(0.2),
                                  child: Center(
                                    child: Text(
                                      '$_resumeCountdownValue',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 120,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 15.0,
                                            color: Colors.black45,
                                            offset: Offset(4.0, 4.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
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
                          GestureDetector(
                            onTap: _isPaused ? _resumeGame : _pauseGame,
                            child: Container(
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
                                    '$_secondsRemaining',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w800,
                                      fontSize: screenWidth * 0.072,
                                      color: _secondsRemaining <= 10 ? const Color(0xFFD32F2F) : Colors.black,
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
                                  // Play/Pause icon indicator
                                   SizedBox(width: screenWidth * 0.02),
                                   Icon(
                                      _isPaused ? Icons.play_arrow : Icons.pause,
                                      color: Colors.black54,
                                   ),
                                ],
                              ),
                            ),
                          ),
                          // Exit button
                          GestureDetector(
                            onTap: _endGame, // Use _endGame or Navigator.pop directly? _endGame saves data.
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
                    '$_score',
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

  Widget _buildLevelButton(String title, MathGameLevel level, double screenWidth, double screenHeight) {
    return GestureDetector(
      onTap: () => _selectLevel(level),
      child: Container(
        width: double.infinity,
        height: screenHeight * 0.085,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0397FD), Color(0xFF0262A4)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(screenWidth * 0.04),
          boxShadow: const [
            BoxShadow(
              color: Color(0x33000000), // black with 20% opacity
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    if (_isPaused || _isResumeCountdown) return;
    _isBusy = true;
    
    try {
      final detectedHands = await HandLandmarkerService.detectHandLandmarks(inputImage);
      
      int leftNum = -1;
      int rightNum = -1;
      bool leftFound = false;
      bool rightFound = false;
      
      for (var hand in detectedHands) {
        try {
           final gesture = _gestureClassification.checkGesture(hand);
           int? num = _gestureToNumber(gesture.type);
           
           if (num != null) {
              if (hand.handedness == Handedness.left) {
                  leftNum = num;
                  leftFound = true;
              } else {
                  rightNum = num;
                  rightFound = true;
              }
           }
        } catch (e) {
          debugPrint("Gesture check error: $e");
        }
      }
      
      if (leftFound && rightFound) {
          int userInput = rightNum * 10 + leftNum;
          if (userInput == _currentAnswer) {
             _score += 1;
             _flashController.forward(from: 0.0).then((_) async {
               await Future.delayed(const Duration(milliseconds: 100));
               if (mounted) {
                 _flashController.reverse();
               }
             });
             _generateEquation();
          }
      }

      if (inputImage.metadata?.size != null &&
          inputImage.metadata?.rotation != null) {

        final painter = HandPainter(
          detectedHands, 
          inputImage.metadata!.size,
          inputImage.metadata!.rotation,
          _cameraLensDirection,
          showLandmarkNumbers: true, 
        );
        _customPaint = CustomPaint(painter: painter);
        
      } else {
         _customPaint = null;
      }
    } catch (e) {
      debugPrint('Error: $e');
      _customPaint = null;
    }

    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}

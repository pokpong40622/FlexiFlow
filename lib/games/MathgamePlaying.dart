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
  
  late AnimationController _flashController;

  @override
  void initState() {
    super.initState();
    _flashController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 1000),
    );
    _generateEquation();
    _startGameTimer();
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
     _currentAnswer = random.nextInt(100); // 0 to 99
     
     // Generate random equation: A + B = Answer
     int a = random.nextInt(_currentAnswer + 1); // 0 to Answer
     int b = _currentAnswer - a;
     
     if (mounted) {
       setState(() {
         _currentEquation = "$a + $b = ?";
       });
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

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

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

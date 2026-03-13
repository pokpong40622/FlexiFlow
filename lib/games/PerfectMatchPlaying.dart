import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:motion_kit/services/gesture_classification.dart';
import '../services/hand_landmarker_service.dart';
import '../views/painters/hand_painter.dart';
import '../views/embedded_camera_view.dart';
import '../pages/ScorePage.dart';
import '../fake_var.dart';
import 'dart:math';

class HandPose {
  final bool isFlipped; // true if left hand is flipped, false if right hand is flipped
  final GestureType leftGestureType;
  final GestureType rightGestureType;
  final String imagePath;

  HandPose({
    required this.isFlipped,
    required this.leftGestureType,
    required this.rightGestureType,
    required this.imagePath,
  });
}

List<HandPose> predefinedPoses = [
  HandPose(leftGestureType: GestureType.jeep, rightGestureType: GestureType.seven, isFlipped: false, imagePath: 'assets/hand/PinchSeven.png'),
  HandPose(leftGestureType: GestureType.jeep, rightGestureType: GestureType.seven, isFlipped: true, imagePath: 'assets/hand/PinchSeven.png'),
  HandPose(leftGestureType: GestureType.six, rightGestureType: GestureType.pinky, isFlipped: false, imagePath: 'assets/hand/SixKoi.png'),
  HandPose(leftGestureType: GestureType.six, rightGestureType: GestureType.pinky, isFlipped: true, imagePath: 'assets/hand/SixKoi.png'),
  HandPose(leftGestureType: GestureType.one, rightGestureType: GestureType.one, isFlipped: false, imagePath: 'assets/hand/OneOne.png'),
  HandPose(leftGestureType: GestureType.one, rightGestureType: GestureType.one, isFlipped: true, imagePath: 'assets/hand/OneOne.png'),
  HandPose(leftGestureType: GestureType.one, rightGestureType: GestureType.two, isFlipped: false, imagePath: 'assets/hand/OneTwo.png'),
  HandPose(leftGestureType: GestureType.one, rightGestureType: GestureType.two, isFlipped: true, imagePath: 'assets/hand/OneTwo.png'),
  HandPose(leftGestureType: GestureType.one, rightGestureType: GestureType.three, isFlipped: false, imagePath: 'assets/hand/OneThree.png'),
  HandPose(leftGestureType: GestureType.one, rightGestureType: GestureType.three, isFlipped: true, imagePath: 'assets/hand/OneThree.png'),
  HandPose(leftGestureType: GestureType.one, rightGestureType: GestureType.four, isFlipped: false, imagePath: 'assets/hand/OneFour.png'),
  HandPose(leftGestureType: GestureType.one, rightGestureType: GestureType.four, isFlipped: true, imagePath: 'assets/hand/OneFour.png'),
  HandPose(leftGestureType: GestureType.one, rightGestureType: GestureType.five, isFlipped: false, imagePath: 'assets/hand/OneFive.png'),
  HandPose(leftGestureType: GestureType.one, rightGestureType: GestureType.five, isFlipped: true, imagePath: 'assets/hand/OneFive.png'),
  HandPose(leftGestureType: GestureType.one, rightGestureType: GestureType.six, isFlipped: false, imagePath: 'assets/hand/OneSix.png'),
  HandPose(leftGestureType: GestureType.one, rightGestureType: GestureType.six, isFlipped: true, imagePath: 'assets/hand/OneSix.png'),
  HandPose(leftGestureType: GestureType.one, rightGestureType: GestureType.seven, isFlipped: false, imagePath: 'assets/hand/OneSeven.png'),
  HandPose(leftGestureType: GestureType.one, rightGestureType: GestureType.seven, isFlipped: true, imagePath: 'assets/hand/OneSeven.png'),
  HandPose(leftGestureType: GestureType.one, rightGestureType: GestureType.eight, isFlipped: false, imagePath: 'assets/hand/OneEight.png'),
  HandPose(leftGestureType: GestureType.one, rightGestureType: GestureType.eight, isFlipped: true, imagePath: 'assets/hand/OneEight.png'),
  HandPose(leftGestureType: GestureType.one, rightGestureType: GestureType.nine, isFlipped: false, imagePath: 'assets/hand/OneNine.png'),
  HandPose(leftGestureType: GestureType.one, rightGestureType: GestureType.nine, isFlipped: true, imagePath: 'assets/hand/OneNine.png'),
  HandPose(leftGestureType: GestureType.one, rightGestureType: GestureType.five, isFlipped: false, imagePath: 'assets/hand/OneFive.png'),
  HandPose(leftGestureType: GestureType.one, rightGestureType: GestureType.five, isFlipped: true, imagePath: 'assets/hand/OneFive.png'),
];

class PerfectMatchPlaying extends StatefulWidget {

  const PerfectMatchPlaying({super.key});

  @override
  State<PerfectMatchPlaying> createState() => _PerfectMatchPlayingState();
}

class _PerfectMatchPlayingState extends State<PerfectMatchPlaying> with SingleTickerProviderStateMixin {
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

  int currentPoseIndex = 0;
  late AnimationController _flashController;

  @override
  void initState() {
    super.initState();
    _flashController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 1000),
    );
    var random = Random();
    currentPoseIndex = random.nextInt((predefinedPoses.length/2).floor()) * 2; // Ensure we start with a non-flipped pose
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
    Globals.todayExercises.add(ExerciseMetadata(
      type: ExerciseType.PerfectMatch,
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
          highScore: 46,
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

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: screenWidth * 0.12),
                        Text(
                          '$_secondsRemaining',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w800,
                            fontSize: screenWidth * 0.11,
                            color: _secondsRemaining <= 10 ? Color(0xFFD32F2F) : Colors.black,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: screenHeight * 0.029,
                            left: screenWidth * 0.012,
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
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.022),
                    // Placeholder for the video feed
                    Container(
                      width: screenWidth * 0.8394,
                      height: screenHeight * 0.51,
                      color: Colors.black,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.096,
                          bottom: screenHeight * 0.0302,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Name: ',
                              style: GoogleFonts.montserrat(
                                fontSize: screenWidth * 0.054,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'L + fingertip pinch: ',
                              style: GoogleFonts.montserrat(
                                fontSize: screenWidth * 0.054,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: _isPaused ? _resumeGame : _pauseGame,
                            child: Container(
                              height: screenHeight * 0.07616,
                              width: screenWidth * 0.4515,
                              child: Icon(
                                _isPaused ? Icons.play_circle_outlined : Icons.pause_circle_outlined,
                                size: screenWidth * 0.072,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                ),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: _endGame,
                            child: Container(
                              height: screenHeight * 0.07616,
                              width: screenWidth * 0.4515,
                              child: Icon(
                                Icons.exit_to_app_outlined,
                                size: screenWidth * 0.072,
                                color: Colors.white,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                                color: Color(0xFFF1615D),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF0397FD),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28),
                    ),
                  ),
                ),
              ),
            ],
          ),

          //Do this Box
          Positioned(
            top: screenHeight * 0.072,
            right: screenWidth * 0.021,
            child: Container(
              width: screenWidth * 0.40462,
              height: screenHeight * 0.23035,
              padding: EdgeInsets.all(screenWidth * 0.0262),
              decoration: BoxDecoration(
                color: Color(0xFF0397FD),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'Do this',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      fontSize: screenWidth * 0.0516,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.008),
                  Container(
                    height: screenHeight * 0.159166,
                    width: screenWidth * 0.3462,
                    // REMOVED Expanded here
                    child: Transform.flip(
                      flipX: !predefinedPoses[currentPoseIndex].isFlipped, // Flips the child horizontally along the X-axis
                      child: Image.asset(
                        predefinedPoses[currentPoseIndex].imagePath,
                        fit: BoxFit.contain, // Add this if you want it to scale nicely within the container
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // SCORE box
          Positioned(
            top: screenHeight * 0.634,
            left: (screenWidth * 1 - screenWidth * 0.346) / 2,
            child: Container(
              width: screenWidth * 0.346,
              height: screenHeight * 0.15958,
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.009),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
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
                      color: Color(0xFF0262A4),
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
      bool leftMatch = false;
      bool rightMatch = false;
      print(predefinedPoses[currentPoseIndex].leftGestureType);
      print(predefinedPoses[currentPoseIndex].rightGestureType);
      print(predefinedPoses[currentPoseIndex].isFlipped);
      for (var hand in detectedHands) {
        try {
          if (hand.handedness == Handedness.left) {
            leftMatch = _gestureClassification.checkGesture(hand).type == predefinedPoses[currentPoseIndex].leftGestureType &&
                        !predefinedPoses[currentPoseIndex].isFlipped ||
                        _gestureClassification.checkGesture(hand).type == predefinedPoses[currentPoseIndex].rightGestureType &&
                        predefinedPoses[currentPoseIndex].isFlipped;
          } else {
            rightMatch = _gestureClassification.checkGesture(hand).type == predefinedPoses[currentPoseIndex].rightGestureType &&
                         !predefinedPoses[currentPoseIndex].isFlipped ||
                         _gestureClassification.checkGesture(hand).type == predefinedPoses[currentPoseIndex].leftGestureType &&
                         predefinedPoses[currentPoseIndex].isFlipped;
          }
          final gesture = _gestureClassification.checkGesture(hand);
        } catch (e) {
          // Interpreter might not be ready
        }
      }
      if (leftMatch && rightMatch) {
        _score += 1;
        currentPoseIndex = (currentPoseIndex + 1) % predefinedPoses.length;
        _flashController.forward(from: 0.0).then((_) async {
          await Future.delayed(const Duration(milliseconds: 100));
          if (mounted) {
            _flashController.reverse();
          }
        });
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

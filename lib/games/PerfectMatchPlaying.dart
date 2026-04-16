import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:motion_kit/services/gesture_classification.dart';
import 'package:motion_kit/theme/wcag_utils.dart';
import '../services/hand_landmarker_service.dart';
import '../views/painters/hand_painter.dart';
import '../views/embedded_camera_view.dart';
import '../pages/ScorePage.dart';
import '../fake_var.dart';
import 'dart:math';

class HandPose {
  final bool
      isFlipped; // true if left hand is flipped, false if right hand is flipped
  final GestureType leftGestureType;
  final GestureType rightGestureType;
  final String imagePath;
  final String name;

  HandPose({
    required this.isFlipped,
    required this.leftGestureType,
    required this.rightGestureType,
    required this.imagePath,
    required this.name,
  });
}

List<HandPose> predefinedPoses = [
  HandPose(
      leftGestureType: GestureType.jeep,
      rightGestureType: GestureType.seven,
      isFlipped: false,
      imagePath: 'assets/hand/PinchSeven.png',
      name: 'L + Fingertip pinch'),
  HandPose(
      leftGestureType: GestureType.jeep,
      rightGestureType: GestureType.seven,
      isFlipped: true,
      imagePath: 'assets/hand/PinchSeven.png',
      name: 'Fingertip pinch + L'),
  HandPose(
      leftGestureType: GestureType.six,
      rightGestureType: GestureType.pinky,
      isFlipped: false,
      imagePath: 'assets/hand/SixKoi.png',
      name: 'Thumb + Pinky'),
  HandPose(
      leftGestureType: GestureType.six,
      rightGestureType: GestureType.pinky,
      isFlipped: true,
      imagePath: 'assets/hand/SixKoi.png',
      name: 'Pinky + Thumb'),
  HandPose(
      leftGestureType: GestureType.one,
      rightGestureType: GestureType.one,
      isFlipped: false,
      imagePath: 'assets/hand/OneOne.png',
      name: 'Point + One'),
  HandPose(
      leftGestureType: GestureType.one,
      rightGestureType: GestureType.one,
      isFlipped: true,
      imagePath: 'assets/hand/OneOne.png',
      name: 'One + Point'),
  HandPose(
      leftGestureType: GestureType.one,
      rightGestureType: GestureType.two,
      isFlipped: false,
      imagePath: 'assets/hand/OneTwo.png',
      name: 'Point + Two'),
  HandPose(
      leftGestureType: GestureType.one,
      rightGestureType: GestureType.two,
      isFlipped: true,
      imagePath: 'assets/hand/OneTwo.png',
      name: 'Two + Point'),
  HandPose(
      leftGestureType: GestureType.one,
      rightGestureType: GestureType.three,
      isFlipped: false,
      imagePath: 'assets/hand/OneThree.png',
      name: 'Point + Three'),
  HandPose(
      leftGestureType: GestureType.one,
      rightGestureType: GestureType.three,
      isFlipped: true,
      imagePath: 'assets/hand/OneThree.png',
      name: 'Three + Point'),
  HandPose(
      leftGestureType: GestureType.one,
      rightGestureType: GestureType.four,
      isFlipped: false,
      imagePath: 'assets/hand/OneFour.png',
      name: 'Point + Four'),
  HandPose(
      leftGestureType: GestureType.one,
      rightGestureType: GestureType.four,
      isFlipped: true,
      imagePath: 'assets/hand/OneFour.png',
      name: 'Four + Point'),
  HandPose(
      leftGestureType: GestureType.one,
      rightGestureType: GestureType.five,
      isFlipped: false,
      imagePath: 'assets/hand/OneFive.png',
      name: 'Point + Five'),
  HandPose(
      leftGestureType: GestureType.one,
      rightGestureType: GestureType.five,
      isFlipped: true,
      imagePath: 'assets/hand/OneFive.png',
      name: 'Five + Point'),
  HandPose(
      leftGestureType: GestureType.one,
      rightGestureType: GestureType.six,
      isFlipped: false,
      imagePath: 'assets/hand/OneSix.png',
      name: 'Point + Six'),
  HandPose(
      leftGestureType: GestureType.one,
      rightGestureType: GestureType.six,
      isFlipped: true,
      imagePath: 'assets/hand/OneSix.png',
      name: 'Six + Point'),
  HandPose(
      leftGestureType: GestureType.one,
      rightGestureType: GestureType.seven,
      isFlipped: false,
      imagePath: 'assets/hand/OneSeven.png',
      name: 'Point + Seven'),
  HandPose(
      leftGestureType: GestureType.one,
      rightGestureType: GestureType.seven,
      isFlipped: true,
      imagePath: 'assets/hand/OneSeven.png',
      name: 'Seven + Point'),
  HandPose(
      leftGestureType: GestureType.one,
      rightGestureType: GestureType.eight,
      isFlipped: false,
      imagePath: 'assets/hand/OneEight.png',
      name: 'Point + Eight'),
  HandPose(
      leftGestureType: GestureType.one,
      rightGestureType: GestureType.eight,
      isFlipped: true,
      imagePath: 'assets/hand/OneEight.png',
      name: 'Eight + Point'),
  HandPose(
      leftGestureType: GestureType.one,
      rightGestureType: GestureType.nine,
      isFlipped: false,
      imagePath: 'assets/hand/OneNine.png',
      name: 'Point + Nine'),
  HandPose(
      leftGestureType: GestureType.one,
      rightGestureType: GestureType.nine,
      isFlipped: true,
      imagePath: 'assets/hand/OneNine.png',
      name: 'Nine + Point'),
  HandPose(
      leftGestureType: GestureType.one,
      rightGestureType: GestureType.five,
      isFlipped: false,
      imagePath: 'assets/hand/OneFive.png',
      name: 'Point + Ten'),
  HandPose(
      leftGestureType: GestureType.one,
      rightGestureType: GestureType.five,
      isFlipped: true,
      imagePath: 'assets/hand/OneFive.png',
      name: 'Ten + Point'),
];

class PerfectMatchPlaying extends StatefulWidget {
  const PerfectMatchPlaying({super.key});

  @override
  State<PerfectMatchPlaying> createState() => _PerfectMatchPlayingState();
}

class _PerfectMatchPlayingState extends State<PerfectMatchPlaying>
    with TickerProviderStateMixin {
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
  late AnimationController _fallController;

  // --- Gimmick: Combo Multiplier ---
  int _comboCounter = 0;
  double _comboTimeRemaining = 0.0;
  Timer? _comboTimerTick;
  final double _maxComboTime = 3.0; // 3 seconds to keep combo alive

  @override
  void initState() {
    super.initState();
    _flashController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 1000),
    );
    _fallController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    var random = Random();
    currentPoseIndex = random.nextInt((predefinedPoses.length / 2).floor()) *
        2; // Ensure we start with a non-flipped pose
    _startGameTimer();

    // Start combo countdown timer
    _comboTimerTick =
        Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_isPaused || _isResumeCountdown) return;

      if (_comboTimeRemaining > 0) {
        setState(() {
          _comboTimeRemaining -= 0.1;
          if (_comboTimeRemaining <= 0) {
            _comboTimeRemaining = 0;
            _comboCounter = 0; // Reset combo if time runs out
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _flashController.dispose();
    _fallController.dispose();
    _canProcess = false;
    _gameTimer?.cancel();
    _comboTimerTick?.cancel();
    _countdownTimer?.cancel();
    super.dispose();
  }

  String _getIndividualHandImage(GestureType type) {
    switch (type) {
      case GestureType.jeep:
        return 'assets/hand/individual/Pinch.png';
      case GestureType.pinky:
        return 'assets/hand/individual/Koi.png';
      case GestureType.one:
        return 'assets/hand/individual/One.png';
      case GestureType.two:
        return 'assets/hand/individual/Two.png';
      case GestureType.three:
        return 'assets/hand/individual/Three.png';
      case GestureType.four:
        return 'assets/hand/individual/Four.png';
      case GestureType.five:
        return 'assets/hand/individual/Five.png';
      case GestureType.six:
        return 'assets/hand/individual/Six.png';
      case GestureType.seven:
        return 'assets/hand/individual/Seven.png';
      case GestureType.eight:
        return 'assets/hand/individual/Eight.png';
      case GestureType.nine:
        return 'assets/hand/individual/Nine.png';
      default:
        return 'assets/hand/individual/One.png';
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
    Globals.exercisesList.add(ExerciseMetadata(
      type: ExerciseType.PerfectMatch,
      timeSpent: 90 - _secondsRemaining,
      score: _score,
      timestamp: DateTime.now(),
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
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;
    final tokens = tokensOf(context);
    final gameplayTextScale = mediaQuery.textScaler
        .scale(1.0)
        .clamp(1.0, 1.15)
        .toDouble();

    return MediaQuery(
      data: mediaQuery.copyWith(textScaler: TextScaler.linear(gameplayTextScale)),
      child: Scaffold(
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
                            color: _secondsRemaining <= 10
                                ? Color(0xFFD32F2F)
                                : Colors.black,
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
                              onCameraLensDirectionChanged: (value) =>
                                  _cameraLensDirection = value,
                            ),
                            AnimatedBuilder(
                              animation: _flashController,
                              builder: (context, child) {
                                return Container(
                                  color: Colors.green.withOpacity(
                                      _flashController.value * 0.7),
                                );
                              },
                            ),
                            if (_isPaused)
                              BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
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
                                filter:
                                    ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
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
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
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
                                '${predefinedPoses[currentPoseIndex].name}: ',
                                style: GoogleFonts.montserrat(
                                  fontSize: screenWidth * 0.054,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: _isPaused ? _resumeGame : _pauseGame,
                            child: WcagTapTarget(
                              compact: false,
                              child: Container(
                              height: screenHeight * 0.07616,
                              width: screenWidth * 0.4515,
                              child: Icon(
                                _isPaused
                                    ? Icons.play_circle_outlined
                                    : Icons.pause_circle_outlined,
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
                          ),
                          GestureDetector(
                            onTap: _endGame,
                            child: WcagTapTarget(
                              compact: false,
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

          // Falling Hands Animation
          AnimatedBuilder(
            animation: _fallController,
            builder: (context, child) {
              double fallY = Tween<double>(begin: -200, end: screenHeight)
                  .evaluate(_fallController);

              var currentPose = predefinedPoses[currentPoseIndex];
              var leftScreenGesture = !currentPose.isFlipped
                  ? currentPose.rightGestureType
                  : currentPose.leftGestureType;
              var rightScreenGesture = !currentPose.isFlipped
                  ? currentPose.leftGestureType
                  : currentPose.rightGestureType;

              return Stack(
                children: [
                  Positioned(
                    top: fallY,
                    left: screenWidth * 0.15,
                    child: Container(
                      width: screenWidth * 0.3,
                      height: screenWidth * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 8)
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          _getIndividualHandImage(leftScreenGesture),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: fallY,
                    right: screenWidth * 0.15,
                    child: Container(
                      width: screenWidth * 0.3,
                      height: screenWidth * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 8)
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          _getIndividualHandImage(rightScreenGesture),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // COMBO GIMMICK UI
          if (_comboCounter > 1)
            Positioned(
              top: screenHeight * 0.35,
              right: screenWidth * 0.05,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _comboTimeRemaining > 0 ? 1.0 : 0.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'COMBO x${1 + (_comboCounter ~/ 3)}',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w900,
                        fontSize: screenWidth * 0.08,
                        color: wcagColor(
                          context,
                          standard: Colors.orangeAccent,
                          wcag: tokens.textReward,
                        ),
                        shadows: [
                          const Shadow(
                            color: Colors.red,
                            blurRadius: 10,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '$_comboCounter Hits!',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w700,
                        fontSize: screenWidth * 0.04,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    // Combo Timer Bar
                    Container(
                      width: screenWidth * 0.3,
                      height: screenHeight * 0.01,
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerRight,
                        widthFactor: (_comboTimeRemaining / _maxComboTime)
                            .clamp(0.0, 1.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: _comboTimeRemaining < 1.0
                                ? Colors.red
                                : wcagColor(
                                    context,
                                    standard: Colors.orangeAccent,
                                    wcag: tokens.textReward,
                                  ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
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
                  FittedBox(
                    fit: BoxFit.scaleDown,
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
                ],
              ),
            ),
          ),
        ],
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
      final detectedHands =
          await HandLandmarkerService.detectHandLandmarks(inputImage);
      bool leftMatch = false;
      bool rightMatch = false;
      print(predefinedPoses[currentPoseIndex].leftGestureType);
      print(predefinedPoses[currentPoseIndex].rightGestureType);
      print(predefinedPoses[currentPoseIndex].isFlipped);
      for (var hand in detectedHands) {
        try {
          if (hand.handedness == Handedness.left) {
            leftMatch = _gestureClassification.checkGesture(hand).type ==
                        predefinedPoses[currentPoseIndex].leftGestureType &&
                    !predefinedPoses[currentPoseIndex].isFlipped ||
                _gestureClassification.checkGesture(hand).type ==
                        predefinedPoses[currentPoseIndex].rightGestureType &&
                    predefinedPoses[currentPoseIndex].isFlipped;
          } else {
            rightMatch = _gestureClassification.checkGesture(hand).type ==
                        predefinedPoses[currentPoseIndex].rightGestureType &&
                    !predefinedPoses[currentPoseIndex].isFlipped ||
                _gestureClassification.checkGesture(hand).type ==
                        predefinedPoses[currentPoseIndex].leftGestureType &&
                    predefinedPoses[currentPoseIndex].isFlipped;
          }
        } catch (e) {
          // Interpreter might not be ready
        }
      }
      if (leftMatch && rightMatch) {
        // --- Combo Gimmick logic ---
        _comboCounter++;
        _comboTimeRemaining = _maxComboTime; // Reset combo time

        // Calculate score based on combo multiplier
        int multiplier =
            1 + (_comboCounter ~/ 3); // Multiplier increases every 3 hits
        if (multiplier > 5) multiplier = 5; // Cap at 5x

        _score += multiplier;

        currentPoseIndex = (currentPoseIndex + 1) % predefinedPoses.length;
        _fallController.forward(from: 0.0);
        _fallController.repeat();

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

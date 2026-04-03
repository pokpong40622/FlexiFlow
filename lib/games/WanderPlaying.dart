import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';

import '../fake_var.dart';
import '../pages/ScorePage.dart';
import '../services/hand_landmarker_service.dart';
import '../views/embedded_camera_view.dart';
import '../views/painters/coordinates_translator.dart';

enum TraceShapeType {
  triangle,
  quadrilateral,
  pentagon,
  star,
  circle,
}

class WanderPlaying extends StatefulWidget {
  const WanderPlaying({super.key});

  @override
  State<WanderPlaying> createState() => _WanderPlayingState();
}

class _WanderPlayingState extends State<WanderPlaying>
    with SingleTickerProviderStateMixin {
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  var _cameraLensDirection = CameraLensDirection.front;

  int _secondsRemaining = 90;
  int _score = 0;
  Timer? _gameTimer;
  Timer? _countdownTimer;
  bool _isPaused = false;
  bool _isResumeCountdown = false;
  int _resumeCountdownValue = 3;
  bool _isGameStarted = false;

  final Random _random = Random();
  static const int _coverageBinsPerSegment = 56;
  static const double _segmentCompletionThreshold = 0.95;
  Size? _latestImageSize;
  InputImageRotation? _latestRotation;
  TraceShapeType? _currentShape;
  List<Offset> _quadPoints = [];
  List<List<bool>> _segmentCoverage = [];
  Offset? _fingerTip;
  Offset? _lastFingerTip;

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

  void _startGame() {
    _gameTimer?.cancel();
    _countdownTimer?.cancel();

    setState(() {
      _isGameStarted = true;
      _canProcess = true;
      _isPaused = false;
      _isResumeCountdown = false;
      _secondsRemaining = 90;
      _score = 0;
      _currentShape = null;
      _quadPoints = [];
      _resetTraceState();
      _fingerTip = null;
      _lastFingerTip = null;
      _customPaint = null;
    });

    _startGameTimer();
  }

  void _startGameTimer() {
    _gameTimer?.cancel();
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted || _isPaused || _isResumeCountdown) return;

      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _endGame();
      }
    });
  }

  void _endGame() {
    _gameTimer?.cancel();

    Globals.exercisesList.add(ExerciseMetadata(
      type: ExerciseType.Wander,
      timeSpent: 120 - _secondsRemaining,
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
          highScore: 33,
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

    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      if (_resumeCountdownValue > 1) {
        setState(() {
          _resumeCountdownValue--;
        });
      } else {
        timer.cancel();
        setState(() {
          _isResumeCountdown = false;
        });
        _startGameTimer();
      }
    });
  }

  String _shapeName(TraceShapeType shape) {
    switch (shape) {
      case TraceShapeType.triangle:
        return 'Triangle';
      case TraceShapeType.quadrilateral:
        return 'Quadrilateral';
      case TraceShapeType.pentagon:
        return 'Pentagon';
      case TraceShapeType.star:
        return 'Star';
      case TraceShapeType.circle:
        return 'Circle';
    }
  }

  List<Offset> _generateRegularPolygon({
    required int sides,
    required Size imageSize,
    double minRadiusFactor = 0.16,
    double maxRadiusFactor = 0.24,
  }) {
    final availableWidth = imageSize.height;
    final availableHeight = imageSize.width;
    final minDimension = min(availableWidth, availableHeight);

    final radius = _randomBetween(
      minDimension * minRadiusFactor,
      minDimension * maxRadiusFactor,
    );

    const edgePaddingFactor = 0.08;
    final edgePadding = minDimension * edgePaddingFactor;
    final centerX = _randomBetween(
      edgePadding + radius,
      availableWidth - edgePadding - radius,
    );
    final centerY = _randomBetween(
      edgePadding + radius,
      availableHeight - edgePadding - radius,
    );

    final rotation = _random.nextDouble() * pi * 2;
    return List<Offset>.generate(sides, (index) {
      final angle = rotation + (index * 2 * pi / sides);
      return Offset(
        centerX + radius * cos(angle),
        centerY + radius * sin(angle),
      );
    });
  }

  List<Offset> _generateStar(Size imageSize) {
    final availableWidth = imageSize.height;
    final availableHeight = imageSize.width;
    final minDimension = min(availableWidth, availableHeight);

    final outerRadius = _randomBetween(minDimension * 0.17, minDimension * 0.24);
    final innerRadius = outerRadius * _randomBetween(0.43, 0.52);
    const edgePaddingFactor = 0.08;
    final edgePadding = minDimension * edgePaddingFactor;

    final centerX = _randomBetween(
      edgePadding + outerRadius,
      availableWidth - edgePadding - outerRadius,
    );
    final centerY = _randomBetween(
      edgePadding + outerRadius,
      availableHeight - edgePadding - outerRadius,
    );

    final rotation = (_random.nextDouble() * pi * 2) - (pi / 2);
    return List<Offset>.generate(10, (index) {
      final radius = index.isEven ? outerRadius : innerRadius;
      final angle = rotation + (index * pi / 5);
      return Offset(
        centerX + radius * cos(angle),
        centerY + radius * sin(angle),
      );
    });
  }

  List<Offset> _generateCircleApprox(Size imageSize) {
    return _generateRegularPolygon(
      sides: 16,
      imageSize: imageSize,
      minRadiusFactor: 0.17,
      maxRadiusFactor: 0.23,
    );
  }

  void _generateRandomShape(Size imageSize) {
    final shape = TraceShapeType.values[
        _random.nextInt(TraceShapeType.values.length)];

    List<Offset> points;
    switch (shape) {
      case TraceShapeType.triangle:
        points = _generateRegularPolygon(sides: 3, imageSize: imageSize);
        break;
      case TraceShapeType.quadrilateral:
        points = _generateRegularPolygon(
          sides: 4,
          imageSize: imageSize,
          minRadiusFactor: 0.16,
          maxRadiusFactor: 0.22,
        );
        break;
      case TraceShapeType.pentagon:
        points = _generateRegularPolygon(sides: 5, imageSize: imageSize);
        break;
      case TraceShapeType.star:
        points = _generateStar(imageSize);
        break;
      case TraceShapeType.circle:
        points = _generateCircleApprox(imageSize);
        break;
    }

    _currentShape = shape;
    _quadPoints = points;
    _resetTraceState();
  }

  void _resetTraceState() {
    _segmentCoverage = List<List<bool>>.generate(
      _quadPoints.length,
      (_) => List<bool>.filled(_coverageBinsPerSegment, false),
    );
  }

  double _randomBetween(double minValue, double maxValue) {
    return minValue + _random.nextDouble() * (maxValue - minValue);
  }

  Offset? _pickIndexFingerTip(List<DetectedHand> detectedHands) {
    final tips = <Offset>[];

    for (final hand in detectedHands) {
      if (hand.landmarks.length > LandmarksPoint.indexFingerTip.index) {
        final tip = hand.landmarks[LandmarksPoint.indexFingerTip.index];
        tips.add(Offset(tip.x, tip.y));
      }
    }

    if (tips.isEmpty) return null;
    if (_quadPoints.length < 2) return tips.first;

    tips.sort((a, b) {
      final distanceA = _distanceToShape(a);
      final distanceB = _distanceToShape(b);
      return distanceA.compareTo(distanceB);
    });

    return tips.first;
  }

  double _distanceToShape(Offset point) {
    if (_quadPoints.length < 2) return double.infinity;

    var minDistance = double.infinity;
    for (int i = 0; i < _quadPoints.length; i++) {
      final distance = _distanceToSegment(
        point,
        _quadPoints[i],
        _quadPoints[(i + 1) % _quadPoints.length],
      );
      if (distance < minDistance) {
        minDistance = distance;
      }
    }
    return minDistance;
  }

  _SegmentProjection _projectOnSegment(Offset point, Offset start, Offset end) {
    final segment = end - start;
    final segmentLengthSq = segment.dx * segment.dx + segment.dy * segment.dy;

    if (segmentLengthSq <= 1e-6) {
      return _SegmentProjection(point: start, t: 0.0);
    }

    final projection = ((point.dx - start.dx) * segment.dx +
            (point.dy - start.dy) * segment.dy) /
        segmentLengthSq;
    final t = projection.clamp(0.0, 1.0).toDouble();

    return _SegmentProjection(
      point: Offset(
        start.dx + segment.dx * t,
        start.dy + segment.dy * t,
      ),
      t: t,
    );
  }

  double _distanceToSegment(Offset point, Offset start, Offset end) {
    final projection = _projectOnSegment(point, start, end);
    return (point - projection.point).distance;
  }

  bool _isSegmentComplete(List<bool> bins) {
    if (bins.isEmpty) return false;
    final filledCount = bins.where((bin) => bin).length;
    return (filledCount / bins.length) >= _segmentCompletionThreshold;
  }

  int _completedSidesCount() {
    return _segmentCoverage.where(_isSegmentComplete).length;
  }

  void _updateTraceCoverage(
      Offset currentFingerTip, Offset? lastFingerTip, Size imageSize) {
    if (_quadPoints.length < 2) return;

    final minImageDimension = min(imageSize.width, imageSize.height);
    final tracingThreshold = minImageDimension * 0.06;
    const fillBrushFraction = 0.07;
    final brushHalfWidth =
        max(1, (_coverageBinsPerSegment * fillBrushFraction).round()) ~/ 2;
    const interpolationSteps = 8;

    bool changed = false;

    for (int i = 0; i < _quadPoints.length; i++) {
      final shapeSegmentStart = _quadPoints[i];
      final shapeSegmentEnd = _quadPoints[(i + 1) % _quadPoints.length];
      final bins = _segmentCoverage[i];

      List<Offset> fingerPath = [currentFingerTip];
      if (lastFingerTip != null &&
          (lastFingerTip - currentFingerTip).distance > 0.1) {
        fingerPath.insert(
          0,
          lastFingerTip,
        );
        for (int step = 1; step < interpolationSteps; step++) {
          final t = step / interpolationSteps;
          final interpolated =
              Offset.lerp(lastFingerTip, currentFingerTip, t)!;
          fingerPath.insert(step, interpolated);
        }
      }

      for (final fingerPos in fingerPath) {
        final projection =
            _projectOnSegment(fingerPos, shapeSegmentStart, shapeSegmentEnd);
        final distanceFromLine =
            (fingerPos - projection.point).distance;

        if (distanceFromLine <= tracingThreshold) {
          final centerBin =
              (projection.t * (_coverageBinsPerSegment - 1)).round();
          final startBin = max(0, centerBin - brushHalfWidth);
          final endBin =
              min(_coverageBinsPerSegment - 1, centerBin + brushHalfWidth);

          for (int j = startBin; j <= endBin; j++) {
            if (!bins[j]) {
              bins[j] = true;
              changed = true;
            }
          }
        }
      }
    }

    if (!changed) return;

    if (_completedSidesCount() >= _quadPoints.length) {
      _score += 1;
      _flashController.forward(from: 0.0).then((_) async {
        await Future.delayed(const Duration(milliseconds: 100));
        if (mounted) {
          _flashController.reverse();
        }
      });

      _generateRandomShape(imageSize);
    }
  }

  String _statusText() {
    if (_quadPoints.length < 2 || _currentShape == null) {
      return 'Show your index finger to place dots';
    }
    return '${_shapeName(_currentShape!)}  ${_completedSidesCount()} / ${_quadPoints.length}';
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    if (!_isGameStarted) {
      return Scaffold(
        backgroundColor: const Color(0xFFF8FBFA),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.02,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: screenWidth * 0.12,
                        height: screenWidth * 0.12,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(screenWidth * 0.03),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x1A000000),
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
                          'Wander Trace',
                          style: GoogleFonts.montserrat(
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.12),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.08),
                        Text(
                          'Trace Random Shapes',
                          style: GoogleFonts.montserrat(
                            fontSize: screenWidth * 0.07,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF0397FD),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          'A random shape appears each round: triangle, quadrilateral,\n'
                          'pentagon, star, or circle.\n'
                          'Trace lines with your index fingertip until every edge is filled.',
                          style: GoogleFonts.montserrat(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: screenHeight * 0.08),
                        _buildStartButton(screenWidth, screenHeight),
                        SizedBox(height: screenHeight * 0.04),
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
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _statusText(),
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w800,
                          fontSize: screenWidth * 0.056,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.0286),
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
                              onCameraLensDirectionChanged: (value) {
                                _cameraLensDirection = value;
                              },
                            ),
                            AnimatedBuilder(
                              animation: _flashController,
                              builder: (context, child) {
                                return Container(
                                  color: Colors.green
                                      .withOpacity(_flashController.value * 0.7),
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
                                        const Icon(
                                          Icons.pause_circle_filled,
                                          color: Colors.white,
                                          size: 80,
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          'PAUSED',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 48,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            letterSpacing: 2.0,
                                            shadows: const [
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
                                        shadows: const [
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
                  width: screenWidth,
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
                                      color: _secondsRemaining <= 10
                                          ? const Color(0xFFD32F2F)
                                          : Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.01),
                                  Padding(
                                    padding: EdgeInsets.only(top: screenHeight * 0.02),
                                    child: Text(
                                      'sec',
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w800,
                                        fontSize: screenWidth * 0.034,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.02),
                                  Icon(
                                    _isPaused ? Icons.play_arrow : Icons.pause,
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: _endGame,
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
                      SizedBox(height: screenHeight * 0.032),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: screenHeight * 0.692,
            left: (screenWidth - screenWidth * 0.346) / 2,
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

  Widget _buildStartButton(double screenWidth, double screenHeight) {
    return GestureDetector(
      onTap: _startGame,
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
              color: Color(0x33000000),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          'Start Tracing',
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
    if (!_canProcess || !_isGameStarted) return;
    if (_isBusy || _isPaused || _isResumeCountdown) return;
    _isBusy = true;

    try {
      final detectedHands =
          await HandLandmarkerService.detectHandLandmarks(inputImage);

      final metadata = inputImage.metadata;
      if (metadata?.size != null && metadata?.rotation != null) {
        _latestImageSize = metadata!.size;
        _latestRotation = metadata.rotation;

        if (_quadPoints.isEmpty) {
          _generateRandomShape(_latestImageSize!);
        }

        final currentFingerTip = _pickIndexFingerTip(detectedHands);
        if (currentFingerTip != null && _latestImageSize != null) {
          _updateTraceCoverage(currentFingerTip, _lastFingerTip, _latestImageSize!);
          _lastFingerTip = currentFingerTip;
        }
        _fingerTip = currentFingerTip;

        _customPaint = CustomPaint(
          painter: _WanderTracePainter(
            quadPoints: _quadPoints,
            segmentCoverage: _segmentCoverage,
            segmentCompletionThreshold: _segmentCompletionThreshold,
            fingerTip: _fingerTip,
            imageSize: _latestImageSize!,
            rotation: _latestRotation!,
            cameraLensDirection: _cameraLensDirection,
          ),
        );
      } else {
        _customPaint = null;
      }
    } catch (e) {
      debugPrint('Wander trace processing error: $e');
      _customPaint = null;
    }

    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}

class _SegmentProjection {
  final Offset point;
  final double t;

  const _SegmentProjection({
    required this.point,
    required this.t,
  });
}

class _WanderTracePainter extends CustomPainter {
  final List<Offset> quadPoints;
  final List<List<bool>> segmentCoverage;
  final double segmentCompletionThreshold;
  final Offset? fingerTip;
  final Size imageSize;
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;

  _WanderTracePainter({
    required this.quadPoints,
    required this.segmentCoverage,
    required this.segmentCompletionThreshold,
    required this.fingerTip,
    required this.imageSize,
    required this.rotation,
    required this.cameraLensDirection,
  });

  Offset _toCanvas(Offset point, Size canvasSize) {
    return Offset(
      translateX(
        point.dx,
        canvasSize,
        imageSize,
        rotation,
        cameraLensDirection,
      ),
      translateY(
        point.dy,
        canvasSize,
        imageSize,
        rotation,
        cameraLensDirection,
      ),
    );
  }

  bool _isSegmentComplete(List<bool> bins) {
    if (bins.isEmpty) return false;
    final filledCount = bins.where((bin) => bin).length;
    return (filledCount / bins.length) >= segmentCompletionThreshold;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (quadPoints.length < 2) return;

    final points = quadPoints.map((point) => _toCanvas(point, size)).toList();

    final baseLinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 7
      ..color = Colors.white.withOpacity(0.55);

    final tracedLinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 9
      ..color = const Color(0xFF00E676);

    final inactiveDotPaint = Paint()..color = Colors.white;
    final activeDotPaint = Paint()..color = const Color(0xFFFFF176);
    final completedDotPaint = Paint()..color = const Color(0xFF00E676);

    final dotOutlinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.black.withOpacity(0.35);

    for (int i = 0; i < points.length; i++) {
      final start = points[i];
      final end = points[(i + 1) % points.length];

      canvas.drawLine(start, end, baseLinePaint);

      final bins = i < segmentCoverage.length
          ? segmentCoverage[i]
          : const <bool>[];

      if (bins.isNotEmpty) {
        int streakStart = -1;
        for (int bin = 0; bin < bins.length; bin++) {
          final isFilled = bins[bin];
          if (isFilled && streakStart == -1) {
            streakStart = bin;
          }

          final isLastBin = bin == bins.length - 1;
          final shouldFlush = streakStart != -1 && (!isFilled || isLastBin);
          if (shouldFlush) {
            final streakEnd = isFilled && isLastBin ? bin : bin - 1;
            final startT = streakStart / bins.length;
            final endT = (streakEnd + 1) / bins.length;

            final traceStart = Offset.lerp(start, end, startT)!;
            final traceEnd = Offset.lerp(start, end, endT)!;
            canvas.drawLine(traceStart, traceEnd, tracedLinePaint);
            streakStart = -1;
          }
        }
      }
    }

    for (int i = 0; i < points.length; i++) {
      final prevSegment = (i - 1 + points.length) % points.length;
      final rightComplete = i < segmentCoverage.length
          ? _isSegmentComplete(segmentCoverage[i])
          : false;
      final leftComplete = prevSegment < segmentCoverage.length
          ? _isSegmentComplete(segmentCoverage[prevSegment])
          : false;
      final rightTouched = i < segmentCoverage.length
        ? segmentCoverage[i].any((bin) => bin)
        : false;
      final leftTouched = prevSegment < segmentCoverage.length
        ? segmentCoverage[prevSegment].any((bin) => bin)
        : false;

      final dotPaint = (leftComplete && rightComplete)
          ? completedDotPaint
        : (leftTouched || rightTouched ? activeDotPaint : inactiveDotPaint);

      canvas.drawCircle(points[i], 9, dotPaint);
      canvas.drawCircle(points[i], 9, dotOutlinePaint);
    }

    if (fingerTip != null) {
      final finger = _toCanvas(fingerTip!, size);

      final fingerGlowPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF00E676).withOpacity(0.25);
      final fingerDotPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF00E676);

      canvas.drawCircle(finger, 17, fingerGlowPaint);
      canvas.drawCircle(finger, 7, fingerDotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _WanderTracePainter oldDelegate) => true;
}
import 'dart:math';
import 'package:flutter/material.dart';
import 'exam_state.dart';
import 'dsst_page.dart';

class TrackNode {
  final String label;
  final Offset relativePos;

  TrackNode({required this.label, required this.relativePos});
}

class TrackBPage extends StatefulWidget {
  const TrackBPage({super.key});

  @override
  State<TrackBPage> createState() => _TrackBPageState();
}

class _TrackBPageState extends State<TrackBPage> {
  late List<TrackNode> nodes;
  DateTime? _startTime;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    nodes = _generateNodes(['1', 'ก', '2', 'ข', '3', 'ค', '4', 'ง', '5', 'จ']);
  }

  List<TrackNode> _generateNodes(List<String> labels) {
    final random = Random();
    List<TrackNode> result = [];
    const maxRetries = 2000;
    
    for (int attempt = 0; attempt < maxRetries; attempt++) {
      // 1. Grid-based even distribution
      // 2 columns, 5 rows = 10 cells total (exactly one per node)
      List<int> cells = List.generate(labels.length, (index) => index);
      cells.shuffle(random);
      
      List<Offset> points = [];
      for (int cell in cells) {
        int col = cell % 2; // 0 or 1
        int row = cell ~/ 2; // 0 to 4
        
        // Push starting 'y' down to 0.28 to completely avoid the header text
        double x = col * 0.5 + 0.1 + random.nextDouble() * 0.3;
        double y = 0.28 + (row * 0.13) + random.nextDouble() * 0.09;
        points.add(Offset(x, y));
      }
      
      // 2. Untangle the path using 2-opt algorithm (TSP uncrossing)
      bool changed = true;
      int untangleAttempts = 0;
      while (changed && untangleAttempts < 100) {
        changed = false;
        for (int i = 0; i < points.length - 2; i++) {
          for (int j = i + 2; j < points.length - 1; j++) {
            if (_doIntersect(points[i], points[i+1], points[j], points[j+1])) {
              // Untangle by reversing the subpath
              int left = i + 1;
              int right = j;
              while (left < right) {
                final temp = points[left];
                points[left] = points[right];
                points[right] = temp;
                left++;
                right--;
              }
              changed = true;
            }
          }
        }
        untangleAttempts++;
      }
      
      if (changed) continue; // Failed to completely untangle
      
      // 3. Ensure no point visually touches/clips an unrelated line segment
      bool invalid = false;
      for (int i = 0; i < points.length - 1; i++) {
        for (int k = 0; k < points.length; k++) {
          if (k == i || k == i + 1) continue;
          if (_distanceToSegment(points[k], points[i], points[i+1]) < 0.08) {
            invalid = true;
            break;
          }
        }
        if (invalid) break;
      }
      
      if (!invalid) {
        // Safe and nicely distributed! Assign the labels
        for (int i = 0; i < labels.length; i++) {
          result.add(TrackNode(label: labels[i], relativePos: points[i]));
        }
        return result;
      }
    }
    
    // Fallback: circular layout
    result.clear();
    for (int i = 0; i < labels.length; i++) {
      final angle = 2 * pi * i / labels.length;
      result.add(TrackNode(
        label: labels[i],
        relativePos: Offset(0.5 + 0.35 * cos(angle), 0.5 + 0.35 * sin(angle)),
      ));
    }
    return result;
  }
  
  bool _doIntersect(Offset p1, Offset q1, Offset p2, Offset q2) {
     int o1 = _orientation(p1, q1, p2);
     int o2 = _orientation(p1, q1, q2);
     int o3 = _orientation(p2, q2, p1);
     int o4 = _orientation(p2, q2, q1);
     
     if (o1 != o2 && o3 != o4) return true;
     return false;
  }
  
  int _orientation(Offset p, Offset q, Offset r) {
    double val = (q.dy - p.dy) * (r.dx - q.dx) - (q.dx - p.dx) * (r.dy - q.dy);
    if (val.abs() < 1e-6) return 0;
    return (val > 0) ? 1 : 2;
  }
  
  double _distanceToSegment(Offset p, Offset v, Offset w) {
    double l2 = (w.dx - v.dx) * (w.dx - v.dx) + (w.dy - v.dy) * (w.dy - v.dy);
    if (l2 == 0) return (p - v).distance;
    double t = ((p.dx - v.dx) * (w.dx - v.dx) + (p.dy - v.dy) * (w.dy - v.dy)) / l2;
    t = t.clamp(0.0, 1.0);
    Offset proj = Offset(v.dx + t * (w.dx - v.dx), v.dy + t * (w.dy - v.dy));
    return (p - proj).distance;
  }

  int currentIndex = 0;
  Offset? currentDragPosition;
  final double nodeRadius = 36.0;

  void _onPanStart(DragStartDetails details, Size size) {
    _handleTouch(details.localPosition, size);
  }

  void _onPanUpdate(DragUpdateDetails details, Size size) {
    if (currentIndex < nodes.length - 1) {
      setState(() {
        currentDragPosition = details.localPosition;
      });
      _handleTouch(details.localPosition, size);
    }
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      currentDragPosition = null;
    });
  }

  void _handleTouch(Offset touchPos, Size size) {
    if (currentIndex >= nodes.length - 1) return;

    final targetNode = nodes[currentIndex + 1];
    final targetPos = Offset(
      targetNode.relativePos.dx * size.width,
      targetNode.relativePos.dy * size.height,
    );

    if ((touchPos - targetPos).distance <= nodeRadius * 2) {
      setState(() {
        currentIndex++;
        currentDragPosition = null;
      });
      
      if (currentIndex >= nodes.length - 1) {
        if (_startTime != null) {
          ExamState.trackBTime = DateTime.now().difference(_startTime!).inMilliseconds / 1000.0;
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DsstPage()),
        );
      }
    }
  }

  Color _getNodeColor(int index) {
    if (index <= currentIndex) return Colors.green;
    if (index == nodes.length - 1) return const Color(0xFFD32F2F);
    return const Color(0xFF1E1E64);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);
          return Stack(
            children: [
              GestureDetector(
                onPanStart: (details) => _onPanStart(details, size),
                onPanUpdate: (details) => _onPanUpdate(details, size),
                onPanEnd: _onPanEnd,
                child: CustomPaint(
              size: size,
              painter: _TrackPainter(
                nodes: nodes,
                currentIndex: currentIndex,
                currentDragPosition: currentDragPosition,
                nodeRadius: nodeRadius,
              ),
              child: Stack(
                children: List.generate(nodes.length, (index) {
                  final node = nodes[index];
                  final pos = Offset(
                    node.relativePos.dx * size.width,
                    node.relativePos.dy * size.height,
                  );

                  return Positioned(
                    left: pos.dx - nodeRadius,
                    top: pos.dy - nodeRadius,
                    child: Container(
                      width: nodeRadius * 2,
                      height: nodeRadius * 2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _getNodeColor(index),
                      ),
                      child: Center(
                        child: Text(
                          node.label,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          const Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: Text(
                'ลากเส้นเรียงตาม\nลำดับให้ถูกต้อง\n1 \u2192 ก \u2192 2 \u2192 ...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E1E64),
                ),
              ),
            ),
          ),
        ],
      );
    },
  ),
);
  }
}

class _TrackPainter extends CustomPainter {
  final List<TrackNode> nodes;
  final int currentIndex;
  final Offset? currentDragPosition;
  final double nodeRadius;

  _TrackPainter({
    required this.nodes,
    required this.currentIndex,
    required this.currentDragPosition,
    required this.nodeRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    // Draw completed lines
    for (int i = 0; i < currentIndex; i++) {
      final startNode = nodes[i];
      final endNode = nodes[i + 1];

      final startPos = Offset(
        startNode.relativePos.dx * size.width,
        startNode.relativePos.dy * size.height,
      );
      final endPos = Offset(
        endNode.relativePos.dx * size.width,
        endNode.relativePos.dy * size.height,
      );

      _drawLineWithArrow(canvas, startPos, endPos, paint, fillPaint);
    }

    // Draw active drag line
    if (currentDragPosition != null && currentIndex < nodes.length - 1) {
      final currentNode = nodes[currentIndex];
      final startPos = Offset(
        currentNode.relativePos.dx * size.width,
        currentNode.relativePos.dy * size.height,
      );
      _drawLineWithArrow(canvas, startPos, currentDragPosition!, paint, fillPaint, isDrag: true);
    }
  }

  void _drawLineWithArrow(Canvas canvas, Offset start, Offset end, Paint strokePaint, Paint fillPaint, {bool isDrag = false}) {
    final direction = end - start;
    final distance = direction.distance;
    
    final spacingStart = nodeRadius + 8.0; 
    final spacingEnd = isDrag ? 0.0 : (nodeRadius + 8.0);
    
    if (distance <= spacingStart + spacingEnd) return;

    final normalizedDirection = direction / distance;
    
    final adjustedStart = start + normalizedDirection * spacingStart;
    final adjustedEnd = end - normalizedDirection * spacingEnd;
    
    canvas.drawLine(adjustedStart, adjustedEnd, strokePaint);

    // Draw arrow at the end
    const arrowSize = 16.0;
    final angle = atan2(normalizedDirection.dy, normalizedDirection.dx);
    
    final path = Path();
    path.moveTo(adjustedEnd.dx, adjustedEnd.dy);
    path.lineTo(
      adjustedEnd.dx - arrowSize * cos(angle - pi / 6),
      adjustedEnd.dy - arrowSize * sin(angle - pi / 6),
    );
    path.lineTo(
      adjustedEnd.dx - arrowSize * cos(angle + pi / 6),
      adjustedEnd.dy - arrowSize * sin(angle + pi / 6),
    );
    path.close();

    canvas.drawPath(path, fillPaint);
  }

  @override
  bool shouldRepaint(covariant _TrackPainter oldDelegate) {
    return oldDelegate.currentIndex != currentIndex ||
        oldDelegate.currentDragPosition != currentDragPosition;
  }
}


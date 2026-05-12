import 'package:flutter/material.dart';
import 'visual_pal_remember_page.dart';
import 'track_a_page.dart';
import 'exam_state.dart';

class VisualPalPickPage extends StatefulWidget {
  final Map<int, Map<String, dynamic>> gridItems;
  final int roundIndex;
  final bool isRecallStage;

  const VisualPalPickPage({
    super.key,
    required this.gridItems,
    required this.roundIndex,
    this.isRecallStage = false,
  });

  @override
  State<VisualPalPickPage> createState() => _VisualPalPickPageState();
}

class _VisualPalPickPageState extends State<VisualPalPickPage> {
  late List<MapEntry<int, Map<String, dynamic>>> _itemsToFind;
  int _currentIndex = 0;
  int _wrongAttempts = 0;

  @override
  void initState() {
    super.initState();
    // Shuffle the items so they appear in a random order for the user to find
    _itemsToFind = widget.gridItems.entries.toList()..shuffle();
  }

  void _onCellTapped(int index) {
    if (_currentIndex >= _itemsToFind.length) return;

    if (index != _itemsToFind[_currentIndex].key) {
      _wrongAttempts++;
    }

    setState(() {
      _currentIndex++;
    });
    
    if (_currentIndex >= _itemsToFind.length) {
      _onLevelComplete();
    }
  }

  void _onLevelComplete() {
    print('Level ${widget.roundIndex + 1} completed! Errors: $_wrongAttempts');

    if (widget.isRecallStage) {
      ExamState.memoryRecallWrongs = _wrongAttempts;
      ExamState.printScores();
      Navigator.pop(context);
      Navigator.popUntil(context, (route) => route.isFirst);
      /*
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('เสร็จสิ้นการทดสอบทั้งหมด!'),
          content: const Text('ดูคะแนนรวมใน Console'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('ตกลง'),
            ),
          ],
        ),

      );
       */
      return;
    }

    ExamState.visualPalTotalWrongs += _wrongAttempts;

    if (_wrongAttempts == 0 && widget.roundIndex + 1 < numberOfIconsPerRounds.length) {
      // Progress to next round
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => VisualPalRememberPage(
            roundIndex: widget.roundIndex + 1,
          ),
        ),
      );
    } else {
      // Finished all learning levels, OR the user made a mistake (aborting further difficulty)
      // Save the current grid items so we can test them on it during the Recall stage later!
      ExamState.latestRecallItems = widget.gridItems;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const TrackAPage(),
        ),
      );
    }
  }

  Widget _buildTargetIcon() {
    if (_currentIndex >= _itemsToFind.length) {
      return const SizedBox(height: 80);
    }
    final currentItem = _itemsToFind[_currentIndex].value;
    return Icon(
      currentItem['icon'] as IconData,
      size: 80,
      color: currentItem['color'] as Color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'สิ่งนี้อยู่ในกล่องไหน?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E1E64),
            ),
          ),
          const SizedBox(height: 20),
          _buildTargetIcon(),
          const SizedBox(height: 30),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < 4; i++) ...[
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            for (int j = 0; j < 3; j++) ...[
                              Expanded(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: GestureDetector(
                                    onTap: () => _onCellTapped(i * 3 + j),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFC0571C),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (j < 2) Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: Container(width: 4, color: Colors.black),
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (i < 3) Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Container(height: 4, color: Colors.black),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

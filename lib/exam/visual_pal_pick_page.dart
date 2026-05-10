import 'package:flutter/material.dart';
import 'visual_pal_remember_page.dart';

class VisualPalPickPage extends StatefulWidget {
  final Map<int, Map<String, dynamic>> gridItems;
  final int roundIndex;

  const VisualPalPickPage({
    super.key,
    required this.gridItems,
    required this.roundIndex,
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

    if (index == _itemsToFind[_currentIndex].key) {
      setState(() {
        _currentIndex++;
      });
      
      if (_currentIndex >= _itemsToFind.length) {
        _onLevelComplete();
      }
    } else {
      setState(() {
        _wrongAttempts++;
      });
    }
  }

  void _onLevelComplete() {
    print('Level ${widget.roundIndex + 1} completed! Errors: $_wrongAttempts');

    if (_wrongAttempts == 0) {
      if (widget.roundIndex + 1 < numberOfIconsPerRounds.length) {
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
        // Finished all levels
        print('All levels completed successfully!');
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('สำเร็จ!'),
            content: const Text('คุณผ่านการทดสอบทั้งหมดแล้ว'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context); // Go back out to previous screen/menu
                },
                child: const Text('ตกลง'),
              ),
            ],
          ),
        );
      }
    } else {
      // Made mistakes, block progression 
      print('User made mistakes. Cannot progress to the next level.');
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('จบการทดสอบ'),
          content: Text('คุณตอบผิดไป $_wrongAttempts ครั้ง\nไม่สามารถไปด่านต่อไปได้'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context); // Exit the test
              },
              child: const Text('ตกลง'),
            ),
          ],
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

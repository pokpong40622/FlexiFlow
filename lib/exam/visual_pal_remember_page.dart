import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'visual_pal_pick_page.dart';

var usableIcons = [
  Icons.vpn_key,
  Icons.accessibility_new_outlined,
  Icons.chair,
  Icons.monetization_on,
  Icons.ac_unit,
  Icons.cake,
  Icons.directions_bike,
  Icons.eco,
  Icons.headset,
  Icons.icecream,
  Icons.light_mode,
];

var usableColors = [
  Color(0xFF9E2A2B),
  Color(0xFF1E1E64),
  Color(0xFF006400),
  Color(0xFF800080),
  Color(0xFFFFA500),
];

var numberOfIconsPerRounds = [4, 6, 8, 10];

class VisualPalRememberPage extends StatefulWidget {
  final int roundIndex;
  
  const VisualPalRememberPage({super.key, this.roundIndex = 0});

  @override
  State<VisualPalRememberPage> createState() => _VisualPalRememberPageState();
}

class _VisualPalRememberPageState extends State<VisualPalRememberPage> {
  bool _isButtonEnabled = false;
  Timer? _timer;
  late Map<int, Map<String, dynamic>> _gridItems;

  @override
  void initState() {
    super.initState();
    _startCooldown();
    _generateGridItems(numberOfIconsPerRounds[widget.roundIndex]);
  }

  void _generateGridItems(int count) {
    var random = Random();
    var availableCells = List.generate(12, (index) => index);
    availableCells.shuffle(random);

    var selectedCells = availableCells.take(count).toList();

    var icons = List.from(usableIcons)..shuffle(random);
    var colors = List.from(usableColors);

    _gridItems = {};
    for (int i = 0; i < count; i++) {
       _gridItems[selectedCells[i]] = {
         'icon': icons[i % icons.length],
         'color': colors[random.nextInt(colors.length)],
       };
    }
  }

  void _startCooldown() {
    _timer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _isButtonEnabled = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              'โปรดจำรูปภาพต่อไปนี้',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1E64),
              ),
            ),
            const SizedBox(height: 40),
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
                                    child: _buildCellContent(i, j),
                                  ),
                                ),
                                if (j < 2)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4),
                                    child: Container(width: 4, color: Colors.black),
                                  ),
                              ],
                            ],
                          ),
                        ),
                        if (i < 3)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Container(height: 4, color: Colors.black),
                          ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isButtonEnabled
                      ? () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VisualPalPickPage(
                                gridItems: _gridItems,
                                roundIndex: widget.roundIndex,
                              ),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC0571C),
                    disabledBackgroundColor: Colors.grey,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'ต่อไป',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCellContent(int row, int col) {
    int index = row * 3 + col;
    if (_gridItems.containsKey(index)) {
      var item = _gridItems[index]!;
      return Icon(item['icon'] as IconData, size: 80, color: item['color'] as Color);
    }
    return const SizedBox();
  }
}

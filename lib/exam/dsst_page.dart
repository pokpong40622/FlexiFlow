import 'dart:math';
import 'package:flutter/material.dart';

class DsstPage extends StatefulWidget {
  const DsstPage({super.key});

  @override
  State<DsstPage> createState() => _DsstPageState();
}

class _DsstPageState extends State<DsstPage> {
  final int _totalTrials = 10;
  int _currentTrial = 0;
  int _correctAnswers = 0;
  int _wrongAnswers = 0;
  
  late List<IconData> _targetIcons;
  late Map<int, IconData> _numberToIconMap;
  
  DateTime? _trialStartTime;
  final List<double> _reactionTimes = [];

  @override
  void initState() {
    super.initState();
    _initTest();
  }

  void _initTest() {
    List<IconData> icons = [
      Icons.park,
      Icons.landscape,
      Icons.wb_sunny,
      Icons.chair,
      Icons.nightlight_round,
      Icons.edit,
      Icons.menu_book,
      Icons.local_cafe,
    ];
    
    // Shuffle the icons mapping to randomize which number gets which icon
    icons.shuffle(Random());
    
    _numberToIconMap = {};
    for (int i = 0; i < 8; i++) {
      _numberToIconMap[i + 1] = icons[i];
    }
    
    // Generate a list of random targets for the user to match
    _targetIcons = [];
    IconData? lastIcon;
    
    for (int i = 0; i < _totalTrials; i++) {
      IconData nextIcon;
      do {
        nextIcon = icons[Random().nextInt(icons.length)];
      } while (nextIcon == lastIcon); // Keep picking if it's the same as the last one
      
      _targetIcons.add(nextIcon);
      lastIcon = nextIcon;
    }
    
    _trialStartTime = DateTime.now();
  }

  void _onOptionTap(int number) {
    if (_currentTrial >= _totalTrials) return;
    
    final elapsedMs = DateTime.now().difference(_trialStartTime!).inMilliseconds;
    _reactionTimes.add(elapsedMs / 1000.0);
    
    if (_numberToIconMap[number] == _targetIcons[_currentTrial]) {
      _correctAnswers++;
    } else {
      _wrongAnswers++;
    }
    
    setState(() {
      _currentTrial++;
      if (_currentTrial < _totalTrials) {
        _trialStartTime = DateTime.now();
      } else {
        _finishTest();
      }
    });
  }

  void _finishTest() {
    final avgReactionTime = _reactionTimes.isNotEmpty 
        ? _reactionTimes.reduce((a, b) => a + b) / _reactionTimes.length 
        : 0.0;
        
    print('--- DSST Test Results ---');
    print('Total Trials: $_totalTrials');
    print('Correct Answers: $_correctAnswers');
    print('Wrong Answers: $_wrongAnswers');
    print('Accuracy: ${((_correctAnswers / _totalTrials) * 100).toStringAsFixed(1)}%');
    print('Average Reaction Time: ${avgReactionTime.toStringAsFixed(2)} seconds');
    print('-------------------------');

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('ทดสอบเสร็จสิ้น', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text(
            'ตอบถูก: $_correctAnswers\n'
            'ตอบผิด: $_wrongAnswers\n'
            'เวลาเฉลี่ย: ${avgReactionTime.toStringAsFixed(2)} วินาที/ข้อ',
            style: const TextStyle(fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Exit the dsst page
              },
              child: const Text('ตกลง', style: TextStyle(fontSize: 18)),
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MemoryTest - DSST', style: TextStyle(color: Colors.grey)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: _currentTrial >= _totalTrials 
        ? const Center(child: CircularProgressIndicator()) 
        : Column(
            children: [
              const SizedBox(height: 10),
              const Text(
                'เลือกตัวเลขให้ตรงกับ\nรูปภาพด้านบน',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E1E64),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 4),
                    ),
                    child: const Center(
                      child: Text('?', style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Icon(_targetIcons[_currentTrial], size: 100, color: const Color(0xFF1E1E64)),
                ],
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 1.6,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 20,
                    children: List.generate(8, (index) {
                      int number = index + 1;
                      return _buildOption(number, _numberToIconMap[number]!);
                    }),
                  ),
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildOption(int number, IconData icon) {
    return GestureDetector(
      onTap: () => _onOptionTap(number),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: const Color(0xFFD9702B),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Icon(icon, size: 60, color: const Color(0xFF1E1E64)),
        ],
      ),
    );
  }
}

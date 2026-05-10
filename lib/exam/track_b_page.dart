import 'package:flutter/material.dart';

class TrackBPage extends StatelessWidget {
  const TrackBPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MemoryTest - Track B', style: TextStyle(color: Colors.grey)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ลากเส้นเรียงตาม\nลำดับให้ถูกต้อง\n1 -> ก -> 2 -> ...',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E1E64),
          ),
        ),
      ),
    );
  }
}

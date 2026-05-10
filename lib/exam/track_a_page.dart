import 'package:flutter/material.dart';

class TrackAPage extends StatelessWidget {
  const TrackAPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MemoryTest - Track A', style: TextStyle(color: Colors.grey)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ลากเส้นเรียงตาม\nลำดับให้ถูกต้อง\n1 -> 2 -> ...',
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

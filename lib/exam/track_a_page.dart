import 'package:flutter/material.dart';

class TrackAPage extends StatelessWidget {
  const TrackAPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

import 'package:flutter/material.dart';

class VisualPalRememberPage extends StatelessWidget {
  const VisualPalRememberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MemoryTest - Visual PAL Remember', style: TextStyle(color: Colors.grey)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'โปรดจำรูปภาพต่อไปนี้',
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

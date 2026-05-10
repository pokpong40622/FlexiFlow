import 'package:flutter/material.dart';

class VisualPalPickPage extends StatelessWidget {
  const VisualPalPickPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MemoryTest - Visual PAL Pick', style: TextStyle(color: Colors.grey)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
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
          const Icon(Icons.chair, size: 80, color: Color(0xFF1E1E64)),
          const SizedBox(height: 30),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                padding: const EdgeInsets.only(bottom: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFC0571C),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

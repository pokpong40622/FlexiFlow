import 'package:flutter/material.dart';

class DsstPage extends StatelessWidget {
  const DsstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MemoryTest - DSST', style: TextStyle(color: Colors.grey)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'เลือกตัวเลขให้ตรงกับ\nรูปภาพด้านบน',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E1E64),
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 4),
                ),
                child: const Center(
                  child: Text('?', style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 20),
              const Icon(Icons.chair, size: 80, color: Color(0xFF1E1E64)),
            ],
          ),
          const SizedBox(height: 40),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 2.5,
                mainAxisSpacing: 16,
                crossAxisSpacing: 40,
                children: [
                  _buildOption(1, Icons.park),
                  _buildOption(5, Icons.landscape),
                  _buildOption(2, Icons.wb_sunny),
                  _buildOption(6, Icons.chair),
                  _buildOption(3, Icons.nightlight_round),
                  _buildOption(7, Icons.edit),
                  _buildOption(4, Icons.menu_book),
                  _buildOption(8, Icons.local_cafe),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(int number, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFD9702B),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              number.toString(),
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Icon(icon, size: 40, color: const Color(0xFF1E1E64)),
      ],
    );
  }
}

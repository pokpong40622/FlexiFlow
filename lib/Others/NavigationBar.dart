import 'package:flexiflow/Pages/HomePage.dart';
import 'package:flexiflow/Pages/MissionPage.dart';
import 'package:flexiflow/Pages/StatsPage.dart';
import 'package:flexiflow/Pages/TrainingPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationBarSet extends StatefulWidget {
  NavigationBarSet({super.key,});

  @override
  State<NavigationBarSet> createState() => _HomepageState();
}

class _HomepageState extends State<NavigationBarSet> {
  int myIndex = 0;

  final List<String> _pageNames = [
    'Home',
    'Mission',
    'Stats',
    'Training'
  ];

  @override
  Widget build(BuildContext context) {

  final List<Widget> _pages = [
    HomePage(),
    MissionPage(),
    StatsPage(),
    TrainingPage()
  ];

    return Scaffold(
      body: _pages[myIndex],
      bottomNavigationBar: Container(
        height: 82,
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              index: 0,
              icon: Icons.home,
              label: _pageNames[0],
            ),
            _buildNavItem(
              index: 1,
              icon: Icons.emoji_events,
              label: _pageNames[1], 
            ),
            _buildNavItem(
              index: 2,
              icon: Icons.bar_chart,
              label: _pageNames[2],
            ),
            _buildNavItem(
              index: 3,
              icon: Icons.play_circle,
              label: _pageNames[3],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = myIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          myIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 33,
            color: isSelected ? Color(0xFF0397FD) : Color(0xFFD9D9D9),
          ),
          SizedBox(height: 2),
          
          // if (isSelected)
          //   Text(
          //     label,
          //     style: GoogleFonts.inter(
          //       fontSize: 10,
          //       fontWeight: FontWeight.bold, 
          //       color: Color(0xFF0397FD),
          //     ),
          //   ),
        ],
      ),
    );
  }
}



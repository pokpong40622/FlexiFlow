import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../pages/HomePage.dart';
import '../pages/MissionPage.dart';
import '../pages/StatsPage.dart';
import '../pages/TrainingPage.dart';

class NavigationBarSet extends StatefulWidget {
  const NavigationBarSet({super.key});

  @override
  State<NavigationBarSet> createState() => _HomepageState();
}

class _HomepageState extends State<NavigationBarSet> {
  int myIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final pageNames = [
      l10n.home,
      l10n.mission,
      l10n.stats,
      l10n.training,
    ];

    final pages = [
      const HomePage(),
      MissionPage(onNavigateToTraining: () {
        setState(() => myIndex = 3);
      }),
      StatsPage(),
      const TrainingPage(),
    ];

    return Scaffold(
      body: pages[myIndex],
      bottomNavigationBar: Container(
        height: 82,
        color: const Color(0xFFFFFFFF),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(index: 0, icon: Icons.home, label: pageNames[0]),
            _buildNavItem(index: 1, icon: Icons.emoji_events, label: pageNames[1]),
            _buildNavItem(index: 2, icon: Icons.bar_chart, label: pageNames[2]),
            _buildNavItem(index: 3, icon: Icons.play_circle, label: pageNames[3]),
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

    return Semantics(
      selected: isSelected,
      button: true,
      label: label,
      child: InkResponse(
        onTap: () => setState(() => myIndex = index),
        radius: 28,
        child: SizedBox(
          width: 56,
          height: 56,
          child: Center(
            child: Icon(
              icon,
              size: 33,
              color: isSelected ? const Color(0xFF0397FD) : const Color(0xFF9CA3AF),
            ),
          ),
        ),
      ),
    );
  }
}

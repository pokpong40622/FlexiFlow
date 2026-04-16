import '../pages/HomePage.dart';
import '../pages/MissionPage.dart';
import '../pages/StatsPage.dart';
import '../pages/TrainingPage.dart';
import 'package:flutter/material.dart';
import 'package:motion_kit/fake_var.dart';
import 'package:motion_kit/theme/app_tokens.dart';

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
    MissionPage(onNavigateToTraining: () {
      setState(() {
        myIndex = 3;
      });
    }),
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
              showPersistentLabel: Globals.wcagModeEnabled,
            ),
            _buildNavItem(
              index: 1,
              icon: Icons.emoji_events,
              label: _pageNames[1],
              showPersistentLabel: Globals.wcagModeEnabled,
            ),
            _buildNavItem(
              index: 2,
              icon: Icons.bar_chart,
              label: _pageNames[2],
              showPersistentLabel: Globals.wcagModeEnabled,
            ),
            _buildNavItem(
              index: 3,
              icon: Icons.play_circle,
              label: _pageNames[3],
              showPersistentLabel: Globals.wcagModeEnabled,
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
    required bool showPersistentLabel,
  }) {
    final isSelected = myIndex == index;
    final colorScheme = Theme.of(context).colorScheme;

    final showLabel = showPersistentLabel || isSelected;
    final tokens = Globals.wcagModeEnabled ? AppTokens.wcag : AppTokens.standard;
    return Semantics(
      button: true,
      selected: isSelected,
      label: 'Go to $label tab',
      child: InkResponse(
        radius: 32,
        onTap: () {
          setState(() {
            myIndex = index;
          });
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: tokens.minTapTargetSize,
            minHeight: tokens.minTapTargetSize,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: tokens.navigationIconSize,
                color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 2),
              if (showLabel)
                Text(
                  label,
                  style: TextStyle(
                    fontSize: Globals.wcagModeEnabled ? 12 : 10,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

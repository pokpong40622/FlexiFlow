import 'package:flutter/material.dart';

class AppTokens {
  final Color scaffoldBackground;
  final Color cardBackground;
  final Color primary;
  final Color onPrimary;
  final Color textPrimary;
  final Color textSecondary;
  final Color border;
  final double minTapTargetSize;
  final double bodyScale;

  const AppTokens({
    required this.scaffoldBackground,
    required this.cardBackground,
    required this.primary,
    required this.onPrimary,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
    required this.minTapTargetSize,
    required this.bodyScale,
  });

  static const AppTokens standard = AppTokens(
    scaffoldBackground: Color(0xFFFAFAFA),
    cardBackground: Colors.white,
    primary: Color(0xFF0397FD),
    onPrimary: Colors.white,
    textPrimary: Color(0xFF1A1A1A),
    textSecondary: Color(0xFF5F6368),
    border: Color(0xFFD9D9D9),
    minTapTargetSize: 48,
    bodyScale: 1.0,
  );

  static const AppTokens wcag = AppTokens(
    scaffoldBackground: Color(0xFFFFFFFF),
    cardBackground: Color(0xFFFFFFFF),
    primary: Color(0xFF005BB5),
    onPrimary: Colors.white,
    textPrimary: Color(0xFF000000),
    textSecondary: Color(0xFF1F1F1F),
    border: Color(0xFF4A4A4A),
    minTapTargetSize: 52,
    bodyScale: 1.1,
  );
}

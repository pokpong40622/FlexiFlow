import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

class AppTokens extends ThemeExtension<AppTokens> {
  final Color scaffoldBackground;
  final Color cardBackground;
  final Color primary;
  final Color onPrimary;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color textSuccess;
  final Color textReward;
  final Color textWarning;
  final Color textDisabled;
  final Color border;
  final Color borderDisabled;
  final double minTapTargetSize;
  final double compactTapTargetSize;
  final double bodyScale;
  final double navigationIconSize;

  const AppTokens({
    required this.scaffoldBackground,
    required this.cardBackground,
    required this.primary,
    required this.onPrimary,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.textSuccess,
    required this.textReward,
    required this.textWarning,
    required this.textDisabled,
    required this.border,
    required this.borderDisabled,
    required this.minTapTargetSize,
    required this.compactTapTargetSize,
    required this.bodyScale,
    required this.navigationIconSize,
  });

  // App-controlled text scaling range exposed in Profile settings.
  static const double userTextScaleMin = 1.0;
  static const double userTextScaleMax = 2.5;
  // Minimum readable baseline increase when WCAG mode is enabled.
  static const double wcagTextScaleMin = 1.1;

  static const AppTokens standard = AppTokens(
    scaffoldBackground: Color(0xFFFAFAFA),
    cardBackground: Colors.white,
    primary: Color(0xFF0397FD),
    onPrimary: Colors.white,
    textPrimary: Color(0xFF1A1A1A),
    textSecondary: Color(0xFF5F6368),
    textMuted: Color(0xFF6B7280),
    textSuccess: Color(0xFF2E7D32),
    textReward: Color(0xFFE5A100),
    textWarning: Color(0xFFD32F2F),
    textDisabled: Color(0xFF9AA0A6),
    border: Color(0xFFD9D9D9),
    borderDisabled: Color(0xFFE0E0E0),
    minTapTargetSize: 48,
    compactTapTargetSize: 24,
    bodyScale: 1.0,
    navigationIconSize: 28,
  );

  static const AppTokens wcag = AppTokens(
    scaffoldBackground: Color(0xFFFFFFFF),
    cardBackground: Color(0xFFFFFFFF),
    primary: Color(0xFF005BB5),
    onPrimary: Colors.white,
    textPrimary: Color(0xFF000000),
    textSecondary: Color(0xFF1F1F1F),
    textMuted: Color(0xFF2F2F2F),
    textSuccess: Color(0xFF0F6A2F),
    textReward: Color(0xFF8A5A00),
    textWarning: Color(0xFF8B1E1E),
    textDisabled: Color(0xFF444444),
    border: Color(0xFF4A4A4A),
    borderDisabled: Color(0xFF5E5E5E),
    minTapTargetSize: 52,
    compactTapTargetSize: 44,
    bodyScale: 1.0,
    navigationIconSize: 32,
  );

  @override
  AppTokens copyWith({
    Color? scaffoldBackground,
    Color? cardBackground,
    Color? primary,
    Color? onPrimary,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? textSuccess,
    Color? textReward,
    Color? textWarning,
    Color? textDisabled,
    Color? border,
    Color? borderDisabled,
    double? minTapTargetSize,
    double? compactTapTargetSize,
    double? bodyScale,
    double? navigationIconSize,
  }) {
    return AppTokens(
      scaffoldBackground: scaffoldBackground ?? this.scaffoldBackground,
      cardBackground: cardBackground ?? this.cardBackground,
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      textSuccess: textSuccess ?? this.textSuccess,
      textReward: textReward ?? this.textReward,
      textWarning: textWarning ?? this.textWarning,
      textDisabled: textDisabled ?? this.textDisabled,
      border: border ?? this.border,
      borderDisabled: borderDisabled ?? this.borderDisabled,
      minTapTargetSize: minTapTargetSize ?? this.minTapTargetSize,
      compactTapTargetSize: compactTapTargetSize ?? this.compactTapTargetSize,
      bodyScale: bodyScale ?? this.bodyScale,
      navigationIconSize: navigationIconSize ?? this.navigationIconSize,
    );
  }

  @override
  AppTokens lerp(covariant ThemeExtension<AppTokens>? other, double t) {
    if (other is! AppTokens) return this;
    return AppTokens(
      scaffoldBackground:
          Color.lerp(scaffoldBackground, other.scaffoldBackground, t) ??
              scaffoldBackground,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t) ??
          cardBackground,
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t) ?? onPrimary,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t) ?? textPrimary,
      textSecondary:
          Color.lerp(textSecondary, other.textSecondary, t) ?? textSecondary,
      textMuted: Color.lerp(textMuted, other.textMuted, t) ?? textMuted,
      textSuccess: Color.lerp(textSuccess, other.textSuccess, t) ?? textSuccess,
      textReward: Color.lerp(textReward, other.textReward, t) ?? textReward,
      textWarning: Color.lerp(textWarning, other.textWarning, t) ?? textWarning,
      textDisabled:
          Color.lerp(textDisabled, other.textDisabled, t) ?? textDisabled,
      border: Color.lerp(border, other.border, t) ?? border,
      borderDisabled:
          Color.lerp(borderDisabled, other.borderDisabled, t) ?? borderDisabled,
      minTapTargetSize:
          lerpDouble(minTapTargetSize, other.minTapTargetSize, t) ??
              minTapTargetSize,
      compactTapTargetSize:
          lerpDouble(compactTapTargetSize, other.compactTapTargetSize, t) ??
              compactTapTargetSize,
      bodyScale: lerpDouble(bodyScale, other.bodyScale, t) ?? bodyScale,
      navigationIconSize:
          lerpDouble(navigationIconSize, other.navigationIconSize, t) ??
              navigationIconSize,
    );
  }
}

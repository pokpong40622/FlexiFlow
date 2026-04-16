import 'package:flutter/material.dart';
import 'package:motion_kit/theme/app_tokens.dart';

class AppTheme {
  static ThemeData build({required bool wcagModeEnabled}) {
    final tokens = wcagModeEnabled ? AppTokens.wcag : AppTokens.standard;
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: tokens.primary,
        brightness: Brightness.light,
      ).copyWith(
        primary: tokens.primary,
        onPrimary: tokens.onPrimary,
        surface: tokens.cardBackground,
        onSurface: tokens.textPrimary,
      ),
      scaffoldBackgroundColor: tokens.scaffoldBackground,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      splashFactory: InkRipple.splashFactory,
      textTheme: Typography.blackMountainView.apply(
        bodyColor: tokens.textPrimary,
        displayColor: tokens.textPrimary,
        fontSizeFactor: tokens.bodyScale,
      ),
    );

    return base.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: tokens.cardBackground,
        foregroundColor: tokens.textPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: base.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: tokens.textPrimary,
        ),
      ),
      cardTheme: CardTheme(
        color: tokens.cardBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      listTileTheme: ListTileThemeData(
        tileColor: tokens.cardBackground,
        textColor: tokens.textPrimary,
        iconColor: tokens.textPrimary,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        minVerticalPadding: 8,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(tokens.minTapTargetSize),
          backgroundColor: tokens.primary,
          foregroundColor: tokens.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          textStyle: base.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: tokens.cardBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: tokens.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: tokens.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: tokens.primary, width: 2),
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: tokens.cardBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

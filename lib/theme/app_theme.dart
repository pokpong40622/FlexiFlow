import 'package:flutter/material.dart';
import 'package:motion_kit/theme/app_tokens.dart';

class AppTheme {
  static TextStyle? _scaleTextStyle(TextStyle? style, double factor) {
    if (style == null || factor == 1.0) return style;
    final size = style.fontSize;
    if (size == null) return style;
    return style.copyWith(fontSize: size * factor);
  }

  static TextTheme _scaleTextTheme(TextTheme textTheme, double factor) {
    if (factor == 1.0) return textTheme;
    return textTheme.copyWith(
      displayLarge: _scaleTextStyle(textTheme.displayLarge, factor),
      displayMedium: _scaleTextStyle(textTheme.displayMedium, factor),
      displaySmall: _scaleTextStyle(textTheme.displaySmall, factor),
      headlineLarge: _scaleTextStyle(textTheme.headlineLarge, factor),
      headlineMedium: _scaleTextStyle(textTheme.headlineMedium, factor),
      headlineSmall: _scaleTextStyle(textTheme.headlineSmall, factor),
      titleLarge: _scaleTextStyle(textTheme.titleLarge, factor),
      titleMedium: _scaleTextStyle(textTheme.titleMedium, factor),
      titleSmall: _scaleTextStyle(textTheme.titleSmall, factor),
      bodyLarge: _scaleTextStyle(textTheme.bodyLarge, factor),
      bodyMedium: _scaleTextStyle(textTheme.bodyMedium, factor),
      bodySmall: _scaleTextStyle(textTheme.bodySmall, factor),
      labelLarge: _scaleTextStyle(textTheme.labelLarge, factor),
      labelMedium: _scaleTextStyle(textTheme.labelMedium, factor),
      labelSmall: _scaleTextStyle(textTheme.labelSmall, factor),
    );
  }

  static ThemeData build({required bool wcagModeEnabled}) {
    final tokens = wcagModeEnabled ? AppTokens.wcag : AppTokens.standard;
    final textTheme = _scaleTextTheme(
      Typography.blackMountainView.apply(
        bodyColor: tokens.textPrimary,
        displayColor: tokens.textPrimary,
      ),
      tokens.bodyScale,
    );
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
      textTheme: textTheme,
      extensions: <ThemeExtension<dynamic>>[tokens],
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
      cardTheme: CardThemeData(
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
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          minimumSize:
              Size.square(tokens.compactTapTargetSize.clamp(24, 60).toDouble()),
          foregroundColor: tokens.textPrimary,
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
      dialogTheme: DialogThemeData(
        backgroundColor: tokens.cardBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

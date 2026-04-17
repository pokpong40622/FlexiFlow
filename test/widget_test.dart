import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:motion_kit/fake_var.dart';
import 'package:motion_kit/l10n/app_language.dart';
import 'package:motion_kit/theme/app_tokens.dart';
import 'package:motion_kit/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Globals.load();
  });

  test('WCAG mode defaults to off and persists when changed', () async {
    expect(Globals.wcagModeEnabled, isFalse);

    await Globals.setWcagMode(true);
    expect(Globals.wcagModeEnabled, isTrue);

    await Globals.load();
    expect(Globals.wcagModeEnabled, isTrue);

    await Globals.setWcagMode(false);
    expect(Globals.wcagModeEnabled, isFalse);
  });

  test('Language defaults to Thai and persists when changed', () async {
    expect(Globals.locale.languageCode, equals('th'));

    await Globals.setLanguage(const Locale('en'));
    expect(Globals.locale.languageCode, equals('en'));

    await Globals.load();
    expect(Globals.locale.languageCode, equals('en'));
  });

  test('Language falls back to Thai for invalid stored value', () async {
    SharedPreferences.setMockInitialValues({'languageCode': 'xx'});
    await Globals.load();
    expect(Globals.locale.languageCode, equals(AppLanguage.defaultLocale.languageCode));
  });

  test('AppTheme changes key colors between default and WCAG mode', () {
    final standardTheme = AppTheme.build(wcagModeEnabled: false);
    final wcagTheme = AppTheme.build(wcagModeEnabled: true);

    expect(standardTheme.colorScheme.primary, isNot(equals(wcagTheme.colorScheme.primary)));
    expect(standardTheme.scaffoldBackgroundColor, isNot(equals(wcagTheme.scaffoldBackgroundColor)));
  });

  test('WCAG theme exposes semantic tokens and larger compact tap targets', () {
    final standardTheme = AppTheme.build(wcagModeEnabled: false);
    final wcagTheme = AppTheme.build(wcagModeEnabled: true);

    final standardTokens = standardTheme.extension<AppTokens>();
    final wcagTokens = wcagTheme.extension<AppTokens>();

    expect(standardTokens, isNotNull);
    expect(wcagTokens, isNotNull);
    expect(wcagTokens!.compactTapTargetSize, greaterThan(standardTokens!.compactTapTargetSize));
    expect(wcagTokens.compactTapTargetSize, greaterThanOrEqualTo(44));
    expect(wcagTokens.textReward, isNot(equals(standardTokens.textReward)));
    expect(wcagTokens.textMuted, isNot(equals(standardTokens.textMuted)));
  });
}

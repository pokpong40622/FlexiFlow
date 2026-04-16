import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage {
  final Locale locale;
  final String labelKey;

  const AppLanguage({required this.locale, required this.labelKey});
}

class AppSettings extends ChangeNotifier {
  static const _localeLanguageCodeKey = 'app.locale.languageCode';
  static const _localeCountryCodeKey = 'app.locale.countryCode';

  static const supportedLanguages = [
    AppLanguage(locale: Locale('en'), labelKey: 'languageEnglish'),
    AppLanguage(locale: Locale('th'), labelKey: 'languageThai'),
  ];

  Locale? _locale;

  Locale? get locale => _locale;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_localeLanguageCodeKey);
    final countryCode = prefs.getString(_localeCountryCodeKey);

    if (languageCode != null && languageCode.isNotEmpty) {
      _locale = Locale(languageCode, countryCode != null && countryCode.isNotEmpty ? countryCode : null);
      notifyListeners();
    }
  }

  Future<void> setLocale(Locale? locale) async {
    final prefs = await SharedPreferences.getInstance();
    _locale = locale;

    if (locale == null) {
      await prefs.remove(_localeLanguageCodeKey);
      await prefs.remove(_localeCountryCodeKey);
    } else {
      await prefs.setString(_localeLanguageCodeKey, locale.languageCode);
      await prefs.setString(_localeCountryCodeKey, locale.countryCode ?? '');
    }

    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class AppLanguage {
  const AppLanguage({
    required this.code,
    required this.locale,
    required this.nativeName,
  });

  final String code;
  final Locale locale;
  final String nativeName;

  static const defaultLocale = Locale('th');

  static const supportedLanguages = <AppLanguage>[
    AppLanguage(code: 'th', locale: Locale('th'), nativeName: 'ไทย'),
    AppLanguage(code: 'en', locale: Locale('en'), nativeName: 'English'),
  ];

  static List<Locale> get supportedLocales =>
      supportedLanguages.map((language) => language.locale).toList(growable: false);

  static Locale localeFromCode(String? code) {
    if (code == null) return defaultLocale;
    for (final language in supportedLanguages) {
      if (language.code == code) return language.locale;
    }
    return defaultLocale;
  }

  static String codeFromLocale(Locale locale) {
    for (final language in supportedLanguages) {
      if (language.locale.languageCode == locale.languageCode) {
        return language.code;
      }
    }
    return defaultLocale.languageCode;
  }
}

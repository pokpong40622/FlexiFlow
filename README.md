# FlexiFlow

## Localization

This project uses Flutter gen-l10n with ARB files.

- ARB files are in `lib/l10n`.
- Current locales: `en`, `th`.

To add a new language:
1. Add `app_<locale>.arb` in `lib/l10n`.
2. Add the locale to `L10n.supportedLocales` in `lib/l10n/l10n.dart`.
3. Add a corresponding language option in `AppSettings.supportedLanguages` in `lib/app/app_settings.dart`.
4. Run Flutter build/test commands so localization classes are regenerated.

When adding new user-facing text, add a localization key in ARB files instead of hardcoding UI strings.

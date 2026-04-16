import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:motion_kit/app/app_settings.dart';
import 'package:motion_kit/fake_var.dart';
import 'package:motion_kit/l10n/l10n.dart';
import 'package:motion_kit/memberships/widget_tree.dart';
import 'package:motion_kit/services/step_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'firebase_options.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Globals.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  cameras = await availableCameras();
  await StepService().init();

  final appSettings = AppSettings();
  await appSettings.load();

  runApp(MyApp(settings: appSettings));
}

class MyApp extends StatelessWidget {
  final AppSettings settings;

  const MyApp({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settings,
      builder: (context, _) {
        return MaterialApp(
          title: 'FlexiFlow',
          debugShowCheckedModeBanner: false,
          locale: settings.locale,
          supportedLocales: L10n.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            if (locale == null) return const Locale('en');
            for (final supported in supportedLocales) {
              if (supported.languageCode == locale.languageCode) {
                return supported;
              }
            }
            return const Locale('en');
          },
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0397FD)),
            useMaterial3: true,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: AppSettingsScope(settings: settings, child: const WidgetTree()),
        );
      },
    );
  }
}

class AppSettingsScope extends InheritedWidget {
  final AppSettings settings;

  const AppSettingsScope({
    super.key,
    required this.settings,
    required super.child,
  });

  static AppSettings of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppSettingsScope>();
    if (scope == null) {
      throw StateError('AppSettingsScope not found in context');
    }
    return scope.settings;
  }

  @override
  bool updateShouldNotify(AppSettingsScope oldWidget) => oldWidget.settings != settings;
}

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:motion_kit/Others/NavigationBar.dart';
import 'package:motion_kit/exam/dsst_page.dart';
import 'package:motion_kit/exam/track_a_page.dart';
import 'package:motion_kit/exam/track_b_page.dart';
import 'package:motion_kit/exam/visual_pal_pick_page.dart';
import 'package:motion_kit/exam/visual_pal_remember_page.dart';
import 'package:motion_kit/figma/chatbot.dart';
import 'package:motion_kit/memberships/widget_tree.dart';
import 'package:motion_kit/pages/GetStarted.dart';
import 'package:motion_kit/pages/SawasdeeWanPage.dart';
import 'package:motion_kit/services/step_service.dart';
import 'package:motion_kit/theme/app_tokens.dart';
import 'package:motion_kit/theme/app_theme.dart';
import 'package:motion_kit/l10n/app_language.dart';
import 'package:motion_kit/l10n/app_localizations.dart';
import 'package:motion_kit/views/pose_detection_screen.dart';
import 'package:motion_kit/views/hand_detection_screen.dart';
import 'package:motion_kit/views/hand_pose_detection_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:motion_kit/fake_var.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  // Intercept Flutter's error handling before the app runs
  FlutterError.onError = (FlutterErrorDetails details) {
    final exceptionString = details.exceptionAsString();

    // 1. Catch the main RenderFlex error
    if (exceptionString.contains('RenderFlex overflowed')) {
      debugPrint('\n🚨 --- FULL RENDERFLEX OVERFLOW DETAILS --- 🚨');
      // forceReport: true overrides Flutter's default behavior and forces
      // the full widget tree and file location to print to the console.
      FlutterError.dumpErrorToConsole(details, forceReport: true);
    }
    // 2. Silence the annoying "Another exception was thrown" spam completely
    else if (exceptionString.contains('Another exception was thrown')) {
      // Do nothing here. This swallows the repetitive spam.
    }
    // 3. Keep standard logging for other, non-layout errors (Recommended)
    else {
      FlutterError.presentError(details);
    }
  };

  WidgetsFlutterBinding.ensureInitialized();
  await Globals.load(); // Load saved global variables
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Initialize cameras
  cameras = await availableCameras();
  await StepService().init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: Globals.localeNotifier,
      builder: (context, appLocale, _) {
        return ValueListenableBuilder<bool>(
          valueListenable: Globals.wcagModeNotifier,
          builder: (context, wcagModeEnabled, __) {
            return ValueListenableBuilder<double>(
              valueListenable: Globals.textScaleNotifier,
              builder: (context, textScaleFactor, ___) {
                final targetScale = (wcagModeEnabled
                        ? textScaleFactor.clamp(
                            AppTokens.wcagTextScaleMin,
                            AppTokens.userTextScaleMax,
                          )
                        : textScaleFactor.clamp(
                            AppTokens.userTextScaleMin,
                            AppTokens.userTextScaleMax,
                          ))
                    .toDouble();

                return MaterialApp(
                  locale: appLocale,
                  supportedLocales: AppLanguage.supportedLocales,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
                  theme: AppTheme.build(wcagModeEnabled: wcagModeEnabled),
                  debugShowCheckedModeBanner: false,
                  builder: (context, child) {
                    final mediaQuery = MediaQuery.of(context);
                    return MediaQuery(
                      data: mediaQuery.copyWith(
                        textScaler: TextScaler.linear(targetScale),
                      ),
                      child: child ?? const SizedBox.shrink(),
                    );
                  },
                  // home: const VisualPalRememberPage(roundIndex: 0),
                  home: SawasdeeWanPage(score: 76),
                );
              },
            );
          },
        );
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Motion Kit'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.accessibility_new,
              size: 100,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 30),
            const Text(
              'AI Motion Detection',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Detect and track human poses and hand gestures in real-time',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PoseDetectorView(),
                  ),
                );
              },
              icon: const Icon(Icons.accessibility_new),
              label: const Text('Start Pose Detection'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HandDetectorView(),
                  ),
                );
              },
              icon: const Icon(Icons.back_hand),
              label: const Text('Start Hand Detection'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HandPoseDetectorView(),
                  ),
                );
              },
              icon: const Icon(Icons.gesture),
              label: const Text('Hand & Pose Detection'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
                backgroundColor: Colors.deepPurple.shade100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:motion_kit/Others/NavigationBar.dart';
import 'package:motion_kit/figma/chatbot.dart';
import 'package:motion_kit/memberships/widget_tree.dart';
import 'package:motion_kit/pages/GetStarted.dart';
import 'package:motion_kit/services/step_service.dart';
import 'package:motion_kit/views/pose_detection_screen.dart';
import 'package:motion_kit/views/hand_detection_screen.dart';
import 'package:motion_kit/views/hand_pose_detection_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:motion_kit/fake_var.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
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
    return MaterialApp(
      title: 'Motion Kit - AI Detection',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: HomeScreen(),
      home: WidgetTree(),
      // home: const ChatBotPage(),
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
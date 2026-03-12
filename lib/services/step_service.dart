import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../fake_var.dart';

class StepService {
  late Stream<StepCount> _stepCountStream;

  // Keys for SharedPreferences
  static const String _accumulatedStepsKey = 'accumulated_steps_today';
  static const String _lastSystemStepsKey = 'last_system_steps';
  static const String _lastDayKey = 'last_day_steps';

  // Singleton instance
  static final StepService _instance = StepService._internal();
  factory StepService() => _instance;
  StepService._internal();

  Future<void> init() async {
    await _initPermissions();
    await _loadSavedSteps();
    _initPedometer();
  }

  Future<void> _initPermissions() async {
    if (await Permission.activityRecognition.request().isGranted) {
      // Permission granted
      print("Activity recognition permission granted");
    } else {
      // Handle the case where the user denies permission
      print("Activity recognition permission denied");
    }
  }

  void _initPedometer() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
  }

  void onStepCount(StepCount event) async {
    print("Step Count");
    await _updateSteps(event.steps);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
  }

  Future<void> _loadSavedSteps() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int accumulatedSteps = prefs.getInt(_accumulatedStepsKey) ?? 0;
    String lastDay = prefs.getString(_lastDayKey) ?? '';
    String today = DateTime.now().toIso8601String().substring(0, 10);

    if (lastDay == today) {
      Globals.totalStepsTD = accumulatedSteps;
    } else {
      Globals.totalStepsTD = 0;
    }
  }

  Future<void> _updateSteps(int currentSystemSteps) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    int accumulatedSteps = prefs.getInt(_accumulatedStepsKey) ?? 0;
    int lastSystemSteps = prefs.getInt(_lastSystemStepsKey) ?? 0;
    String lastDay = prefs.getString(_lastDayKey) ?? '';
    
    String today = DateTime.now().toIso8601String().substring(0, 10); // YYYY-MM-DD

    if (lastDay != today) {
      // New day, reset daily accumulation
      accumulatedSteps = 0;
      lastSystemSteps = currentSystemSteps;
      lastDay = today;
    } else {
      // Same day
      int diff = currentSystemSteps - lastSystemSteps;
      if (diff < 0) {
        // Reboot happened, current steps reset to 0
        diff = currentSystemSteps;
      }
      accumulatedSteps += diff;
      lastSystemSteps = currentSystemSteps;
    }

    // Save state
    await prefs.setInt(_accumulatedStepsKey, accumulatedSteps);
    await prefs.setInt(_lastSystemStepsKey, lastSystemSteps);
    await prefs.setString(_lastDayKey, lastDay);

    // Update Global variable
    Globals.totalStepsTD = accumulatedSteps;
  }
}

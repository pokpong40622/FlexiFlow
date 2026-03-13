import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

enum ExerciseType {
  PerfectMatch,
  SumItUp,
  Wander,
}

class ExerciseMetadata {
  final ExerciseType type;
  final int timeSpent; // in seconds
  final int score;

  ExerciseMetadata({
    required this.type,
    required this.timeSpent,
    required this.score,
  });

  Map<String, dynamic> toJson() => {
        'type': type.index,
        'timeSpent': timeSpent,
        'score': score,
      };

  factory ExerciseMetadata.fromJson(Map<String, dynamic> json) {
    return ExerciseMetadata(
      type: ExerciseType.values[json['type']],
      timeSpent: json['timeSpent'],
      score: json['score'],
    );
  }
}

double lvlToExp(int level) {
  return 30*level*(level-1);
}

double expToLvl(int exp) {
  return (30 + sqrt(900+120*exp))/60;
}

class Globals {
  // Seconds spent on each
  static int timeSpentTD = 1*60 + 51;
  static int get timeSpentWK => timeSpentTD + 30*60 + 14;
  static int get timeSpentMH => timeSpentWK + 135*60 + 42;

  static int totalExercisesCompletedTD = 1;
  static int get totalExercisesCompletedWK => totalExercisesCompletedTD + 4;

  static int totalStepsTD = 0;

  static int streak = 6;
  static bool isStreakActive = false;

  static bool unlockedSumItUp = false;

  static int coins = 680;
  static int exp = 750;
  static int get level => expToLvl(exp).floor();
  static int get leftoverExp => exp - lvlToExp(level).floor();
  static int get requiredExp => (lvlToExp(level + 1) - lvlToExp(level)).floor();

  static int brainScore = 163;

  static Set<String> claimedMissions = {};
  static List<ExerciseMetadata> todayExercises = [
    ExerciseMetadata(type: ExerciseType.PerfectMatch, timeSpent: 90, score: 25),
    ExerciseMetadata(type: ExerciseType.PerfectMatch, timeSpent: 67, score: 26),
    ExerciseMetadata(type: ExerciseType.SumItUp, timeSpent: 90, score: 16),
    ExerciseMetadata(type: ExerciseType.SumItUp, timeSpent: 90, score: 14),
  ];

  static Map<DateTime, List<Map<String, dynamic>>> schedules = _getDummySchedules();

  static Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('timeSpentTD', timeSpentTD);
    await prefs.setInt('totalExercisesCompletedTD', totalExercisesCompletedTD);
    await prefs.setInt('totalStepsTD', totalStepsTD);
    await prefs.setInt('streak', streak);
    await prefs.setBool('isStreakActive', isStreakActive);
    await prefs.setBool('unlockedSumItUp', unlockedSumItUp);
    await prefs.setInt('coins', coins);
    await prefs.setInt('exp', exp);
    await prefs.setInt('brainScore', brainScore);
    await prefs.setStringList('claimedMissions', claimedMissions.toList());

    final todayExercisesJson =
        todayExercises.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('todayExercises', todayExercisesJson);

    final schedulesJson = schedules.map((key, value) =>
        MapEntry(key.toIso8601String(), value));
    await prefs.setString('schedules', jsonEncode(schedulesJson));
  }

  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    timeSpentTD = prefs.getInt('timeSpentTD') ?? 1 * 60 + 51;
    totalExercisesCompletedTD = prefs.getInt('totalExercisesCompletedTD') ?? 1;
    totalStepsTD = prefs.getInt('totalStepsTD') ?? 0;
    streak = prefs.getInt('streak') ?? 6;
    isStreakActive = prefs.getBool('isStreakActive') ?? false;
    unlockedSumItUp = prefs.getBool('unlockedSumItUp') ?? false;
    coins = prefs.getInt('coins') ?? 680;
    exp = prefs.getInt('exp') ?? 750;
    brainScore = prefs.getInt('brainScore') ?? 163;
    
    final claimedMissionsList = prefs.getStringList('claimedMissions');
    if (claimedMissionsList != null) {
      claimedMissions = claimedMissionsList.toSet();
    }

    final todayExercisesList = prefs.getStringList('todayExercises');
    if (todayExercisesList != null) {
      todayExercises = todayExercisesList
          .map((e) => ExerciseMetadata.fromJson(jsonDecode(e)))
          .toList();
    }

    final schedulesString = prefs.getString('schedules');
    if (schedulesString != null) {
      final Map<String, dynamic> decodedSchedules =
          jsonDecode(schedulesString);
      schedules = decodedSchedules.map((key, value) {
        final List<dynamic> listCallback = value;
        final listMap = listCallback.map((e) => e as Map<String, dynamic>).toList();
        return MapEntry(DateTime.parse(key), listMap);
      });
    } else {
        schedules = _getDummySchedules();
    }
  }

  static Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    
    // Reset to default values
    timeSpentTD = 1 * 60 + 51;
    totalExercisesCompletedTD = 1;
    totalStepsTD = 0;
    streak = 6;
    isStreakActive = false;
    unlockedSumItUp = false;
    coins = 680;
    exp = 750;
    brainScore = 163;
    claimedMissions = {};
    todayExercises = [
      ExerciseMetadata(type: ExerciseType.PerfectMatch, timeSpent: 90, score: 25),
      ExerciseMetadata(type: ExerciseType.PerfectMatch, timeSpent: 67, score: 26),
      ExerciseMetadata(type: ExerciseType.SumItUp, timeSpent: 90, score: 16),
      ExerciseMetadata(type: ExerciseType.SumItUp, timeSpent: 90, score: 14),
    ];
    schedules = _getDummySchedules();
  }

  static Map<DateTime, List<Map<String, dynamic>>> _getDummySchedules() {
    DateTime today = DateTime.now();
    today = DateTime(today.year, today.month, today.day);
    DateTime tomorrow = today.add(const Duration(days: 1));
    DateTime dayAfterTomorrow = today.add(const Duration(days: 2));

    return {
      today: [
        {
          'time': '07:30',
          'event': 'Wake up and brush your teeth',
          'completed': true
        },
        {'time': '08:30', 'event': 'Leave Home for Work', 'completed': false},
        {'time': '09:00', 'event': 'Company Meeting', 'completed': false},
        {'time': '12:00', 'event': 'Lunch break', 'completed': false},
      ],
      tomorrow: [
        {'time': '09:00', 'event': 'Brunch with Friends', 'completed': false},
        {'time': '11:00', 'event': 'Go to the Gym', 'completed': true},
        {'time': '14:00', 'event': 'Shopping at Mall', 'completed': false},
      ],
      dayAfterTomorrow: [
        {'time': '08:00', 'event': 'Go to Church', 'completed': false},
        {'time': '10:30', 'event': 'Brunch with Family', 'completed': false},
      ],
    };
  }
}
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
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
  final DateTime timestamp;

  ExerciseMetadata({
    required this.type,
    required this.timeSpent,
    required this.score,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'type': type.index,
        'timeSpent': timeSpent,
        'score': score,
        'timestamp': timestamp.toIso8601String(),
      };

  factory ExerciseMetadata.fromJson(Map<String, dynamic> json) {
    return ExerciseMetadata(
      type: ExerciseType.values[json['type']],
      timeSpent: json['timeSpent'],
      score: json['score'],
      timestamp: json['timestamp'] != null ? DateTime.parse(json['timestamp']) : DateTime.now(),
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
  static const String _wcagModeEnabledKey = 'wcagModeEnabled';
  static const String _textScaleFactorKey = 'textScaleFactor';
  static const double textScaleMin = 1.0;
  static const double textScaleMax = 2.5;
  static const double _defaultTextScale = 1.0;
  static final ValueNotifier<bool> wcagModeNotifier = ValueNotifier<bool>(false);
  static final ValueNotifier<double> textScaleNotifier =
      ValueNotifier<double>(_defaultTextScale);

  static bool get wcagModeEnabled => wcagModeNotifier.value;
  static double get textScaleFactor => textScaleNotifier.value;

  static double _normalizeTextScale(double scale) {
    if (scale.isNaN || scale.isInfinite) return _defaultTextScale;
    return scale.clamp(textScaleMin, textScaleMax).toDouble();
  }

  static Future<void> setWcagMode(bool enabled) async {
    if (wcagModeNotifier.value == enabled) return;
    wcagModeNotifier.value = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_wcagModeEnabledKey, enabled);
  }

  static Future<void> setTextScale(double scale, {bool persist = true}) async {
    final normalized = _normalizeTextScale(scale);
    if ((textScaleNotifier.value - normalized).abs() > 0.0001) {
      textScaleNotifier.value = normalized;
    }

    if (!persist) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_textScaleFactorKey, normalized);
  }

  // Seconds spent on each
  static int get timeSpentTD {
    final now = DateTime.now();
    return exercisesList
        .where((e) => e.timestamp.year == now.year && e.timestamp.month == now.month && e.timestamp.day == now.day)
        .fold(0, (sum, item) => sum + item.timeSpent);
  }

  static int get timeSpentWK {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    return exercisesList.where((e) {
      final exDate = DateTime(e.timestamp.year, e.timestamp.month, e.timestamp.day);
      final diff = todayDate.difference(exDate).inDays;
      return diff >= 0 && diff < 7;
    }).fold(0, (sum, item) => sum + item.timeSpent);
  }

  static int get timeSpentMH {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    return exercisesList.where((e) {
      final exDate = DateTime(e.timestamp.year, e.timestamp.month, e.timestamp.day);
      final diff = todayDate.difference(exDate).inDays;
      return diff >= 0 && diff < 30;
    }).fold(0, (sum, item) => sum + item.timeSpent);
  }

  static int get totalExercisesCompletedTD {
    final now = DateTime.now();
    return exercisesList
        .where((e) => e.timestamp.year == now.year && e.timestamp.month == now.month && e.timestamp.day == now.day)
        .length;
  }
  static int get totalExercisesCompletedWK => totalExercisesCompletedTD + 4;

  static int totalStepsTD = 0;

  static int get streak {
    final dates = exercisesList
        .map((e) => DateTime(e.timestamp.year, e.timestamp.month, e.timestamp.day))
        .toSet()
        .toList();
    dates.sort((a, b) => b.compareTo(a));

    if (dates.isEmpty) return 0;

    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);

    int currentStreak = 0;
    DateTime expectedDate = dates.first;

    if (expectedDate.isBefore(todayDate.subtract(const Duration(days: 1)))) {
      return 0; // Streak broken if most recent is older than yesterday
    }

    for (int i = 0; i < dates.length; i++) {
      if (dates[i] == expectedDate) {
        currentStreak++;
        expectedDate = expectedDate.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }
    return currentStreak;
  }

  static bool get isStreakActive {
    final now = DateTime.now();
    return exercisesList.any((e) => e.timestamp.year == now.year && e.timestamp.month == now.month && e.timestamp.day == now.day);
  }

  static bool unlockedSumItUp = false;
  static bool isThaiIdVerified = false;

  static int coins = 680;
  static int exp = 750;
  static int get level => expToLvl(exp).floor();
  static int get leftoverExp => exp - lvlToExp(level).floor();
  static int get requiredExp => (lvlToExp(level + 1) - lvlToExp(level)).floor();

  static int get brainScore => exercisesList.fold(0, (sum, item) => sum + item.score);

  static String get brainActivityFeedbackText {
    if (exercisesList.isEmpty) {
      return 'Start exercising to track your brain activities!';
    }
    
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    
    int recentScore = 0;
    int previousScore = 0;
    
    for (var ex in exercisesList) {
      final exDate = DateTime(ex.timestamp.year, ex.timestamp.month, ex.timestamp.day);
      final diff = todayDate.difference(exDate).inDays;
      
      if (diff >= 0 && diff < 3) {
        recentScore += ex.score;
      } else if (diff >= 3 && diff < 6) {
        previousScore += ex.score;
      }
    }
    
    if (previousScore == 0 && recentScore > 0) {
      return 'Your brain activities has increased significantly over the last 3 days';
    } else if (previousScore == 0 && recentScore == 0) {
      return 'Go ahead and complete some exercises today to boost your brain activity!';
    }
    
    double percentage = ((recentScore - previousScore) / previousScore) * 100;
    
    if (percentage > 0) {
      return 'Your brain activities has increased by ${percentage.toStringAsFixed(0)}% over the last 3 days';
    } else if (percentage < 0) {
      return 'Your brain activities has decreased by ${percentage.abs().toStringAsFixed(0)}% over the last 3 days';
    } else {
      return 'Your brain activities have been consistent over the last 3 days';
    }
  }

  static List<double> get past10DaysBars {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    Map<int, int> timeSpentMap = {};

    for (int i = 0; i < 11; i++) {
        timeSpentMap[i] = 0;
    }

    for (var ex in exercisesList) {
      final exDate = DateTime(ex.timestamp.year, ex.timestamp.month, ex.timestamp.day);
      final difference = todayDate.difference(exDate).inDays;
      if (difference >= 0 && difference <= 10) {
        timeSpentMap[difference] = (timeSpentMap[difference] ?? 0) + ex.timeSpent;
      }
    }

    int barsCount = isStreakActive ? 11 : 10;
    List<double> bars = [];
    int startDiff = isStreakActive ? 0 : 1; 
    
    int maxTime = -1;
    for (int i = startDiff; i < startDiff + barsCount; i++) {
        final spent = timeSpentMap[i] ?? 0;
        if (spent > maxTime) maxTime = spent;
    }

    for (int i = startDiff + barsCount - 1; i >= startDiff; i--) {
        final spent = timeSpentMap[i] ?? 0;
        if (maxTime == 0) {
            bars.add(0.0);
        } else {
            bars.add(spent / maxTime);
        }
    }

    return bars;
  }

  static Set<String> claimedMissions = {};
  static List<ExerciseMetadata> exercisesList = [
    ExerciseMetadata(type: ExerciseType.PerfectMatch, timeSpent: 90, score: 25, timestamp: DateTime.now().subtract(const Duration(days: 4))),
    ExerciseMetadata(type: ExerciseType.PerfectMatch, timeSpent: 67, score: 26, timestamp: DateTime.now().subtract(const Duration(days: 3))),
    ExerciseMetadata(type: ExerciseType.SumItUp, timeSpent: 90, score: 16, timestamp: DateTime.now().subtract(const Duration(days: 2))),
    ExerciseMetadata(type: ExerciseType.SumItUp, timeSpent: 90, score: 14, timestamp: DateTime.now().subtract(const Duration(days: 1))),
  ];

  static Map<DateTime, List<Map<String, dynamic>>> schedules = _getDummySchedules();

  static Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_wcagModeEnabledKey, wcagModeEnabled);
    await prefs.setDouble(_textScaleFactorKey, textScaleFactor);
    await prefs.setInt('totalStepsTD', totalStepsTD);
    await prefs.setBool('unlockedSumItUp', unlockedSumItUp);
    await prefs.setBool('isThaiIdVerified', isThaiIdVerified);
    await prefs.setInt('coins', coins);
    await prefs.setInt('exp', exp);
    await prefs.setStringList('claimedMissions', claimedMissions.toList());

    final exercisesListJson =
        exercisesList.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('exercisesList', exercisesListJson);

    final schedulesJson = schedules.map((key, value) =>
        MapEntry(key.toIso8601String(), value));
    await prefs.setString('schedules', jsonEncode(schedulesJson));
  }

  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    wcagModeNotifier.value = prefs.getBool(_wcagModeEnabledKey) ?? false;
    final storedTextScale = prefs.getDouble(_textScaleFactorKey) ??
        (prefs.getInt(_textScaleFactorKey)?.toDouble()) ??
        _defaultTextScale;
    textScaleNotifier.value = _normalizeTextScale(storedTextScale);
    totalStepsTD = prefs.getInt('totalStepsTD') ?? 0;
    unlockedSumItUp = prefs.getBool('unlockedSumItUp') ?? false;
    isThaiIdVerified = prefs.getBool('isThaiIdVerified') ?? false;
    coins = prefs.getInt('coins') ?? 680;
    exp = prefs.getInt('exp') ?? 750;
    
    final claimedMissionsList = prefs.getStringList('claimedMissions');
    if (claimedMissionsList != null) {
      claimedMissions = claimedMissionsList.toSet();
    }

    final exercisesListList = prefs.getStringList('exercisesList');
    if (exercisesListList != null) {
      exercisesList = exercisesListList
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
    wcagModeNotifier.value = false;
    textScaleNotifier.value = _defaultTextScale;
    totalStepsTD = 3246;
    isThaiIdVerified = false;
    unlockedSumItUp = false;
    coins = 680;
    exp = 750;
    claimedMissions = {};
    exercisesList = [
      ExerciseMetadata(type: ExerciseType.PerfectMatch, timeSpent: 90, score: 25, timestamp: DateTime.now().subtract(const Duration(days: 4))),
      ExerciseMetadata(type: ExerciseType.PerfectMatch, timeSpent: 67, score: 26, timestamp: DateTime.now().subtract(const Duration(days: 3))),
      ExerciseMetadata(type: ExerciseType.SumItUp, timeSpent: 90, score: 16, timestamp: DateTime.now().subtract(const Duration(days: 2))),
      ExerciseMetadata(type: ExerciseType.SumItUp, timeSpent: 90, score: 14, timestamp: DateTime.now().subtract(const Duration(days: 1))),
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

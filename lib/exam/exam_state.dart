import 'package:flutter/material.dart';

class ExamState {
  static Map<int, Map<String, dynamic>>? latestRecallItems;
  
  static int visualPalTotalWrongs = 0;
  static int memoryRecallWrongs = 0;
  
  static double trackATime = 0;
  static double trackBTime = 0;
  
  static int dsstCorrect = 0;
  static int dsstWrong = 0;
  static double dsstAvgTime = 0;

  static void reset() {
    latestRecallItems = null;
    visualPalTotalWrongs = 0;
    memoryRecallWrongs = 0;
    trackATime = 0;
    trackBTime = 0;
    dsstCorrect = 0;
    dsstWrong = 0;
    dsstAvgTime = 0;
  }

  static void printScores() {
    print('\n================================');
    print('      ALL EXAM SCORES REPORT');
    print('================================');
    print('Visual Pal (Learning) Wrongs : $visualPalTotalWrongs');
    print('Track A Time                 : ${trackATime.toStringAsFixed(2)} s');
    print('Track B Time                 : ${trackBTime.toStringAsFixed(2)} s');
    print('DSST Correct                 : $dsstCorrect');
    print('DSST Wrong                   : $dsstWrong');
    print('DSST Avg Reaction Time       : ${dsstAvgTime.toStringAsFixed(2)} s');
    print('Visual Pal (Recall) Wrongs   : $memoryRecallWrongs');
    print('--------------------------------');
    print('Total Estimated Score        : ${calculateTotalScore()} / 30');
    print('================================\n');
  }

  static int calculateTotalScore() {
    // 1. Visual Pal Score (Max 10 points)
    // Start with 10, deduct 1 point for every mistake across both stages.
    int memoryScore = 10 - (visualPalTotalWrongs + memoryRecallWrongs);
    if (memoryScore < 0) memoryScore = 0;

    // 2. Track A & B Score (Max 10 points)
    // Base 5 points each. Deduct 1 point for every 5 seconds over a baseline (e.g., 15s for A, 30s for B).
    int trackAScore = 5 - ((trackATime > 15 ? trackATime - 15 : 0) / 5).floor();
    if (trackAScore < 0) trackAScore = 0;
    
    int trackBScore = 5 - ((trackBTime > 30 ? trackBTime - 30 : 0) / 5).floor();
    if (trackBScore < 0) trackBScore = 0;
    
    int trackTotalScore = trackAScore + trackBScore;

    // 3. DSST Score (Max 10 points)
    // 1 point per correct answer, -1 per wrong. Maxes out at 10.
    int dsstScoreCalc = dsstCorrect - dsstWrong;
    int dsstFinalScore = dsstScoreCalc > 10 ? 10 : (dsstScoreCalc < 0 ? 0 : dsstScoreCalc);

    return memoryScore + trackTotalScore + dsstFinalScore;
  }
}

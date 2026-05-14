// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'FlexiFlow';

  @override
  String get navHome => 'Home';

  @override
  String get navMission => 'Mission';

  @override
  String get navStats => 'Stats';

  @override
  String get navTraining => 'Training';

  @override
  String navGoToTab(String label) {
    return 'Go to $label tab';
  }

  @override
  String get goBack => 'Go back';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileEditPersonalInfo => 'Edit personal information';

  @override
  String get profileFeedback => 'Feedback';

  @override
  String get profileFeedbackComingSoon => 'Feedback option coming soon!';

  @override
  String get languageSetting => 'Language';

  @override
  String get thaiLanguage => 'ไทย';

  @override
  String get englishLanguage => 'English';

  @override
  String get useWcag => 'Use WCAG 2.2 accessible UI';

  @override
  String get useWcagSubtitle => 'Higher contrast and larger touch targets';

  @override
  String get textSize => 'Text size';

  @override
  String get adjustTextScale => 'Adjust text scale from 100% to 250%';

  @override
  String get profileSignOut => 'Sign Out';

  @override
  String get confirmSignOutTitle => 'Sign Out';

  @override
  String get confirmSignOutMessage => 'Are you sure you want to sign out?';

  @override
  String get cancel => 'Cancel';

  @override
  String get yes => 'Yes';

  @override
  String get resetProgressTitle => 'Reset Progress';

  @override
  String get resetProgressMessage =>
      'Are you sure you want to reset all progress? This cannot be undone.';

  @override
  String get reset => 'Reset';

  @override
  String get progressResetDone => 'All progress has been reset.';

  @override
  String get levelShort => 'Lvl';

  @override
  String get loginWelcomeBack => 'Welcome Back';

  @override
  String get loginSignInToContinue => 'Sign in to continue';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get signIn => 'Sign In';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get signUp => 'Sign Up';

  @override
  String get loginMissingCredentials => 'Please enter both email and password';

  @override
  String get loginIncorrectCredentials => 'Incorrect email or password';

  @override
  String get unexpectedError => 'An unexpected error occurred';

  @override
  String get createAccount => 'Create Account';

  @override
  String get fullName => 'Full Name';

  @override
  String get emergencyContact => 'Emergency Contact';

  @override
  String get birthday => 'Birthday';

  @override
  String get gender => 'Gender';

  @override
  String get signupMissingFields => 'Please fill in all required fields';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get statsTitle => 'Stats';

  @override
  String get aiSuggestion => 'AI Suggestion';

  @override
  String get aiKeepUpMomentum => 'Keep up the momentum! Try ';

  @override
  String get aiToBoostScore => ' to boost your concentration score.';

  @override
  String get suggestionTryMoreScoreOn =>
      'Try getting a little bit more score on ';

  @override
  String get suggestionFasterOn => 'Might be a little bit faster on ';

  @override
  String get gamePerfectMatch => 'Perfect Match';

  @override
  String get gameSumItUp => 'Sum It Up';

  @override
  String get gameWander => 'Wander';

  @override
  String get recent => 'Recent';

  @override
  String get nothingToShow => 'Nothing to\nshow';

  @override
  String get brainScore => 'Brain score';

  @override
  String get brainScoreDesc =>
      'Focusing on calculation and memory leads to better results.';

  @override
  String get pointsShort => 'pts';

  @override
  String get steps => 'Steps';

  @override
  String get stepsShort => 'steps';

  @override
  String get timeSpent => 'Time Spent';

  @override
  String get today => 'today';

  @override
  String get week => 'week';

  @override
  String get month => 'month';

  @override
  String get hour => 'hour';

  @override
  String get minuteShort => 'min';

  @override
  String get secondShort => 'sec';

  @override
  String get trainingToday => 'Training today';

  @override
  String get rounds => 'Rounds';

  @override
  String get totalSessions => 'Total sessions';

  @override
  String get skillPerformance => 'Skill Performance';

  @override
  String get excellentMemory => 'Excellent memory';

  @override
  String get steadyCalculation => 'Steady calculation';

  @override
  String ptsAchieved(String score) {
    return '$score pts achieved';
  }

  @override
  String get recentActivity => 'Recent Activity';

  @override
  String get trainingTitle => 'Training';

  @override
  String get games => 'Games';

  @override
  String get days => 'Days';

  @override
  String get todoList => 'To Do List';

  @override
  String get add => 'Add';

  @override
  String get noTasksForToday => 'No tasks for today';

  @override
  String get tapAddToCreateSchedule => 'Tap \"Add\" to create a schedule';

  @override
  String eventDeleted(String event) {
    return 'Event \"$event\" deleted';
  }

  @override
  String get addEvent => 'Add Event';

  @override
  String get timeHhMm => 'Time (HH:MM)';

  @override
  String get eventDescription => 'Event Description';

  @override
  String get locked => 'LOCKED';

  @override
  String get unlockInShop => 'Unlock in Shop';

  @override
  String get homeOpenProfile => 'Open profile';

  @override
  String homeOpenService(String label) {
    return 'Open $label';
  }

  @override
  String get homeServicesTitle => 'Services';

  @override
  String get homeServiceDiscoverPosture => 'Discover Posture';

  @override
  String get homeServiceLeaderboard => 'Leaderboard';

  @override
  String get homeServiceChatbot => 'Chatbot';

  @override
  String get homeServiceShop => 'Shop';

  @override
  String get homeOthersTitle => 'Others';

  @override
  String get homeFeedbackSummary => 'Feedback Summary';

  @override
  String get homeStreak => 'Streak';

  @override
  String get homeTimeSpentPastTenDays => 'Time spent in the past 10 days';

  @override
  String homeStreakDaysCount(String count) {
    return '$count days';
  }

  @override
  String get missionHeaderYour => 'YOUR';

  @override
  String get missionHeaderMissions => 'MISSIONS';

  @override
  String get missionTabDaily => 'Daily';

  @override
  String get missionTabWeekly => 'Weekly';

  @override
  String get missionTabAll => 'All';

  @override
  String get missionTitleFirstExerciseOfDay => 'First exercise of the day';

  @override
  String get missionTitleComplete3Exercises => 'Complete 3 exercises';

  @override
  String get missionTitleWalk5000Steps => 'Walk 5,000 steps';

  @override
  String get missionTitlePlayPerfectMatch10Min =>
      'Play Perfect Match for 10 minutes';

  @override
  String get missionTitleComplete10Exercises => 'Complete 10 exercises';

  @override
  String get missionTitleReach200BrainScore => 'Reach 200 Brain Score';

  @override
  String get missionTitleExercise5DaysRow => 'Exercise 5 days in a row';

  @override
  String get missionTitleExercise20DaysRow => 'Exercise 20 days in a row';

  @override
  String get missionTitleReachLevel25 => 'Reach Level 25';

  @override
  String get missionTitleComplete20Exercises => 'Complete 20 exercises';

  @override
  String get missionStatusDone => 'Done';

  @override
  String get missionStatusClaim => 'Claim';

  @override
  String get shopTitle => 'Shop';

  @override
  String get shopCardDefaultTitle => 'General';

  @override
  String get shopCardDefaultDescription => 'Handpicked items just for you';

  @override
  String get shopCardUniversalTitle => 'Universal Coverage Scheme';

  @override
  String get shopCardUniversalDescription =>
      'Explore our full range of mostly from the government';

  @override
  String get shopCardAiaTitle => 'AIA Vitality';

  @override
  String get shopCardAiaDescription =>
      'Exclusive deals for AIA Vitality members';

  @override
  String get shopCardThaiIdTitle => 'Thai ID';

  @override
  String get shopCardThaiIdVerified => 'Successfully linked';

  @override
  String get shopCardThaiIdUnverified => 'Tap to verify your Thai ID';

  @override
  String get shopRequest => 'Request';

  @override
  String get shopMoreItemsComingSoon => 'More items coming soon';

  @override
  String get shopRequestItemTitle => 'Request Item';

  @override
  String get shopRequestItemPrompt => 'What would you like to see in the shop?';

  @override
  String get shopRequestItemHint => 'Enter item name...';

  @override
  String get submit => 'Submit';

  @override
  String get shopThankYouTitle => 'Thank You!';

  @override
  String get shopThankYouMessage => 'We have received your request.';

  @override
  String get closeLabel => 'Close';

  @override
  String get buyLabel => 'Buy';

  @override
  String get shopConfirmPurchaseTitle => 'Confirm Purchase';

  @override
  String shopConfirmPurchaseMessage(String itemName, String itemPrice) {
    return 'Are you sure you want to buy $itemName for $itemPrice coins?';
  }

  @override
  String shopPurchaseSuccess(String itemName) {
    return 'You have successfully purchased $itemName!';
  }

  @override
  String get shopItemUnlockWander => 'Unlock Wander';

  @override
  String get shopItemUnlockSawasdeeLandscape => 'Unlock Sawasdee Landscape';

  @override
  String get shopItemSushiroCoupon60 => 'Sushiro Coupon 60B';

  @override
  String get shopItemMkRestaurant150 => 'MK Restaurant 150B';

  @override
  String get shopItemMomo20Off => 'Momo Paradise 20% off';

  @override
  String get shopItemFreeMajorTicket => 'Free major cinema ticket';

  @override
  String get shopItemFreeSfPopcorn => 'Free medium popcorn at SF';

  @override
  String get shopItemPttFuel300 => 'PTT Station Fuel Card 300B';

  @override
  String get shopItemBcpFuel300 => 'BCP Station Fuel Card 300B';

  @override
  String get shopItemMeaPea150 => 'MEA/PEA 150B Discount';

  @override
  String get shopItemMwaPwa150 => 'MWA/PWA 150B Discount';

  @override
  String get shopItemNt250 => 'NT 250B Discount';

  @override
  String get shopItemMrt200 => 'MRT 200B Balance';

  @override
  String get shopItemThailandPost100 => 'Thailand Post 100B Balance';

  @override
  String get shopItemGovLottery => 'Government Lottery Ticket';

  @override
  String get chatbotNoResponse => 'No response';

  @override
  String chatbotConnectionError(String error) {
    return 'Sorry, I\'m having trouble connecting to the assistant. Please try again later.\\nError: $error';
  }

  @override
  String get chatbotMoreOptions => 'More options';

  @override
  String get chatbotTitleLexiAssistant => 'Lexi Assistant';

  @override
  String get chatbotSubtitleAlwaysHere => 'Always here to help';

  @override
  String get chatbotHowCanWeHelp => 'How can we help you?';

  @override
  String get chatbotAttachFile => 'Attach file';

  @override
  String get chatbotInputHint => 'Ask us....';

  @override
  String get chatbotSendMessage => 'Send message';

  @override
  String get chatbotJustNow => 'Just now';

  @override
  String chatbotMinutesAgo(String minutes) {
    return '${minutes}m ago';
  }

  @override
  String chatbotHoursAgo(String hours) {
    return '${hours}h ago';
  }

  @override
  String get chatbotClearChatHistory => 'Clear Chat History';

  @override
  String get chatbotHelpSupport => 'Help & Support';

  @override
  String get chatbotClearHistoryConfirm =>
      'Are you sure you want to clear all chat messages? This action cannot be undone.';

  @override
  String get chatbotClear => 'Clear';

  @override
  String get chatbotHelpTipsTitle => 'Help & Tips';

  @override
  String get chatbotHelpTipsHeader => 'How to get the best results:';

  @override
  String get chatbotHelpTipSpecificQuestions =>
      'Ask specific questions about FlexiFlow exercises';

  @override
  String get chatbotHelpTipPersonalizedRoutine =>
      'Request personalized workout routines';

  @override
  String get chatbotHelpTipFormTechnique =>
      'Get tips on proper form and technique';

  @override
  String get chatbotHelpTipSchedules =>
      'Ask about workout schedules and timing';

  @override
  String get chatbotHelpTipSuggestionChips =>
      'Use the suggestion chips for quick questions';

  @override
  String get chatbotGotIt => 'Got it!';

  @override
  String get chatbotSuggestion1 => 'What is FlexiFlow?';

  @override
  String get chatbotSuggestion2 => 'How much time should I spend?';

  @override
  String get chatbotSuggestion3 => 'How can I improve my flexibility?';

  @override
  String get chatbotSuggestion4 => 'What are the benefits of FlexiFlow?';

  @override
  String get chatbotSuggestion5 => 'Can you suggest a routine for me?';

  @override
  String get chatbotSuggestion6 => 'How do I track my progress?';

  @override
  String get chatbotSuggestion7 => 'What should I do if I feel pain?';

  @override
  String get chatbotSuggestion8 => 'How often should I practice?';

  @override
  String get chatbotSuggestion9 => 'What equipment do I need?';

  @override
  String get chatbotSuggestion10 => 'Can you help me with a specific pose?';

  @override
  String get chatbotSuggestion11 =>
      'What are the common mistakes in FlexiFlow?';

  @override
  String get chatbotSuggestion12 => 'How can I stay motivated?';

  @override
  String get chatbotSuggestion13 => 'What is the best time to practice?';

  @override
  String get chatbotSuggestion14 =>
      'How can I incorporate FlexiFlow into my daily routine?';

  @override
  String get leaderboardWeeklyRankings => 'Weekly Rankings';

  @override
  String get leaderboardYou => 'You';

  @override
  String leaderboardRankText(String rank) {
    return 'Rank $rank';
  }

  @override
  String get leaderboardAvgScore => 'AVG SCORE';

  @override
  String get leaderboardGamesLabel => 'GAMES';

  @override
  String get leaderboardStreakLabel => 'STREAK';

  @override
  String get leaderboardWantMoreCompetition => 'Want more competition?';

  @override
  String get leaderboardInviteDescription =>
      'Invite your friends to see who really rules the leaderboard!';

  @override
  String get leaderboardInviteFriends => 'Invite Friends';

  @override
  String get getStartedGestureTitle => 'L + Fingertip pinch';

  @override
  String get getStartedGestureDescription =>
      'Enhances movements skills and hand-eye coordination.';

  @override
  String get next => 'Next';

  @override
  String get gamePaused => 'PAUSED';

  @override
  String get gameScoreLabel => 'Score';

  @override
  String get gamePointsAbbrev => 'Pts';

  @override
  String get mathGameSelectDifficulty => 'Select Difficulty';

  @override
  String get mathGameChooseLevelToStart => 'Choose a level to start the game';

  @override
  String get mathGameLevelEasy => 'Easy (Addition)';

  @override
  String get mathGameLevelNormal => 'Normal (+, -)';

  @override
  String get mathGameLevelHard => 'Hard (+, -, x, ÷)';

  @override
  String get mathGameLevelExtreme => 'Extreme (Advanced Math)';

  @override
  String get mathGameExtremeNote =>
      '* Note: You might need a piece of paper for this one!';

  @override
  String mathGamePercentOfEquation(String percent, String number) {
    return '$percent% of $number = ?';
  }

  @override
  String get perfectMatchNameLabel => 'Name';

  @override
  String perfectMatchComboMultiplier(String multiplier) {
    return 'COMBO x$multiplier';
  }

  @override
  String perfectMatchComboHits(String count) {
    return '$count Hits!';
  }

  @override
  String perfectMatchPosePair(String left, String right) {
    return '$left + $right';
  }

  @override
  String get perfectMatchPosePartL => 'L';

  @override
  String get perfectMatchPosePartFingertipPinch => 'Fingertip pinch';

  @override
  String get perfectMatchPosePartPoint => 'Point';

  @override
  String get perfectMatchPosePartThumb => 'Thumb';

  @override
  String get perfectMatchPosePartPinky => 'Pinky';

  @override
  String get perfectMatchPosePartOne => 'One';

  @override
  String get perfectMatchPosePartTwo => 'Two';

  @override
  String get perfectMatchPosePartThree => 'Three';

  @override
  String get perfectMatchPosePartFour => 'Four';

  @override
  String get perfectMatchPosePartFive => 'Five';

  @override
  String get perfectMatchPosePartSix => 'Six';

  @override
  String get perfectMatchPosePartSeven => 'Seven';

  @override
  String get perfectMatchPosePartEight => 'Eight';

  @override
  String get perfectMatchPosePartNine => 'Nine';

  @override
  String get perfectMatchPosePartTen => 'Ten';

  @override
  String get wanderTitle => 'Wander Trace';

  @override
  String get wanderTraceRandomShapes => 'Trace Random Shapes';

  @override
  String get wanderDescription =>
      'A random shape appears each round: triangle, quadrilateral,\npentagon, star, or circle.\nTrace lines with your index fingertip until every edge is filled.';

  @override
  String get wanderStartTracing => 'Start Tracing';

  @override
  String get wanderStatusShowFinger => 'Show your index finger to place dots';

  @override
  String wanderStatusProgress(String shape, String completed, String total) {
    return '$shape  $completed / $total';
  }

  @override
  String get wanderShapeTriangle => 'Triangle';

  @override
  String get wanderShapeQuadrilateral => 'Quadrilateral';

  @override
  String get wanderShapePentagon => 'Pentagon';

  @override
  String get wanderShapeStar => 'Star';

  @override
  String get wanderShapeCircle => 'Circle';

  @override
  String get scoreCongratsYouScore => 'Congrats!  You score';

  @override
  String get scorePointsWord => 'points';

  @override
  String scoreInSeconds(String seconds) {
    return 'in $seconds seconds';
  }

  @override
  String scoreHighScore(String score) {
    return 'High score: $score';
  }
}

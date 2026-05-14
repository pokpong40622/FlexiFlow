import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_th.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('th')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'FlexiFlow'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navMission.
  ///
  /// In en, this message translates to:
  /// **'Mission'**
  String get navMission;

  /// No description provided for @navStats.
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get navStats;

  /// No description provided for @navTraining.
  ///
  /// In en, this message translates to:
  /// **'Training'**
  String get navTraining;

  /// No description provided for @navGoToTab.
  ///
  /// In en, this message translates to:
  /// **'Go to {label} tab'**
  String navGoToTab(String label);

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get goBack;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileEditPersonalInfo.
  ///
  /// In en, this message translates to:
  /// **'Edit personal information'**
  String get profileEditPersonalInfo;

  /// No description provided for @profileFeedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get profileFeedback;

  /// No description provided for @profileFeedbackComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Feedback option coming soon!'**
  String get profileFeedbackComingSoon;

  /// No description provided for @languageSetting.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageSetting;

  /// No description provided for @thaiLanguage.
  ///
  /// In en, this message translates to:
  /// **'ไทย'**
  String get thaiLanguage;

  /// No description provided for @englishLanguage.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get englishLanguage;

  /// No description provided for @useWcag.
  ///
  /// In en, this message translates to:
  /// **'Use WCAG 2.2 accessible UI'**
  String get useWcag;

  /// No description provided for @useWcagSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Higher contrast and larger touch targets'**
  String get useWcagSubtitle;

  /// No description provided for @textSize.
  ///
  /// In en, this message translates to:
  /// **'Text size'**
  String get textSize;

  /// No description provided for @adjustTextScale.
  ///
  /// In en, this message translates to:
  /// **'Adjust text scale from 100% to 250%'**
  String get adjustTextScale;

  /// No description provided for @profileSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get profileSignOut;

  /// No description provided for @confirmSignOutTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get confirmSignOutTitle;

  /// No description provided for @confirmSignOutMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get confirmSignOutMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @resetProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Progress'**
  String get resetProgressTitle;

  /// No description provided for @resetProgressMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reset all progress? This cannot be undone.'**
  String get resetProgressMessage;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @progressResetDone.
  ///
  /// In en, this message translates to:
  /// **'All progress has been reset.'**
  String get progressResetDone;

  /// No description provided for @levelShort.
  ///
  /// In en, this message translates to:
  /// **'Lvl'**
  String get levelShort;

  /// No description provided for @loginWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get loginWelcomeBack;

  /// No description provided for @loginSignInToContinue.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get loginSignInToContinue;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @loginMissingCredentials.
  ///
  /// In en, this message translates to:
  /// **'Please enter both email and password'**
  String get loginMissingCredentials;

  /// No description provided for @loginIncorrectCredentials.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email or password'**
  String get loginIncorrectCredentials;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred'**
  String get unexpectedError;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @emergencyContact.
  ///
  /// In en, this message translates to:
  /// **'Emergency Contact'**
  String get emergencyContact;

  /// No description provided for @birthday.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get birthday;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @signupMissingFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all required fields'**
  String get signupMissingFields;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @statsTitle.
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get statsTitle;

  /// No description provided for @aiSuggestion.
  ///
  /// In en, this message translates to:
  /// **'AI Suggestion'**
  String get aiSuggestion;

  /// No description provided for @aiKeepUpMomentum.
  ///
  /// In en, this message translates to:
  /// **'Keep up the momentum! Try '**
  String get aiKeepUpMomentum;

  /// No description provided for @aiToBoostScore.
  ///
  /// In en, this message translates to:
  /// **' to boost your concentration score.'**
  String get aiToBoostScore;

  /// No description provided for @suggestionTryMoreScoreOn.
  ///
  /// In en, this message translates to:
  /// **'Try getting a little bit more score on '**
  String get suggestionTryMoreScoreOn;

  /// No description provided for @suggestionFasterOn.
  ///
  /// In en, this message translates to:
  /// **'Might be a little bit faster on '**
  String get suggestionFasterOn;

  /// No description provided for @gamePerfectMatch.
  ///
  /// In en, this message translates to:
  /// **'Perfect Match'**
  String get gamePerfectMatch;

  /// No description provided for @gameSumItUp.
  ///
  /// In en, this message translates to:
  /// **'Sum It Up'**
  String get gameSumItUp;

  /// No description provided for @gameWander.
  ///
  /// In en, this message translates to:
  /// **'Wander'**
  String get gameWander;

  /// No description provided for @recent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get recent;

  /// No description provided for @nothingToShow.
  ///
  /// In en, this message translates to:
  /// **'Nothing to\nshow'**
  String get nothingToShow;

  /// No description provided for @brainScore.
  ///
  /// In en, this message translates to:
  /// **'Brain score'**
  String get brainScore;

  /// No description provided for @brainScoreDesc.
  ///
  /// In en, this message translates to:
  /// **'Focusing on calculation and memory leads to better results.'**
  String get brainScoreDesc;

  /// No description provided for @pointsShort.
  ///
  /// In en, this message translates to:
  /// **'pts'**
  String get pointsShort;

  /// No description provided for @steps.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get steps;

  /// No description provided for @stepsShort.
  ///
  /// In en, this message translates to:
  /// **'steps'**
  String get stepsShort;

  /// No description provided for @timeSpent.
  ///
  /// In en, this message translates to:
  /// **'Time Spent'**
  String get timeSpent;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'today'**
  String get today;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'week'**
  String get week;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'month'**
  String get month;

  /// No description provided for @hour.
  ///
  /// In en, this message translates to:
  /// **'hour'**
  String get hour;

  /// No description provided for @minuteShort.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get minuteShort;

  /// No description provided for @secondShort.
  ///
  /// In en, this message translates to:
  /// **'sec'**
  String get secondShort;

  /// No description provided for @trainingToday.
  ///
  /// In en, this message translates to:
  /// **'Training today'**
  String get trainingToday;

  /// No description provided for @rounds.
  ///
  /// In en, this message translates to:
  /// **'Rounds'**
  String get rounds;

  /// No description provided for @totalSessions.
  ///
  /// In en, this message translates to:
  /// **'Total sessions'**
  String get totalSessions;

  /// No description provided for @skillPerformance.
  ///
  /// In en, this message translates to:
  /// **'Skill Performance'**
  String get skillPerformance;

  /// No description provided for @excellentMemory.
  ///
  /// In en, this message translates to:
  /// **'Excellent memory'**
  String get excellentMemory;

  /// No description provided for @steadyCalculation.
  ///
  /// In en, this message translates to:
  /// **'Steady calculation'**
  String get steadyCalculation;

  /// No description provided for @ptsAchieved.
  ///
  /// In en, this message translates to:
  /// **'{score} pts achieved'**
  String ptsAchieved(String score);

  /// No description provided for @recentActivity.
  ///
  /// In en, this message translates to:
  /// **'Recent Activity'**
  String get recentActivity;

  /// No description provided for @trainingTitle.
  ///
  /// In en, this message translates to:
  /// **'Training'**
  String get trainingTitle;

  /// No description provided for @games.
  ///
  /// In en, this message translates to:
  /// **'Games'**
  String get games;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get days;

  /// No description provided for @todoList.
  ///
  /// In en, this message translates to:
  /// **'To Do List'**
  String get todoList;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @noTasksForToday.
  ///
  /// In en, this message translates to:
  /// **'No tasks for today'**
  String get noTasksForToday;

  /// No description provided for @tapAddToCreateSchedule.
  ///
  /// In en, this message translates to:
  /// **'Tap \"Add\" to create a schedule'**
  String get tapAddToCreateSchedule;

  /// No description provided for @eventDeleted.
  ///
  /// In en, this message translates to:
  /// **'Event \"{event}\" deleted'**
  String eventDeleted(String event);

  /// No description provided for @addEvent.
  ///
  /// In en, this message translates to:
  /// **'Add Event'**
  String get addEvent;

  /// No description provided for @timeHhMm.
  ///
  /// In en, this message translates to:
  /// **'Time (HH:MM)'**
  String get timeHhMm;

  /// No description provided for @eventDescription.
  ///
  /// In en, this message translates to:
  /// **'Event Description'**
  String get eventDescription;

  /// No description provided for @locked.
  ///
  /// In en, this message translates to:
  /// **'LOCKED'**
  String get locked;

  /// No description provided for @unlockInShop.
  ///
  /// In en, this message translates to:
  /// **'Unlock in Shop'**
  String get unlockInShop;

  /// No description provided for @homeOpenProfile.
  ///
  /// In en, this message translates to:
  /// **'Open profile'**
  String get homeOpenProfile;

  /// No description provided for @homeOpenService.
  ///
  /// In en, this message translates to:
  /// **'Open {label}'**
  String homeOpenService(String label);

  /// No description provided for @homeServicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get homeServicesTitle;

  /// No description provided for @homeServiceDiscoverPosture.
  ///
  /// In en, this message translates to:
  /// **'Discover Posture'**
  String get homeServiceDiscoverPosture;

  /// No description provided for @homeServiceLeaderboard.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get homeServiceLeaderboard;

  /// No description provided for @homeServiceChatbot.
  ///
  /// In en, this message translates to:
  /// **'Chatbot'**
  String get homeServiceChatbot;

  /// No description provided for @homeServiceShop.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get homeServiceShop;

  /// No description provided for @homeOthersTitle.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get homeOthersTitle;

  /// No description provided for @homeFeedbackSummary.
  ///
  /// In en, this message translates to:
  /// **'Feedback Summary'**
  String get homeFeedbackSummary;

  /// No description provided for @homeStreak.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get homeStreak;

  /// No description provided for @homeTimeSpentPastTenDays.
  ///
  /// In en, this message translates to:
  /// **'Time spent in the past 10 days'**
  String get homeTimeSpentPastTenDays;

  /// No description provided for @homeStreakDaysCount.
  ///
  /// In en, this message translates to:
  /// **'{count} days'**
  String homeStreakDaysCount(String count);

  /// No description provided for @missionHeaderYour.
  ///
  /// In en, this message translates to:
  /// **'YOUR'**
  String get missionHeaderYour;

  /// No description provided for @missionHeaderMissions.
  ///
  /// In en, this message translates to:
  /// **'MISSIONS'**
  String get missionHeaderMissions;

  /// No description provided for @missionTabDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get missionTabDaily;

  /// No description provided for @missionTabWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get missionTabWeekly;

  /// No description provided for @missionTabAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get missionTabAll;

  /// No description provided for @missionTitleFirstExerciseOfDay.
  ///
  /// In en, this message translates to:
  /// **'First exercise of the day'**
  String get missionTitleFirstExerciseOfDay;

  /// No description provided for @missionTitleComplete3Exercises.
  ///
  /// In en, this message translates to:
  /// **'Complete 3 exercises'**
  String get missionTitleComplete3Exercises;

  /// No description provided for @missionTitleWalk5000Steps.
  ///
  /// In en, this message translates to:
  /// **'Walk 5,000 steps'**
  String get missionTitleWalk5000Steps;

  /// No description provided for @missionTitlePlayPerfectMatch10Min.
  ///
  /// In en, this message translates to:
  /// **'Play Perfect Match for 10 minutes'**
  String get missionTitlePlayPerfectMatch10Min;

  /// No description provided for @missionTitleComplete10Exercises.
  ///
  /// In en, this message translates to:
  /// **'Complete 10 exercises'**
  String get missionTitleComplete10Exercises;

  /// No description provided for @missionTitleReach200BrainScore.
  ///
  /// In en, this message translates to:
  /// **'Reach 200 Brain Score'**
  String get missionTitleReach200BrainScore;

  /// No description provided for @missionTitleExercise5DaysRow.
  ///
  /// In en, this message translates to:
  /// **'Exercise 5 days in a row'**
  String get missionTitleExercise5DaysRow;

  /// No description provided for @missionTitleExercise20DaysRow.
  ///
  /// In en, this message translates to:
  /// **'Exercise 20 days in a row'**
  String get missionTitleExercise20DaysRow;

  /// No description provided for @missionTitleReachLevel25.
  ///
  /// In en, this message translates to:
  /// **'Reach Level 25'**
  String get missionTitleReachLevel25;

  /// No description provided for @missionTitleComplete20Exercises.
  ///
  /// In en, this message translates to:
  /// **'Complete 20 exercises'**
  String get missionTitleComplete20Exercises;

  /// No description provided for @missionStatusDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get missionStatusDone;

  /// No description provided for @missionStatusClaim.
  ///
  /// In en, this message translates to:
  /// **'Claim'**
  String get missionStatusClaim;

  /// No description provided for @shopTitle.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get shopTitle;

  /// No description provided for @shopCardDefaultTitle.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get shopCardDefaultTitle;

  /// No description provided for @shopCardDefaultDescription.
  ///
  /// In en, this message translates to:
  /// **'Handpicked items just for you'**
  String get shopCardDefaultDescription;

  /// No description provided for @shopCardUniversalTitle.
  ///
  /// In en, this message translates to:
  /// **'Universal Coverage Scheme'**
  String get shopCardUniversalTitle;

  /// No description provided for @shopCardUniversalDescription.
  ///
  /// In en, this message translates to:
  /// **'Explore our full range of mostly from the government'**
  String get shopCardUniversalDescription;

  /// No description provided for @shopCardAiaTitle.
  ///
  /// In en, this message translates to:
  /// **'AIA Vitality'**
  String get shopCardAiaTitle;

  /// No description provided for @shopCardAiaDescription.
  ///
  /// In en, this message translates to:
  /// **'Exclusive deals for AIA Vitality members'**
  String get shopCardAiaDescription;

  /// No description provided for @shopCardThaiIdTitle.
  ///
  /// In en, this message translates to:
  /// **'Thai ID'**
  String get shopCardThaiIdTitle;

  /// No description provided for @shopCardThaiIdVerified.
  ///
  /// In en, this message translates to:
  /// **'Successfully linked'**
  String get shopCardThaiIdVerified;

  /// No description provided for @shopCardThaiIdUnverified.
  ///
  /// In en, this message translates to:
  /// **'Tap to verify your Thai ID'**
  String get shopCardThaiIdUnverified;

  /// No description provided for @shopRequest.
  ///
  /// In en, this message translates to:
  /// **'Request'**
  String get shopRequest;

  /// No description provided for @shopMoreItemsComingSoon.
  ///
  /// In en, this message translates to:
  /// **'More items coming soon'**
  String get shopMoreItemsComingSoon;

  /// No description provided for @shopRequestItemTitle.
  ///
  /// In en, this message translates to:
  /// **'Request Item'**
  String get shopRequestItemTitle;

  /// No description provided for @shopRequestItemPrompt.
  ///
  /// In en, this message translates to:
  /// **'What would you like to see in the shop?'**
  String get shopRequestItemPrompt;

  /// No description provided for @shopRequestItemHint.
  ///
  /// In en, this message translates to:
  /// **'Enter item name...'**
  String get shopRequestItemHint;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @shopThankYouTitle.
  ///
  /// In en, this message translates to:
  /// **'Thank You!'**
  String get shopThankYouTitle;

  /// No description provided for @shopThankYouMessage.
  ///
  /// In en, this message translates to:
  /// **'We have received your request.'**
  String get shopThankYouMessage;

  /// No description provided for @closeLabel.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeLabel;

  /// No description provided for @buyLabel.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get buyLabel;

  /// No description provided for @shopConfirmPurchaseTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Purchase'**
  String get shopConfirmPurchaseTitle;

  /// No description provided for @shopConfirmPurchaseMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to buy {itemName} for {itemPrice} coins?'**
  String shopConfirmPurchaseMessage(String itemName, String itemPrice);

  /// No description provided for @shopPurchaseSuccess.
  ///
  /// In en, this message translates to:
  /// **'You have successfully purchased {itemName}!'**
  String shopPurchaseSuccess(String itemName);

  /// No description provided for @shopItemUnlockWander.
  ///
  /// In en, this message translates to:
  /// **'Unlock Wander'**
  String get shopItemUnlockWander;

  /// No description provided for @shopItemUnlockSawasdeeLandscape.
  ///
  /// In en, this message translates to:
  /// **'Unlock Sawasdee Landscape'**
  String get shopItemUnlockSawasdeeLandscape;

  /// No description provided for @shopItemSushiroCoupon60.
  ///
  /// In en, this message translates to:
  /// **'Sushiro Coupon 60B'**
  String get shopItemSushiroCoupon60;

  /// No description provided for @shopItemMkRestaurant150.
  ///
  /// In en, this message translates to:
  /// **'MK Restaurant 150B'**
  String get shopItemMkRestaurant150;

  /// No description provided for @shopItemMomo20Off.
  ///
  /// In en, this message translates to:
  /// **'Momo Paradise 20% off'**
  String get shopItemMomo20Off;

  /// No description provided for @shopItemFreeMajorTicket.
  ///
  /// In en, this message translates to:
  /// **'Free major cinema ticket'**
  String get shopItemFreeMajorTicket;

  /// No description provided for @shopItemFreeSfPopcorn.
  ///
  /// In en, this message translates to:
  /// **'Free medium popcorn at SF'**
  String get shopItemFreeSfPopcorn;

  /// No description provided for @shopItemPttFuel300.
  ///
  /// In en, this message translates to:
  /// **'PTT Station Fuel Card 300B'**
  String get shopItemPttFuel300;

  /// No description provided for @shopItemBcpFuel300.
  ///
  /// In en, this message translates to:
  /// **'BCP Station Fuel Card 300B'**
  String get shopItemBcpFuel300;

  /// No description provided for @shopItemMeaPea150.
  ///
  /// In en, this message translates to:
  /// **'MEA/PEA 150B Discount'**
  String get shopItemMeaPea150;

  /// No description provided for @shopItemMwaPwa150.
  ///
  /// In en, this message translates to:
  /// **'MWA/PWA 150B Discount'**
  String get shopItemMwaPwa150;

  /// No description provided for @shopItemNt250.
  ///
  /// In en, this message translates to:
  /// **'NT 250B Discount'**
  String get shopItemNt250;

  /// No description provided for @shopItemMrt200.
  ///
  /// In en, this message translates to:
  /// **'MRT 200B Balance'**
  String get shopItemMrt200;

  /// No description provided for @shopItemThailandPost100.
  ///
  /// In en, this message translates to:
  /// **'Thailand Post 100B Balance'**
  String get shopItemThailandPost100;

  /// No description provided for @shopItemGovLottery.
  ///
  /// In en, this message translates to:
  /// **'Government Lottery Ticket'**
  String get shopItemGovLottery;

  /// No description provided for @chatbotNoResponse.
  ///
  /// In en, this message translates to:
  /// **'No response'**
  String get chatbotNoResponse;

  /// No description provided for @chatbotConnectionError.
  ///
  /// In en, this message translates to:
  /// **'Sorry, I\'m having trouble connecting to the assistant. Please try again later.\\nError: {error}'**
  String chatbotConnectionError(String error);

  /// No description provided for @chatbotMoreOptions.
  ///
  /// In en, this message translates to:
  /// **'More options'**
  String get chatbotMoreOptions;

  /// No description provided for @chatbotTitleLexiAssistant.
  ///
  /// In en, this message translates to:
  /// **'Lexi Assistant'**
  String get chatbotTitleLexiAssistant;

  /// No description provided for @chatbotSubtitleAlwaysHere.
  ///
  /// In en, this message translates to:
  /// **'Always here to help'**
  String get chatbotSubtitleAlwaysHere;

  /// No description provided for @chatbotHowCanWeHelp.
  ///
  /// In en, this message translates to:
  /// **'How can we help you?'**
  String get chatbotHowCanWeHelp;

  /// No description provided for @chatbotAttachFile.
  ///
  /// In en, this message translates to:
  /// **'Attach file'**
  String get chatbotAttachFile;

  /// No description provided for @chatbotInputHint.
  ///
  /// In en, this message translates to:
  /// **'Ask us....'**
  String get chatbotInputHint;

  /// No description provided for @chatbotSendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send message'**
  String get chatbotSendMessage;

  /// No description provided for @chatbotJustNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get chatbotJustNow;

  /// No description provided for @chatbotMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m ago'**
  String chatbotMinutesAgo(String minutes);

  /// No description provided for @chatbotHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours}h ago'**
  String chatbotHoursAgo(String hours);

  /// No description provided for @chatbotClearChatHistory.
  ///
  /// In en, this message translates to:
  /// **'Clear Chat History'**
  String get chatbotClearChatHistory;

  /// No description provided for @chatbotHelpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get chatbotHelpSupport;

  /// No description provided for @chatbotClearHistoryConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear all chat messages? This action cannot be undone.'**
  String get chatbotClearHistoryConfirm;

  /// No description provided for @chatbotClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get chatbotClear;

  /// No description provided for @chatbotHelpTipsTitle.
  ///
  /// In en, this message translates to:
  /// **'Help & Tips'**
  String get chatbotHelpTipsTitle;

  /// No description provided for @chatbotHelpTipsHeader.
  ///
  /// In en, this message translates to:
  /// **'How to get the best results:'**
  String get chatbotHelpTipsHeader;

  /// No description provided for @chatbotHelpTipSpecificQuestions.
  ///
  /// In en, this message translates to:
  /// **'Ask specific questions about FlexiFlow exercises'**
  String get chatbotHelpTipSpecificQuestions;

  /// No description provided for @chatbotHelpTipPersonalizedRoutine.
  ///
  /// In en, this message translates to:
  /// **'Request personalized workout routines'**
  String get chatbotHelpTipPersonalizedRoutine;

  /// No description provided for @chatbotHelpTipFormTechnique.
  ///
  /// In en, this message translates to:
  /// **'Get tips on proper form and technique'**
  String get chatbotHelpTipFormTechnique;

  /// No description provided for @chatbotHelpTipSchedules.
  ///
  /// In en, this message translates to:
  /// **'Ask about workout schedules and timing'**
  String get chatbotHelpTipSchedules;

  /// No description provided for @chatbotHelpTipSuggestionChips.
  ///
  /// In en, this message translates to:
  /// **'Use the suggestion chips for quick questions'**
  String get chatbotHelpTipSuggestionChips;

  /// No description provided for @chatbotGotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it!'**
  String get chatbotGotIt;

  /// No description provided for @chatbotSuggestion1.
  ///
  /// In en, this message translates to:
  /// **'What is FlexiFlow?'**
  String get chatbotSuggestion1;

  /// No description provided for @chatbotSuggestion2.
  ///
  /// In en, this message translates to:
  /// **'How much time should I spend?'**
  String get chatbotSuggestion2;

  /// No description provided for @chatbotSuggestion3.
  ///
  /// In en, this message translates to:
  /// **'How can I improve my flexibility?'**
  String get chatbotSuggestion3;

  /// No description provided for @chatbotSuggestion4.
  ///
  /// In en, this message translates to:
  /// **'What are the benefits of FlexiFlow?'**
  String get chatbotSuggestion4;

  /// No description provided for @chatbotSuggestion5.
  ///
  /// In en, this message translates to:
  /// **'Can you suggest a routine for me?'**
  String get chatbotSuggestion5;

  /// No description provided for @chatbotSuggestion6.
  ///
  /// In en, this message translates to:
  /// **'How do I track my progress?'**
  String get chatbotSuggestion6;

  /// No description provided for @chatbotSuggestion7.
  ///
  /// In en, this message translates to:
  /// **'What should I do if I feel pain?'**
  String get chatbotSuggestion7;

  /// No description provided for @chatbotSuggestion8.
  ///
  /// In en, this message translates to:
  /// **'How often should I practice?'**
  String get chatbotSuggestion8;

  /// No description provided for @chatbotSuggestion9.
  ///
  /// In en, this message translates to:
  /// **'What equipment do I need?'**
  String get chatbotSuggestion9;

  /// No description provided for @chatbotSuggestion10.
  ///
  /// In en, this message translates to:
  /// **'Can you help me with a specific pose?'**
  String get chatbotSuggestion10;

  /// No description provided for @chatbotSuggestion11.
  ///
  /// In en, this message translates to:
  /// **'What are the common mistakes in FlexiFlow?'**
  String get chatbotSuggestion11;

  /// No description provided for @chatbotSuggestion12.
  ///
  /// In en, this message translates to:
  /// **'How can I stay motivated?'**
  String get chatbotSuggestion12;

  /// No description provided for @chatbotSuggestion13.
  ///
  /// In en, this message translates to:
  /// **'What is the best time to practice?'**
  String get chatbotSuggestion13;

  /// No description provided for @chatbotSuggestion14.
  ///
  /// In en, this message translates to:
  /// **'How can I incorporate FlexiFlow into my daily routine?'**
  String get chatbotSuggestion14;

  /// No description provided for @leaderboardWeeklyRankings.
  ///
  /// In en, this message translates to:
  /// **'Weekly Rankings'**
  String get leaderboardWeeklyRankings;

  /// No description provided for @leaderboardYou.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get leaderboardYou;

  /// No description provided for @leaderboardRankText.
  ///
  /// In en, this message translates to:
  /// **'Rank {rank}'**
  String leaderboardRankText(String rank);

  /// No description provided for @leaderboardAvgScore.
  ///
  /// In en, this message translates to:
  /// **'AVG SCORE'**
  String get leaderboardAvgScore;

  /// No description provided for @leaderboardGamesLabel.
  ///
  /// In en, this message translates to:
  /// **'GAMES'**
  String get leaderboardGamesLabel;

  /// No description provided for @leaderboardStreakLabel.
  ///
  /// In en, this message translates to:
  /// **'STREAK'**
  String get leaderboardStreakLabel;

  /// No description provided for @leaderboardWantMoreCompetition.
  ///
  /// In en, this message translates to:
  /// **'Want more competition?'**
  String get leaderboardWantMoreCompetition;

  /// No description provided for @leaderboardInviteDescription.
  ///
  /// In en, this message translates to:
  /// **'Invite your friends to see who really rules the leaderboard!'**
  String get leaderboardInviteDescription;

  /// No description provided for @leaderboardInviteFriends.
  ///
  /// In en, this message translates to:
  /// **'Invite Friends'**
  String get leaderboardInviteFriends;

  /// No description provided for @getStartedGestureTitle.
  ///
  /// In en, this message translates to:
  /// **'L + Fingertip pinch'**
  String get getStartedGestureTitle;

  /// No description provided for @getStartedGestureDescription.
  ///
  /// In en, this message translates to:
  /// **'Enhances movements skills and hand-eye coordination.'**
  String get getStartedGestureDescription;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @gamePaused.
  ///
  /// In en, this message translates to:
  /// **'PAUSED'**
  String get gamePaused;

  /// No description provided for @gameScoreLabel.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get gameScoreLabel;

  /// No description provided for @gamePointsAbbrev.
  ///
  /// In en, this message translates to:
  /// **'Pts'**
  String get gamePointsAbbrev;

  /// No description provided for @mathGameSelectDifficulty.
  ///
  /// In en, this message translates to:
  /// **'Select Difficulty'**
  String get mathGameSelectDifficulty;

  /// No description provided for @mathGameChooseLevelToStart.
  ///
  /// In en, this message translates to:
  /// **'Choose a level to start the game'**
  String get mathGameChooseLevelToStart;

  /// No description provided for @mathGameLevelEasy.
  ///
  /// In en, this message translates to:
  /// **'Easy (Addition)'**
  String get mathGameLevelEasy;

  /// No description provided for @mathGameLevelNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal (+, -)'**
  String get mathGameLevelNormal;

  /// No description provided for @mathGameLevelHard.
  ///
  /// In en, this message translates to:
  /// **'Hard (+, -, x, ÷)'**
  String get mathGameLevelHard;

  /// No description provided for @mathGameLevelExtreme.
  ///
  /// In en, this message translates to:
  /// **'Extreme (Advanced Math)'**
  String get mathGameLevelExtreme;

  /// No description provided for @mathGameExtremeNote.
  ///
  /// In en, this message translates to:
  /// **'* Note: You might need a piece of paper for this one!'**
  String get mathGameExtremeNote;

  /// No description provided for @mathGamePercentOfEquation.
  ///
  /// In en, this message translates to:
  /// **'{percent}% of {number} = ?'**
  String mathGamePercentOfEquation(String percent, String number);

  /// No description provided for @perfectMatchNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get perfectMatchNameLabel;

  /// No description provided for @perfectMatchComboMultiplier.
  ///
  /// In en, this message translates to:
  /// **'COMBO x{multiplier}'**
  String perfectMatchComboMultiplier(String multiplier);

  /// No description provided for @perfectMatchComboHits.
  ///
  /// In en, this message translates to:
  /// **'{count} Hits!'**
  String perfectMatchComboHits(String count);

  /// No description provided for @perfectMatchPosePair.
  ///
  /// In en, this message translates to:
  /// **'{left} + {right}'**
  String perfectMatchPosePair(String left, String right);

  /// No description provided for @perfectMatchPosePartL.
  ///
  /// In en, this message translates to:
  /// **'L'**
  String get perfectMatchPosePartL;

  /// No description provided for @perfectMatchPosePartFingertipPinch.
  ///
  /// In en, this message translates to:
  /// **'Fingertip pinch'**
  String get perfectMatchPosePartFingertipPinch;

  /// No description provided for @perfectMatchPosePartPoint.
  ///
  /// In en, this message translates to:
  /// **'Point'**
  String get perfectMatchPosePartPoint;

  /// No description provided for @perfectMatchPosePartThumb.
  ///
  /// In en, this message translates to:
  /// **'Thumb'**
  String get perfectMatchPosePartThumb;

  /// No description provided for @perfectMatchPosePartPinky.
  ///
  /// In en, this message translates to:
  /// **'Pinky'**
  String get perfectMatchPosePartPinky;

  /// No description provided for @perfectMatchPosePartOne.
  ///
  /// In en, this message translates to:
  /// **'One'**
  String get perfectMatchPosePartOne;

  /// No description provided for @perfectMatchPosePartTwo.
  ///
  /// In en, this message translates to:
  /// **'Two'**
  String get perfectMatchPosePartTwo;

  /// No description provided for @perfectMatchPosePartThree.
  ///
  /// In en, this message translates to:
  /// **'Three'**
  String get perfectMatchPosePartThree;

  /// No description provided for @perfectMatchPosePartFour.
  ///
  /// In en, this message translates to:
  /// **'Four'**
  String get perfectMatchPosePartFour;

  /// No description provided for @perfectMatchPosePartFive.
  ///
  /// In en, this message translates to:
  /// **'Five'**
  String get perfectMatchPosePartFive;

  /// No description provided for @perfectMatchPosePartSix.
  ///
  /// In en, this message translates to:
  /// **'Six'**
  String get perfectMatchPosePartSix;

  /// No description provided for @perfectMatchPosePartSeven.
  ///
  /// In en, this message translates to:
  /// **'Seven'**
  String get perfectMatchPosePartSeven;

  /// No description provided for @perfectMatchPosePartEight.
  ///
  /// In en, this message translates to:
  /// **'Eight'**
  String get perfectMatchPosePartEight;

  /// No description provided for @perfectMatchPosePartNine.
  ///
  /// In en, this message translates to:
  /// **'Nine'**
  String get perfectMatchPosePartNine;

  /// No description provided for @perfectMatchPosePartTen.
  ///
  /// In en, this message translates to:
  /// **'Ten'**
  String get perfectMatchPosePartTen;

  /// No description provided for @wanderTitle.
  ///
  /// In en, this message translates to:
  /// **'Wander Trace'**
  String get wanderTitle;

  /// No description provided for @wanderTraceRandomShapes.
  ///
  /// In en, this message translates to:
  /// **'Trace Random Shapes'**
  String get wanderTraceRandomShapes;

  /// No description provided for @wanderDescription.
  ///
  /// In en, this message translates to:
  /// **'A random shape appears each round: triangle, quadrilateral,\npentagon, star, or circle.\nTrace lines with your index fingertip until every edge is filled.'**
  String get wanderDescription;

  /// No description provided for @wanderStartTracing.
  ///
  /// In en, this message translates to:
  /// **'Start Tracing'**
  String get wanderStartTracing;

  /// No description provided for @wanderStatusShowFinger.
  ///
  /// In en, this message translates to:
  /// **'Show your index finger to place dots'**
  String get wanderStatusShowFinger;

  /// No description provided for @wanderStatusProgress.
  ///
  /// In en, this message translates to:
  /// **'{shape}  {completed} / {total}'**
  String wanderStatusProgress(String shape, String completed, String total);

  /// No description provided for @wanderShapeTriangle.
  ///
  /// In en, this message translates to:
  /// **'Triangle'**
  String get wanderShapeTriangle;

  /// No description provided for @wanderShapeQuadrilateral.
  ///
  /// In en, this message translates to:
  /// **'Quadrilateral'**
  String get wanderShapeQuadrilateral;

  /// No description provided for @wanderShapePentagon.
  ///
  /// In en, this message translates to:
  /// **'Pentagon'**
  String get wanderShapePentagon;

  /// No description provided for @wanderShapeStar.
  ///
  /// In en, this message translates to:
  /// **'Star'**
  String get wanderShapeStar;

  /// No description provided for @wanderShapeCircle.
  ///
  /// In en, this message translates to:
  /// **'Circle'**
  String get wanderShapeCircle;

  /// No description provided for @scoreCongratsYouScore.
  ///
  /// In en, this message translates to:
  /// **'Congrats!  You score'**
  String get scoreCongratsYouScore;

  /// No description provided for @scorePointsWord.
  ///
  /// In en, this message translates to:
  /// **'points'**
  String get scorePointsWord;

  /// No description provided for @scoreInSeconds.
  ///
  /// In en, this message translates to:
  /// **'in {seconds} seconds'**
  String scoreInSeconds(String seconds);

  /// No description provided for @scoreHighScore.
  ///
  /// In en, this message translates to:
  /// **'High score: {score}'**
  String scoreHighScore(String score);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'th'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'th':
      return AppLocalizationsTh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}

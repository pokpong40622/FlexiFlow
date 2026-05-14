// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appTitle => 'FlexiFlow';

  @override
  String get navHome => 'หน้าหลัก';

  @override
  String get navMission => 'ภารกิจ';

  @override
  String get navStats => 'สถิติ';

  @override
  String get navTraining => 'ฝึกฝน';

  @override
  String navGoToTab(String label) {
    return 'ไปที่แท็บ $label';
  }

  @override
  String get goBack => 'ย้อนกลับ';

  @override
  String get profileTitle => 'โปรไฟล์';

  @override
  String get profileEditPersonalInfo => 'แก้ไขข้อมูลส่วนตัว';

  @override
  String get profileFeedback => 'ข้อเสนอแนะ';

  @override
  String get profileFeedbackComingSoon =>
      'ส่วนข้อเสนอแนะจะพร้อมใช้งานเร็ว ๆ นี้!';

  @override
  String get languageSetting => 'ภาษา';

  @override
  String get thaiLanguage => 'ไทย';

  @override
  String get englishLanguage => 'English';

  @override
  String get useWcag => 'ใช้โหมดการเข้าถึงตาม WCAG 2.2';

  @override
  String get useWcagSubtitle => 'คอนทราสต์สูงขึ้นและปุ่มกดใหญ่ขึ้น';

  @override
  String get textSize => 'ขนาดตัวอักษร';

  @override
  String get adjustTextScale => 'ปรับขนาดตัวอักษรตั้งแต่ 100% ถึง 250%';

  @override
  String get profileSignOut => 'ออกจากระบบ';

  @override
  String get confirmSignOutTitle => 'ออกจากระบบ';

  @override
  String get confirmSignOutMessage => 'คุณแน่ใจหรือไม่ว่าต้องการออกจากระบบ?';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get yes => 'ใช่';

  @override
  String get resetProgressTitle => 'รีเซ็ตความคืบหน้า';

  @override
  String get resetProgressMessage =>
      'คุณแน่ใจหรือไม่ว่าต้องการรีเซ็ตความคืบหน้าทั้งหมด? การกระทำนี้ไม่สามารถย้อนกลับได้';

  @override
  String get reset => 'รีเซ็ต';

  @override
  String get progressResetDone => 'รีเซ็ตความคืบหน้าทั้งหมดเรียบร้อยแล้ว';

  @override
  String get levelShort => 'เลเวล';

  @override
  String get loginWelcomeBack => 'ยินดีต้อนรับกลับ';

  @override
  String get loginSignInToContinue => 'เข้าสู่ระบบเพื่อดำเนินการต่อ';

  @override
  String get email => 'อีเมล';

  @override
  String get password => 'รหัสผ่าน';

  @override
  String get signIn => 'เข้าสู่ระบบ';

  @override
  String get dontHaveAccount => 'ยังไม่มีบัญชีใช่ไหม?';

  @override
  String get signUp => 'สมัครสมาชิก';

  @override
  String get loginMissingCredentials => 'กรุณากรอกอีเมลและรหัสผ่าน';

  @override
  String get loginIncorrectCredentials => 'อีเมลหรือรหัสผ่านไม่ถูกต้อง';

  @override
  String get unexpectedError => 'เกิดข้อผิดพลาดที่ไม่คาดคิด';

  @override
  String get createAccount => 'สร้างบัญชี';

  @override
  String get fullName => 'ชื่อ-นามสกุล';

  @override
  String get emergencyContact => 'ผู้ติดต่อฉุกเฉิน';

  @override
  String get birthday => 'วันเกิด';

  @override
  String get gender => 'เพศ';

  @override
  String get signupMissingFields => 'กรุณากรอกข้อมูลที่จำเป็นให้ครบถ้วน';

  @override
  String get alreadyHaveAccount => 'มีบัญชีอยู่แล้วใช่ไหม?';

  @override
  String get statsTitle => 'สถิติ';

  @override
  String get aiSuggestion => 'คำแนะนำจาก AI';

  @override
  String get aiKeepUpMomentum => 'ทำได้ดีมากครับ! ลองเล่น ';

  @override
  String get aiToBoostScore => ' เพื่อช่วยพัฒนาสมาธิให้ดียิ่งขึ้น';

  @override
  String get suggestionTryMoreScoreOn => 'ลองเพิ่มคะแนนอีกนิดใน ';

  @override
  String get suggestionFasterOn => 'อาจทำเวลาให้เร็วขึ้นอีกนิดใน ';

  @override
  String get gamePerfectMatch => 'Perfect Match';

  @override
  String get gameSumItUp => 'Sum It Up';

  @override
  String get gameWander => 'Wander';

  @override
  String get recent => 'ล่าสุด';

  @override
  String get nothingToShow => 'ยังไม่มี\nข้อมูล';

  @override
  String get brainScore => 'คะแนนสมอง';

  @override
  String get brainScoreDesc =>
      'การฝึกคำนวณและหน่วยความจำอย่างต่อเนื่องช่วยให้สมองแจ่มใส';

  @override
  String get pointsShort => 'แต้ม';

  @override
  String get steps => 'ก้าวเดิน';

  @override
  String get stepsShort => 'ก้าว';

  @override
  String get timeSpent => 'เวลาที่ใช้';

  @override
  String get today => 'วันนี้';

  @override
  String get week => 'สัปดาห์';

  @override
  String get month => 'เดือน';

  @override
  String get hour => 'ชม.';

  @override
  String get minuteShort => 'นาที';

  @override
  String get secondShort => 'วินาที';

  @override
  String get trainingToday => 'การฝึกฝนวันนี้';

  @override
  String get rounds => 'จำนวนรอบ';

  @override
  String get totalSessions => 'รวมการเล่นทั้งหมด';

  @override
  String get skillPerformance => 'ทักษะความสามารถ';

  @override
  String get excellentMemory => 'ความจำดีเยี่ยม';

  @override
  String get steadyCalculation => 'การคำนวณแม่นยำ';

  @override
  String ptsAchieved(String score) {
    return '$score คะแนนที่ทำได้';
  }

  @override
  String get recentActivity => 'Recent Activity';

  @override
  String get trainingTitle => 'ฝึกฝน';

  @override
  String get games => 'เกม';

  @override
  String get days => 'วัน';

  @override
  String get todoList => 'รายการที่ต้องทำ';

  @override
  String get add => 'เพิ่ม';

  @override
  String get noTasksForToday => 'ไม่มีงานสำหรับวันนี้';

  @override
  String get tapAddToCreateSchedule => 'แตะ \"เพิ่ม\" เพื่อสร้างตารางงาน';

  @override
  String eventDeleted(String event) {
    return 'ลบกิจกรรม \"$event\" แล้ว';
  }

  @override
  String get addEvent => 'เพิ่มกิจกรรม';

  @override
  String get timeHhMm => 'เวลา (HH:MM)';

  @override
  String get eventDescription => 'รายละเอียดกิจกรรม';

  @override
  String get locked => 'ล็อก';

  @override
  String get unlockInShop => 'ปลดล็อกในร้านค้า';

  @override
  String get homeOpenProfile => 'เปิดโปรไฟล์';

  @override
  String homeOpenService(String label) {
    return 'เปิด $label';
  }

  @override
  String get homeServicesTitle => 'บริการ';

  @override
  String get homeServiceDiscoverPosture => 'สำรวจท่าทาง';

  @override
  String get homeServiceLeaderboard => 'อันดับคะแนน';

  @override
  String get homeServiceChatbot => 'แชตบอต';

  @override
  String get homeServiceShop => 'ร้านค้า';

  @override
  String get homeOthersTitle => 'อื่น ๆ';

  @override
  String get homeFeedbackSummary => 'สรุปผลตอบรับ';

  @override
  String get homeStreak => 'สตรีค';

  @override
  String get homeTimeSpentPastTenDays => 'เวลาที่ใช้ใน 10 วันที่ผ่านมา';

  @override
  String homeStreakDaysCount(String count) {
    return '$count วัน';
  }

  @override
  String get missionHeaderYour => 'ภารกิจ';

  @override
  String get missionHeaderMissions => 'ของคุณ';

  @override
  String get missionTabDaily => 'รายวัน';

  @override
  String get missionTabWeekly => 'รายสัปดาห์';

  @override
  String get missionTabAll => 'ทั้งหมด';

  @override
  String get missionTitleFirstExerciseOfDay => 'ออกกำลังกายครั้งแรกของวัน';

  @override
  String get missionTitleComplete3Exercises => 'ออกกำลังกายให้ครบ 3 ครั้ง';

  @override
  String get missionTitleWalk5000Steps => 'เดินให้ครบ 5,000 ก้าว';

  @override
  String get missionTitlePlayPerfectMatch10Min => 'เล่น Perfect Match 10 นาที';

  @override
  String get missionTitleComplete10Exercises => 'ออกกำลังกายให้ครบ 10 ครั้ง';

  @override
  String get missionTitleReach200BrainScore => 'ทำคะแนนสมองให้ถึง 200';

  @override
  String get missionTitleExercise5DaysRow => 'ออกกำลังกายต่อเนื่อง 5 วัน';

  @override
  String get missionTitleExercise20DaysRow => 'ออกกำลังกายต่อเนื่อง 20 วัน';

  @override
  String get missionTitleReachLevel25 => 'ถึงเลเวล 25';

  @override
  String get missionTitleComplete20Exercises => 'ออกกำลังกายให้ครบ 20 ครั้ง';

  @override
  String get missionStatusDone => 'สำเร็จ';

  @override
  String get missionStatusClaim => 'รับ';

  @override
  String get shopTitle => 'ร้านค้า';

  @override
  String get shopCardDefaultTitle => 'ทั่วไป';

  @override
  String get shopCardDefaultDescription => 'ไอเทมที่คัดมาเพื่อคุณ';

  @override
  String get shopCardUniversalTitle => 'บัตรทอง';

  @override
  String get shopCardUniversalDescription => 'สำรวจสิทธิพิเศษจากภาครัฐเป็นหลัก';

  @override
  String get shopCardAiaTitle => 'AIA Vitality';

  @override
  String get shopCardAiaDescription => 'ดีลพิเศษสำหรับสมาชิก AIA Vitality';

  @override
  String get shopCardThaiIdTitle => 'บัตรประชาชนไทย';

  @override
  String get shopCardThaiIdVerified => 'เชื่อมต่อสำเร็จ';

  @override
  String get shopCardThaiIdUnverified => 'แตะเพื่อยืนยันบัตรประชาชนไทย';

  @override
  String get shopRequest => 'ขอเพิ่ม';

  @override
  String get shopMoreItemsComingSoon => 'ไอเทมเพิ่มเติมเร็ว ๆ นี้';

  @override
  String get shopRequestItemTitle => 'ขอเพิ่มสินค้า';

  @override
  String get shopRequestItemPrompt => 'คุณอยากเห็นสินค้าอะไรในร้านค้า?';

  @override
  String get shopRequestItemHint => 'กรอกชื่อสินค้า...';

  @override
  String get submit => 'ส่ง';

  @override
  String get shopThankYouTitle => 'ขอบคุณ!';

  @override
  String get shopThankYouMessage => 'เราได้รับคำขอของคุณแล้ว';

  @override
  String get closeLabel => 'ปิด';

  @override
  String get buyLabel => 'ซื้อ';

  @override
  String get shopConfirmPurchaseTitle => 'ยืนยันการซื้อ';

  @override
  String shopConfirmPurchaseMessage(String itemName, String itemPrice) {
    return 'คุณแน่ใจหรือไม่ว่าต้องการซื้อ $itemName ราคา $itemPrice เหรียญ?';
  }

  @override
  String shopPurchaseSuccess(String itemName) {
    return 'คุณซื้อ $itemName สำเร็จแล้ว!';
  }

  @override
  String get shopItemUnlockWander => 'ปลดล็อก Wander';

  @override
  String get shopItemUnlockSawasdeeLandscape => 'ปลดล็อกภาพสวัสดีวันแบบแนวนอน';

  @override
  String get shopItemSushiroCoupon60 => 'คูปอง Sushiro 60 บาท';

  @override
  String get shopItemMkRestaurant150 => 'MK Restaurant 150 บาท';

  @override
  String get shopItemMomo20Off => 'Momo Paradise ลด 20%';

  @override
  String get shopItemFreeMajorTicket => 'ตั๋วหนัง Major ฟรี';

  @override
  String get shopItemFreeSfPopcorn => 'ป๊อปคอร์นขนาดกลางที่ SF ฟรี';

  @override
  String get shopItemPttFuel300 => 'บัตรน้ำมัน PTT 300 บาท';

  @override
  String get shopItemBcpFuel300 => 'บัตรน้ำมัน BCP 300 บาท';

  @override
  String get shopItemMeaPea150 => 'ส่วนลดค่าไฟ MEA/PEA 150 บาท';

  @override
  String get shopItemMwaPwa150 => 'ส่วนลดค่าน้ำ MWA/PWA 150 บาท';

  @override
  String get shopItemNt250 => 'ส่วนลด NT 250 บาท';

  @override
  String get shopItemMrt200 => 'เติมเงิน MRT 200 บาท';

  @override
  String get shopItemThailandPost100 => 'ยอดคงเหลือไปรษณีย์ไทย 100 บาท';

  @override
  String get shopItemGovLottery => 'สลากกินแบ่งรัฐบาล';

  @override
  String get chatbotNoResponse => 'ไม่มีคำตอบ';

  @override
  String chatbotConnectionError(String error) {
    return 'ขออภัย ไม่สามารถเชื่อมต่อผู้ช่วยได้ในขณะนี้ โปรดลองอีกครั้งภายหลัง\nข้อผิดพลาด: $error';
  }

  @override
  String get chatbotMoreOptions => 'ตัวเลือกเพิ่มเติม';

  @override
  String get chatbotTitleLexiAssistant => 'ผู้ช่วย Lexi';

  @override
  String get chatbotSubtitleAlwaysHere => 'พร้อมช่วยเหลือเสมอ';

  @override
  String get chatbotHowCanWeHelp => 'มีอะไรให้เราช่วยไหม?';

  @override
  String get chatbotAttachFile => 'แนบไฟล์';

  @override
  String get chatbotInputHint => 'พิมพ์คำถาม...';

  @override
  String get chatbotSendMessage => 'ส่งข้อความ';

  @override
  String get chatbotJustNow => 'เมื่อสักครู่';

  @override
  String chatbotMinutesAgo(String minutes) {
    return '$minutes นาทีที่แล้ว';
  }

  @override
  String chatbotHoursAgo(String hours) {
    return '$hours ชั่วโมงที่แล้ว';
  }

  @override
  String get chatbotClearChatHistory => 'ล้างประวัติแชต';

  @override
  String get chatbotHelpSupport => 'ช่วยเหลือและสนับสนุน';

  @override
  String get chatbotClearHistoryConfirm =>
      'คุณแน่ใจหรือไม่ว่าต้องการล้างข้อความแชตทั้งหมด? การกระทำนี้ไม่สามารถย้อนกลับได้';

  @override
  String get chatbotClear => 'ล้าง';

  @override
  String get chatbotHelpTipsTitle => 'ช่วยเหลือและเคล็ดลับ';

  @override
  String get chatbotHelpTipsHeader => 'วิธีใช้งานให้ได้ผลดีที่สุด:';

  @override
  String get chatbotHelpTipSpecificQuestions =>
      'ถามคำถามเฉพาะเกี่ยวกับท่าออกกำลังกาย FlexiFlow';

  @override
  String get chatbotHelpTipPersonalizedRoutine =>
      'ขอแผนการออกกำลังกายที่เหมาะกับคุณ';

  @override
  String get chatbotHelpTipFormTechnique =>
      'รับคำแนะนำเรื่องท่าทางและเทคนิคที่ถูกต้อง';

  @override
  String get chatbotHelpTipSchedules => 'สอบถามตารางและช่วงเวลาออกกำลังกาย';

  @override
  String get chatbotHelpTipSuggestionChips => 'ใช้คำถามแนะนำเพื่อถามแบบรวดเร็ว';

  @override
  String get chatbotGotIt => 'เข้าใจแล้ว!';

  @override
  String get chatbotSuggestion1 => 'FlexiFlow คืออะไร?';

  @override
  String get chatbotSuggestion2 => 'ควรใช้เวลาฝึกเท่าไร?';

  @override
  String get chatbotSuggestion3 => 'ทำอย่างไรให้ยืดหยุ่นมากขึ้น?';

  @override
  String get chatbotSuggestion4 => 'FlexiFlow มีประโยชน์อะไรบ้าง?';

  @override
  String get chatbotSuggestion5 => 'ช่วยแนะนำโปรแกรมฝึกให้หน่อยได้ไหม?';

  @override
  String get chatbotSuggestion6 => 'ติดตามความคืบหน้ายังไง?';

  @override
  String get chatbotSuggestion7 => 'ถ้ารู้สึกเจ็บควรทำอย่างไร?';

  @override
  String get chatbotSuggestion8 => 'ควรฝึกบ่อยแค่ไหน?';

  @override
  String get chatbotSuggestion9 => 'ต้องใช้อุปกรณ์อะไรบ้าง?';

  @override
  String get chatbotSuggestion10 => 'ช่วยแนะนำท่าเฉพาะให้หน่อยได้ไหม?';

  @override
  String get chatbotSuggestion11 => 'ข้อผิดพลาดที่พบบ่อยใน FlexiFlow คืออะไร?';

  @override
  String get chatbotSuggestion12 => 'ทำอย่างไรให้มีแรงจูงใจต่อเนื่อง?';

  @override
  String get chatbotSuggestion13 => 'ช่วงเวลาไหนเหมาะที่สุดในการฝึก?';

  @override
  String get chatbotSuggestion14 =>
      'จะใส่ FlexiFlow ในกิจวัตรประจำวันได้อย่างไร?';

  @override
  String get leaderboardWeeklyRankings => 'อันดับประจำสัปดาห์';

  @override
  String get leaderboardYou => 'คุณ';

  @override
  String leaderboardRankText(String rank) {
    return 'อันดับ $rank';
  }

  @override
  String get leaderboardAvgScore => 'คะแนนเฉลี่ย';

  @override
  String get leaderboardGamesLabel => 'เกม';

  @override
  String get leaderboardStreakLabel => 'สตรีค';

  @override
  String get leaderboardWantMoreCompetition => 'อยากแข่งขันมากขึ้นไหม?';

  @override
  String get leaderboardInviteDescription =>
      'ชวนเพื่อนมาแข่งกันว่าใครจะครองอันดับสูงสุด!';

  @override
  String get leaderboardInviteFriends => 'ชวนเพื่อน';

  @override
  String get getStartedGestureTitle => 'L + บีบปลายนิ้ว';

  @override
  String get getStartedGestureDescription =>
      'ช่วยพัฒนาทักษะการเคลื่อนไหวและการประสานงานระหว่างมือกับตา';

  @override
  String get next => 'ถัดไป';

  @override
  String get gamePaused => 'หยุดชั่วคราว';

  @override
  String get gameScoreLabel => 'คะแนน';

  @override
  String get gamePointsAbbrev => 'แต้ม';

  @override
  String get mathGameSelectDifficulty => 'เลือกระดับความยาก';

  @override
  String get mathGameChooseLevelToStart => 'เลือกระดับเพื่อเริ่มเกม';

  @override
  String get mathGameLevelEasy => 'ง่าย (บวก)';

  @override
  String get mathGameLevelNormal => 'ปานกลาง (+, -)';

  @override
  String get mathGameLevelHard => 'ยาก (+, -, x, ÷)';

  @override
  String get mathGameLevelExtreme => 'โหด (คณิตขั้นสูง)';

  @override
  String get mathGameExtremeNote =>
      '* หมายเหตุ: ระดับนี้อาจต้องใช้กระดาษช่วยคำวณ!';

  @override
  String mathGamePercentOfEquation(String percent, String number) {
    return '$percent% ของ $number = ?';
  }

  @override
  String get perfectMatchNameLabel => 'ชื่อท่า';

  @override
  String perfectMatchComboMultiplier(String multiplier) {
    return 'คอมโบ x$multiplier';
  }

  @override
  String perfectMatchComboHits(String count) {
    return '$count ครั้ง!';
  }

  @override
  String perfectMatchPosePair(String left, String right) {
    return '$left + $right';
  }

  @override
  String get perfectMatchPosePartL => 'แอล';

  @override
  String get perfectMatchPosePartFingertipPinch => 'ปลายนิ้วจีบ';

  @override
  String get perfectMatchPosePartPoint => 'ชี้';

  @override
  String get perfectMatchPosePartThumb => 'นิ้วโป้ง';

  @override
  String get perfectMatchPosePartPinky => 'นิ้วก้อย';

  @override
  String get perfectMatchPosePartOne => 'หนึ่ง';

  @override
  String get perfectMatchPosePartTwo => 'สอง';

  @override
  String get perfectMatchPosePartThree => 'สาม';

  @override
  String get perfectMatchPosePartFour => 'สี่';

  @override
  String get perfectMatchPosePartFive => 'ห้า';

  @override
  String get perfectMatchPosePartSix => 'หก';

  @override
  String get perfectMatchPosePartSeven => 'เจ็ด';

  @override
  String get perfectMatchPosePartEight => 'แปด';

  @override
  String get perfectMatchPosePartNine => 'เก้า';

  @override
  String get perfectMatchPosePartTen => 'สิบ';

  @override
  String get wanderTitle => 'Wander Trace';

  @override
  String get wanderTraceRandomShapes => 'ลากตามรูปทรงสุ่ม';

  @override
  String get wanderDescription =>
      'ในแต่ละรอบจะมีรูปทรงสุ่ม: สามเหลี่ยม สี่เหลี่ยม ห้าเหลี่ยม\nดาว หรือวงกลม\nลากเส้นด้วยปลายนิ้วชี้จนกว่าขอบทุกด้านจะเต็ม';

  @override
  String get wanderStartTracing => 'เริ่มลากเส้น';

  @override
  String get wanderStatusShowFinger => 'ยกนิ้วชี้เพื่อเริ่มวางจุด';

  @override
  String wanderStatusProgress(String shape, String completed, String total) {
    return '$shape  $completed / $total';
  }

  @override
  String get wanderShapeTriangle => 'สามเหลี่ยม';

  @override
  String get wanderShapeQuadrilateral => 'สี่เหลี่ยม';

  @override
  String get wanderShapePentagon => 'ห้าเหลี่ยม';

  @override
  String get wanderShapeStar => 'ดาว';

  @override
  String get wanderShapeCircle => 'วงกลม';

  @override
  String get scoreCongratsYouScore => 'ยินดีด้วย! คุณทำได้';

  @override
  String get scorePointsWord => 'คะแนน';

  @override
  String scoreInSeconds(String seconds) {
    return 'ใน $seconds วินาที';
  }

  @override
  String scoreHighScore(String score) {
    return 'คะแนนสูงสุด: $score';
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:motion_kit/fake_var.dart';

import 'ScorePage.dart';

class MissionPage extends StatefulWidget {
  final VoidCallback? onNavigateToTraining;

  const MissionPage({
    super.key,
    this.onNavigateToTraining,
  });

  @override
  State<MissionPage> createState() => _MissionPageState();
}

class _MissionPageState extends State<MissionPage> {
  int selectedButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Column(
        children: [
          Container(
            width: screenWidth * 1,
            height: screenHeight * 0.195,
            color: const Color(0xFF0397FD),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: screenWidth * 0.066),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: screenHeight * 0.045),
                        Text(
                          l10n.your,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: screenWidth * 0.076,
                            color: Colors.white,
                            height: 1,
                          ),
                        ),
                        Text(
                          l10n.missions,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: screenWidth * 0.076,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: screenWidth * 0.108),
                    Image.asset(
                      'assets/goldmedal.png', // Ensure you have this asset
                      width: screenWidth * 0.30,
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.0225),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTab(context, l10n.daily, 0),
                    _buildTab(context, l10n.weekly, 1),
                    _buildTab(context, l10n.all, 2),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.016),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: _getMissions(context),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getMissions(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    List<MissionData> missions;

    final daily = [
      MissionData(
        id: 'mission_first_exercise',
        title: l10n.missionFirstExercise,
        coins: 50,
        xp: 100,
        status: MissionStatus.claimable,
      ),
      MissionData(
        id: 'mission_complete_3',
        title: l10n.missionComplete3,
        coins: 80,
        xp: 150,
        status: Globals.totalExercisesCompletedTD >= 3
            ? MissionStatus.claimable
            : MissionStatus.inProgress,
        currentProgress: Globals.totalExercisesCompletedTD,
        totalProgress: 3,
      ),
      MissionData(
        id: 'mission_walk_5000',
        title: l10n.missionWalk5000,
        coins: 80,
        xp: 150,

        status: Globals.totalStepsTD >= 5000
            ? MissionStatus.claimable
            : MissionStatus.inProgress,
        currentProgress: Globals.totalStepsTD,
        totalProgress: 5000,
      ),
      MissionData(
        id: 'mission_play_perfect_match_10',
        title: l10n.missionPlayPerfectMatch10,
        coins: 30,
        xp: 80,
        status: MissionStatus.locked,
        requiredLevel: 15,
      ),
    ];

    final weekly = [
      MissionData(
        id: 'mission_complete_10',
        title: l10n.missionComplete10,
        coins: 80,
        xp: 150,
        status: Globals.totalExercisesCompletedWK >= 10
            ? MissionStatus.claimable
            : MissionStatus.inProgress,
        currentProgress: Globals.totalExercisesCompletedWK,
        totalProgress: 10,
      ),
      MissionData(
        id: 'mission_reach_200_brain_score',
        title: l10n.missionReach200BrainScore,
        coins: 150,
        xp: 300,
        status: MissionStatus.locked,
        requiredLevel: 20,
      ),
      MissionData(
        id: 'mission_exercise_5_days',
        title: l10n.missionExercise5Days,
        coins: 200,
        xp: 250,
        status: MissionStatus.claimed,
      ),
    ];

    final all = [
      MissionData(
        id: 'mission_exercise_20_days',
        title: l10n.missionExercise20Days,
        coins: 500,
        xp: 500,
        status: MissionStatus.inProgress,
        currentProgress: Globals.streak,
        totalProgress: 20,
      ),
      MissionData(
        id: 'mission_reach_level_25',
        title: l10n.missionReachLevel25,
        coins: 900,
        xp: 100,
        status: MissionStatus.inProgress,
        currentProgress: Globals.level,
        totalProgress: 25,
      ),
      MissionData(
        id: 'mission_complete_20',
        title: l10n.missionComplete20,
        coins: 300,
        xp: 300,
        status: MissionStatus.claimed,
      ),
    ];

    if (selectedButtonIndex == 0) {
      missions = daily;
    } else if (selectedButtonIndex == 1) {
      missions = weekly;
    } else {
      missions = all;
    }

    // Update status if claimed
    for (var m in missions) {
      // TODO: Remove legacy title fallback once all persisted claimed mission titles are migrated to IDs.
      if (Globals.claimedMissions.contains(m.id) || Globals.claimedMissions.contains(m.title)) {
        m.status = MissionStatus.claimed;
      }
    }

    // Sort: Claimable (0) -> InProgress (1) -> Locked (2) -> Claimed (3)
    missions.sort((a, b) =>
        _statusPriority(a.status).compareTo(_statusPriority(b.status)));

    return missions
        .map((m) => _buildMissionItem(
              context,
              missionId: m.id,
              title: m.title,
              coins: m.coins,
              xp: m.xp,
              status: m.status,
              currentProgress: m.currentProgress,
              totalProgress: m.totalProgress,
              requiredLevel: m.requiredLevel,
            ))
        .toList();
  }

  int _statusPriority(MissionStatus status) {
    switch (status) {
      case MissionStatus.claimable:
        return 0;
      case MissionStatus.inProgress:
        return 1;
      case MissionStatus.locked:
        return 2;
      case MissionStatus.claimed:
        return 3;
    }
  }

  Widget _buildTab(BuildContext context, String title, int index) {
    double tabWidth = MediaQuery.of(context).size.width / 3;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedButtonIndex = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: tabWidth,
            height: 30,
            alignment: Alignment.topCenter,
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                fontSize: MediaQuery.of(context).size.width * 0.037,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            width: tabWidth,
            height: 5.6,
            color: selectedButtonIndex == index
                ? const Color(0xFFFFE07D)
                : Colors.transparent,
          ),
        ],
      ),
    );
  }

  Widget _buildMissionItem(
    BuildContext context, {
    required String missionId,
    required String title,
    required int coins,
    required int xp,
    required MissionStatus status,
    int currentProgress = 0,
    int totalProgress = 1,
    int requiredLevel = 0,
  }) {
    // Override status if already claimed locally
    // TODO: Remove legacy title fallback once all persisted claimed mission titles are migrated to IDs.
    if (Globals.claimedMissions.contains(missionId) || Globals.claimedMissions.contains(title)) {
      status = MissionStatus.claimed;
    }

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Derive colours & icons from status
    final Color accentColor;
    final IconData leadingIcon;
    final double cardOpacity;

    switch (status) {
      case MissionStatus.claimed:
        accentColor = const Color(0xFF62DA30);
        leadingIcon = Icons.check_circle;
        cardOpacity = 0.72;
        break;
      case MissionStatus.claimable:
        accentColor = const Color(0xFF0397FD);
        leadingIcon = Icons.emoji_events_rounded;
        cardOpacity = 1.0;
        break;
      case MissionStatus.inProgress:
        accentColor = const Color(0xFFFFA726);
        leadingIcon = Icons.play_circle_fill_rounded;
        cardOpacity = 1.0;
        break;
      case MissionStatus.locked:
        accentColor = const Color(0xFFBBBBBB);
        leadingIcon = Icons.lock_rounded;
        cardOpacity = 0.6;
        break;
    }

    return Opacity(
      opacity: cardOpacity,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.007,
        ),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          elevation: status == MissionStatus.claimable ? 4 : 1.5,
          shadowColor: accentColor.withValues(alpha: 0.30),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () {
              if (status == MissionStatus.claimable) {
                setState(() {
                  Globals.coins += coins;
                  Globals.exp += xp;
                  Globals.claimedMissions.add(missionId);
                  Globals.save();
                });
              } else if (status == MissionStatus.inProgress &&
                  widget.onNavigateToTraining != null) {
                widget.onNavigateToTraining!();
              }
            },
            splashColor: accentColor.withValues(alpha: 0.12),
            highlightColor: accentColor.withValues(alpha: 0.06),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: accentColor.withValues(alpha: 0.25),
                  width: 1.2,
                ),
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [

                    SizedBox(width: screenWidth * 0.035 + 5),

                    // ── Leading status icon ──
                    Container(
                      width: screenWidth * 0.105,
                      height: screenWidth * 0.105,
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        leadingIcon,
                        color: accentColor,
                        size: screenWidth * 0.055,
                      ),
                    ),

                    SizedBox(width: screenWidth * 0.035),

                    // ── Title + coin row + optional progress ──
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.018,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: screenWidth * 0.038,
                                color: status == MissionStatus.claimed
                                    ? Colors.grey[600]
                                    : Colors.black87,
                                decoration: status == MissionStatus.claimed
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/CoinsLogo.png',
                                  width: screenWidth * 0.045,
                                  height: screenWidth * 0.045,
                                ),
                                SizedBox(width: screenWidth * 0.012),
                                Text(
                                  '+$coins',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: screenWidth * 0.032,
                                    color: const Color(0xFFE5A100),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.02),
                                  child: Text(
                                    '•',
                                    style: TextStyle(
                                      color: Colors.grey[300],
                                      fontSize: screenWidth * 0.032,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  '+$xp XP',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: screenWidth * 0.032,
                                    color: const Color(0xFF0397FD),
                                  ),
                                ),
                                if (requiredLevel > 0) ...[
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.02),
                                    child: Text(
                                      '•',
                                      style: TextStyle(
                                        color: Colors.grey[300],
                                        fontSize: screenWidth * 0.032,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.lvlShort(requiredLevel),
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontSize: screenWidth * 0.032,
                                      color: const Color(0xFFFF5252),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            // Progress bar for in-progress missions
                            if (status == MissionStatus.inProgress) ...[
                              SizedBox(height: screenHeight * 0.008),
                              Row(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: LinearProgressIndicator(
                                        value: currentProgress / totalProgress,
                                        minHeight: 6,
                                        backgroundColor:
                                            accentColor.withValues(alpha: 0.15),
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                accentColor),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.02),
                                  Text(
                                    '$currentProgress / $totalProgress',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontSize: screenWidth * 0.028,
                                      color: accentColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),

                    // ── Trailing action / badge ──
                    Padding(
                      padding:
                          EdgeInsets.only(right: screenWidth * 0.04),
                      child: _buildTrailing(
                        status: status,
                        accentColor: accentColor,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Trailing widget that varies by mission status.
  Widget _buildTrailing({
    required MissionStatus status,
    required Color accentColor,
    required double screenWidth,
    required double screenHeight,
  }) {
    switch (status) {
      case MissionStatus.claimed:
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.025,
            vertical: screenHeight * 0.005,
          ),
          decoration: BoxDecoration(
            color: accentColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check, color: accentColor, size: screenWidth * 0.04),
              SizedBox(width: screenWidth * 0.01),
              Text(
                AppLocalizations.of(context)!.done,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: screenWidth * 0.03,
                  color: accentColor,
                ),
              ),
            ],
          ),
        );

      case MissionStatus.claimable:
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.008,
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF0397FD), Color(0xFF02B1FD)],
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0397FD).withValues(alpha: 0.35),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            AppLocalizations.of(context)!.claim,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: screenWidth * 0.033,
              color: Colors.white,
            ),
          ),
        );

      case MissionStatus.inProgress:
        if (widget.onNavigateToTraining == null) {
          return const SizedBox.shrink();
        }
        return Icon(
          Icons.arrow_forward_ios_rounded,
          color: accentColor,
          size: screenWidth * 0.045,
        );

      case MissionStatus.locked:
        return Icon(
          Icons.lock_outline_rounded,
          color: accentColor,
          size: screenWidth * 0.055,
        );
    }
  }
}

/// The four possible states a mission card can be in.
enum MissionStatus { claimed, claimable, inProgress, locked }

class MissionData {
  final String id;
  final String title;
  final int coins;
  final int xp;
  MissionStatus status;
  final int currentProgress;
  final int totalProgress;
  final int requiredLevel;

  MissionData({
    required this.id,
    required this.title,
    required this.coins,
    required this.xp,
    required this.status,
    this.currentProgress = 0,
    this.totalProgress = 1,
    this.requiredLevel = 0,
  });
}

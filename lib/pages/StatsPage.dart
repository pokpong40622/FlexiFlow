import 'package:flutter/material.dart';
import 'package:motion_kit/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import '../fake_var.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  String _selectedTimeFilter = 'today';
  late Timer _timer;
  DateTime _currentDateTime = DateTime.now();

  // Theme Colors
  final Color primaryBlue = const Color(0xFF0397FD);
  final Color green = const Color(0xFF62B01E);
  final Color pink = const Color(0xFFE91E63);
  final Color bg = const Color(0xFFFAFAFA);

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() => _currentDateTime = DateTime.now());
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  int get _getTimeSpent {
    switch (_selectedTimeFilter) {
      case 'week': return Globals.timeSpentWK;
      case 'month': return Globals.timeSpentMH;
      default: return Globals.timeSpentTD;
    }
  }

  String _formatDuration(int totalSeconds) {
    int h = totalSeconds ~/ 3600;
    int m = (totalSeconds ~/ 60) % 60;
    int s = totalSeconds % 60;
    if (h > 0) return '${h}h ${m}m';
    return '${m}m ${s}s';
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final l10n = AppLocalizations.of(context)!;
    final localeTag = Localizations.localeOf(context).toLanguageTag();

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.046),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(screenWidth, screenHeight, l10n, localeTag),
                SizedBox(height: screenHeight * 0.022),

                _buildAISuggestion(screenWidth, screenHeight, l10n),
                SizedBox(height: screenHeight * 0.022),

                _buildFilterRow(screenWidth, l10n),
                SizedBox(height: screenHeight * 0.018),

                _buildBrainScoreHero(screenWidth, screenHeight, l10n),
                SizedBox(height: screenHeight * 0.02),

                _buildSummaryGrid(screenWidth, screenHeight, l10n),
                SizedBox(height: screenHeight * 0.02),

                _buildGameBreakdown(screenWidth, screenHeight, l10n),
                SizedBox(height: screenHeight * 0.02),

                _buildProgressHistory(screenWidth, screenHeight, l10n),
                SizedBox(height: screenHeight * 0.025),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double sw, double sh, AppLocalizations l10n, String locale) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: sw * 0.06, vertical: sh * 0.012),
          decoration: BoxDecoration(
            color: primaryBlue,
            borderRadius: BorderRadius.circular(sw * 0.03),
          ),
          child: Text(
            l10n.statsTitle,
            style: GoogleFonts.inter(color: Colors.white, fontSize: sw * 0.05, fontWeight: FontWeight.w700),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(DateFormat('EEEE, d MMMM', locale).format(_currentDateTime),
                style: GoogleFonts.inter(fontSize: sw * 0.035, fontWeight: FontWeight.w600)),
            Text(DateFormat('yyyy  HH:mm', locale).format(_currentDateTime),
                style: GoogleFonts.inter(fontSize: sw * 0.035, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }

  Widget _buildAISuggestion(double sw, double sh, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.aiSuggestion, style: GoogleFonts.inter(fontSize: sw * 0.045, fontWeight: FontWeight.w700)),
        SizedBox(height: sh * 0.01),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(sw * 0.04),
          decoration: _cardDecoration(sw),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: primaryBlue, 
                radius: sw * 0.04, 
                child: const Icon(Icons.auto_awesome, color: Colors.white, size: 16) // ปรับเป็น Icon แทนถ้าโหลด Assets ไม่ได้
              ),
              SizedBox(width: sw * 0.03),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.inter(fontSize: sw * 0.035, color: Colors.black, height: 1.3),
                    children: [
                      TextSpan(text: l10n.aiKeepUpMomentum),
                      TextSpan(text: l10n.gamePerfectMatch, style: TextStyle(color: pink, fontWeight: FontWeight.bold)),
                      TextSpan(text: l10n.aiToBoostScore),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBrainScoreHero(double sw, double sh, AppLocalizations l10n) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(sw * 0.05),
      decoration: BoxDecoration(
        color: primaryBlue,
        borderRadius: BorderRadius.circular(sw * 0.05),
        boxShadow: [BoxShadow(color: primaryBlue.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 6))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.brainScore, style: GoogleFonts.inter(color: Colors.white.withOpacity(0.9), fontSize: sw * 0.04, fontWeight: FontWeight.w600)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${Globals.brainScore}', style: GoogleFonts.inter(color: Colors.white, fontSize: sw * 0.12, fontWeight: FontWeight.w900)),
              Padding(
                padding: const EdgeInsets.only(bottom: 8, left: 4), 
                child: Text(l10n.pointsShort, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold))
              ),
              const Spacer(),
              _buildGrowthBadge(sw, "12%"), 
            ],
          ),
          SizedBox(height: sh * 0.01),
          Text(l10n.brainScoreDesc, style: TextStyle(color: Colors.white, fontSize: sw * 0.032)),
        ],
      ),
    );
  }

  Widget _buildSummaryGrid(double sw, double sh, AppLocalizations l10n) {
    return Row(
      children: [
        Expanded(child: _buildSmallMetricCard(sw, sh, l10n.timeSpent, _formatDuration(_getTimeSpent), l10n.trainingToday)),
        SizedBox(width: sw * 0.035),
        Expanded(child: _buildSmallMetricCard(sw, sh, l10n.rounds, "${Globals.exercisesList.length}", l10n.totalSessions)),
      ],
    );
  }

  Widget _buildGameBreakdown(double sw, double sh, AppLocalizations l10n) {
    return Container(
      padding: EdgeInsets.all(sw * 0.045),
      decoration: _cardDecoration(sw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.skillPerformance, style: GoogleFonts.inter(fontSize: sw * 0.045, fontWeight: FontWeight.w800)),
          SizedBox(height: sh * 0.015),
          _buildSkillRow(sw, sh, l10n.gamePerfectMatch, 0.85, l10n.excellentMemory),
          _buildSkillRow(sw, sh, l10n.gameSumItUp, 0.60, l10n.steadyCalculation),
        ],
      ),
    );
  }

  Widget _buildProgressHistory(double sw, double sh, AppLocalizations l10n) {
    return Container(
      padding: EdgeInsets.all(sw * 0.045),
      decoration: _cardDecoration(sw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.recentActivity, style: GoogleFonts.inter(fontSize: sw * 0.045, fontWeight: FontWeight.w800)),
          SizedBox(height: sh * 0.015),
          ...Globals.exercisesList.reversed.take(3).map((ex) => 
            _buildHistoryItem(
              sw, 
              sh, 
              l10n.recent, 
              _exerciseLabel(ex.type, l10n), 
              l10n.ptsAchieved(ex.score.toString()) // สมมติว่าใน arb รับ parameter
            )
          ).toList(),
        ],
      ),
    );
  }

  // --- Sub-Widgets & Utils ---

  Widget _buildGrowthBadge(double sw, String val) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sw * 0.02, vertical: sw * 0.01),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(sw * 0.02)),
      child: Row(children: [
        Icon(Icons.arrow_upward, color: green, size: sw * 0.03),
        Text(val, style: TextStyle(color: green, fontWeight: FontWeight.bold, fontSize: sw * 0.03))
      ]),
    );
  }

  Widget _buildSkillRow(double sw, double sh, String title, double val, String desc) {
    return Padding(
      padding: EdgeInsets.only(bottom: sh * 0.015),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: sw * 0.035)),
            Text("${(val * 100).toInt()}%", style: TextStyle(color: primaryBlue, fontWeight: FontWeight.bold)),
          ]),
          const SizedBox(height: 4),
          LinearProgressIndicator(value: val, backgroundColor: Colors.grey[200], color: primaryBlue, minHeight: 6),
          Text(desc, style: TextStyle(color: Colors.grey, fontSize: sw * 0.028)),
        ],
      ),
    );
  }

  Widget _buildSmallMetricCard(double sw, double sh, String title, String val, String sub) {
    return Container(
      padding: EdgeInsets.all(sw * 0.04),
      decoration: _cardDecoration(sw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: sw * 0.03, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 8),
          Text(val, style: TextStyle(fontSize: sw * 0.045, fontWeight: FontWeight.w900, color: primaryBlue)),
          Text(sub, style: TextStyle(fontSize: sw * 0.025, color: Colors.grey[400])),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(double sw, double sh, String time, String title, String detail) {
    return Padding(
      padding: EdgeInsets.only(bottom: sh * 0.015),
      child: Row(children: [
        CircleAvatar(radius: 4, backgroundColor: primaryBlue),
        const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: sw * 0.035)),
          Text(detail, style: TextStyle(color: Colors.grey, fontSize: sw * 0.03)),
        ])
      ]),
    );
  }

  Widget _buildFilterRow(double sw, AppLocalizations l10n) {
    return Row(children: [
      _buildFilterBtn('today', l10n.today, sw),
      const SizedBox(width: 8),
      _buildFilterBtn('week', l10n.week, sw),
      const SizedBox(width: 8),
      _buildFilterBtn('month', l10n.month, sw),
    ]);
  }

  Widget _buildFilterBtn(String key, String label, double sw) {
    bool selected = _selectedTimeFilter == key;
    return GestureDetector(
      onTap: () => setState(() => _selectedTimeFilter = key),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: sw * 0.04, vertical: sw * 0.02),
        decoration: BoxDecoration(color: selected ? primaryBlue : Colors.grey[200], borderRadius: BorderRadius.circular(20)),
        child: Text(label, style: TextStyle(color: selected ? Colors.white : Colors.black54, fontWeight: FontWeight.bold, fontSize: sw * 0.03)),
      ),
    );
  }

  BoxDecoration _cardDecoration(double sw) => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(sw * 0.04),
    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
  );

  String _exerciseLabel(ExerciseType type, AppLocalizations l10n) {
    switch (type) {
      case ExerciseType.PerfectMatch: return l10n.gamePerfectMatch;
      case ExerciseType.SumItUp: return l10n.gameSumItUp;
      case ExerciseType.Wander: return l10n.gameWander;
    }
  }
}
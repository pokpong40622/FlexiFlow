import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  // Define colors based on the design
  final Color primaryColor = const Color(0xFF0397FD);
  final Color backgroundLight = const Color(0xFFFAFAFA);
  final Color accentColor = const Color(0xFF0288D1); // Slightly darker blue for contrast or similar
  final Color surfaceColor = const Color(0xFFFFFFFF);
  final Color textMainColor = const Color(0xFF2D3436);
  final Color mutedColor = const Color(0xFFB2BEC3);

  // Track expanded item index (-1 means none expanded)
  int _expandedIndex = 2; // Default to rank 3 expanded as per design

  // Mock Data
  final List<Map<String, dynamic>> leaderboardData = [
    {
      'rank': 1,
      'name': 'You',
      'rankText': 'Rank 1',
      'points': 1500,
      'imageUrl': 'assets/FlexiFlowProfilePic.png',
      // or network image if preferred
      'isCurrentUser': true,
      'winRate': '68%',
      'games': 156,
      'streak': 5,
    },
    {
      'rank': 2,
      'name': 'Alex',
      'rankText': 'Rank 2',
      'points': 1200,
      'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuB36kLy8O7-bLl2PpLF1C20whfaDmwvhalq4EU3t7FV4LRwFULwpVFuAigICl3qX19khE0ZgPtNv6SxYXfamAiWMVXtU0g5UPLyjOjoFYqnDd5xjDikleUrL-6mg5LYqH3FiNTo2-j0aVU-Tg9LT8Ztetav7zPqA8U9uEv7KJXZY4OGos1kQtzNRdi0alEAJ0lBYcPpyoHvR-xU4fv6_lQ8_mdl0PFU9LNS-SPI2sEPaOPVJK7YgtrvIsEI9m5oDAFwg0upeA-B-5ID',
      'isCurrentUser': false,
      'winRate': '55%',
      'games': 98,
      'streak': 2,
    },
    {
      'rank': 3,
      'name': 'Sam',
      'rankText': 'Rank 3',
      'points': 900,
      'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuB2SgEdfp2Acv76QdJCa_vKoGlVcPr315PqBHW7tF6z6gkpR-bcyLbWSjCuTiAGqKrc72fnIV6UVwFCLYg-lS6Txr10Em2RqfR_bwh-FL1sLYr3HWXHuwMllh-VXSQu4fV6JgLpPSTi9li0lTUk2SDuVhVXBpErlwxlc2IcL7Ea3aN1v3kpY_Pk9RZeecPYFOao7Zd1KnophPC-zQylphvSMktZbPjSbCPx4pJOgZf67O9zvIt-lYchLggQx0HR-GRMmK3V2YF9GKF4',
      'isCurrentUser': false,
      'winRate': '64%',
      'games': 142,
      'streak': 3,
    },
    {
      'rank': 4,
      'name': 'Jordan',
      'rankText': 'Rank 4',
      'points': 750,
      'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCLnm4lMeOTFjyS0P6uMvx9YhbVJ2XX9WhG5sfb75bHd5j7ATGVZqpIn-OIBBxp_2rQGdHchq7VSfQ50iUNHpg87zYYROpo7EA0tJg-A3btcgom4eOY9fByXhNSTC8ovZgwMdtFFXS6u9jgJoDJU9Wuv86_krLQ273yClXy-fPmgZ3J7dfOg0KarNd0UU7Fs_w2XZYmGby3zMW_4fYvVrZbior3Mx2ms3EdALQkNY0jTk0voBXWMng6BOFDNAHU1WDEQFs7WNEu8mbq',
      'isCurrentUser': false,
      'winRate': '45%',
      'games': 67,
      'streak': 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildAppBar(context),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  children: [
                    // Render List
                    ...leaderboardData.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> data = entry.value;
                      bool isExpanded = _expandedIndex == index;

                      if (data['isCurrentUser'] == true) {
                        return _buildCurrentUserCard(data);
                      } else {
                        return _buildStandardPlayerCard(
                            data, index, isExpanded);
                      }
                    }).toList(),

                    const SizedBox(height: 32),
                    _buildInviteCard(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: surfaceColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    offset: const Offset(4, 4),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back,
                color: textMainColor,
                size: 24,
              ),
            ),
          ),
          // Title
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 48.0), // Balance the back button space
              child: Text(
                'Rankings',
                textAlign: TextAlign.center,
                style: GoogleFonts.splineSans(
                  fontSize: 28, // ~text-3xl
                  fontWeight: FontWeight.bold, // font-bold
                  color: textMainColor,
                  height: 1.1,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentUserCard(Map<String, dynamic> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 80,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(999), // rounded-full
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.3),
            offset: const Offset(0, 8),
            blurRadius: 16,
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Badge Icon
          Positioned(
            top: -12,
            left: -8,
            child: Transform.rotate(
              angle: -15 * 3.14159 / 180, // -15 deg
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: surfaceColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      offset: const Offset(2, 4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.emoji_events, // social_leaderboard replacement
                  color: primaryColor,
                  size: 20,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                // Rank Number
                SizedBox(
                  width: 32,
                  child: Center(
                    child: Text(
                      '${data['rank']}',
                      style: GoogleFonts.splineSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Avatar
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: surfaceColor, width: 2),
                    image: DecorationImage(
                      image: data['imageUrl'].startsWith('assets')
                        ? AssetImage(data['imageUrl']) as ImageProvider
                        : NetworkImage(data['imageUrl']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Text Info
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['name'],
                        style: GoogleFonts.splineSans(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data['rankText'],
                        style: GoogleFonts.splineSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withValues(alpha: 0.8),
                          height: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
                // Points
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: '${NumberFormat('#,###').format(data['points'])} ',
                        style: GoogleFonts.splineSans(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: 'pts',
                            style: GoogleFonts.splineSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStandardPlayerCard(
    Map<String, dynamic> data, int index, bool isExpanded) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // Toggle expansion
          if (_expandedIndex == index) {
            _expandedIndex = -1;
          } else {
            _expandedIndex = index;
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(24), // Modern rounded corners
          border: isExpanded
              ? Border.all(color: primaryColor.withValues(alpha: 0.2), width: 1.5)
              : Border.all(color: Colors.transparent, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              offset: const Offset(0, 4),
              blurRadius: 12,
            ),
          ],
        ),
        child: Column(
          children: [
            // Header Row
            Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isExpanded ? primaryColor.withValues(alpha: 0.05) : Colors.transparent,
                borderRadius: isExpanded 
                    ? const BorderRadius.vertical(top: Radius.circular(24)) 
                    : BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  // Rank Number
                  SizedBox(
                    width: 32,
                    child: Center(
                      child: Text(
                        '${data['rank']}',
                        style: GoogleFonts.splineSans(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: mutedColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Avatar
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: backgroundLight, width: 2),
                      image: DecorationImage(
                        image: data['imageUrl'].startsWith('assets')
                          ? AssetImage(data['imageUrl']) as ImageProvider
                          : NetworkImage(data['imageUrl']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Text Info
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['name'],
                          style: GoogleFonts.splineSans(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textMainColor,
                            height: 1.0,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          data['rankText'],
                          style: GoogleFonts.splineSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: mutedColor,
                            height: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Points & Icon
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: '${NumberFormat('#,###').format(data['points'])} ',
                          style: GoogleFonts.splineSans(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textMainColor,
                          ),
                          children: [
                            TextSpan(
                              text: 'pts',
                              style: GoogleFonts.splineSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: mutedColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: isExpanded ? primaryColor : mutedColor,
                        size: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Expanded Content
            if (isExpanded)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: surfaceColor, // Kept surface color
                  border: Border(
                    top: BorderSide(color: backgroundLight),
                  ),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(24),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatItem('WIN RATE', data['winRate']),
                    _buildStatItem('GAMES', '${data['games']}'),
                    _buildStatItem('STREAK', '${data['streak']}', isFire: true),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, {bool isFire = false}) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.splineSans(
            fontSize: 10, // ~text-xs
            fontWeight: FontWeight.w600,
            color: mutedColor,
            letterSpacing: 1.2, // ~tracking-wider
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              value,
              style: GoogleFonts.splineSans(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isFire ? Colors.orange : textMainColor, // Fire color updated
              ),
            ),
            if (isFire) ...[
              const SizedBox(width: 4),
              Icon(
                Icons.local_fire_department,
                color: Colors.orange, // Fire color updated
                size: 16,
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildInviteCard() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 8),
            blurRadius: 20,
          ),
        ],
        border: Border.fromBorderSide(
          BorderSide(
            color: mutedColor.withValues(alpha: 0.2),
            width: 1.5,
            style: BorderStyle.none, // Can't replicate 'dashed' easily on Container border, using custom paint is better, but simple Border is okay or DottedBorder package
          ),
        ),
      ),
      // To create dashed border effect properly without package, we can use a CustomPainter, but simpler is acceptable.
      // I'll simulate dotted border visually or just use a solid light border for now.
      child: Column(
        children: [
          // Icon Container
          Container(
            width: 96,
            height: 96,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            // Inner shadow is tricky in Flutter without custom painting or multiple containers.
            // Simplified approach: just a flat container or standard shadow.
            child: Icon(
              Icons.group_add,
              size: 48,
              color: primaryColor,
            ),
          ),
          Text(
            'Want more competition?',
            textAlign: TextAlign.center,
            style: GoogleFonts.splineSans(
              fontSize: 20, // ~text-xl
              fontWeight: FontWeight.bold,
              color: textMainColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Invite your friends to see who really rules the leaderboard!',
            textAlign: TextAlign.center,
            style: GoogleFonts.splineSans(
              fontSize: 14, // ~text-sm
              fontWeight: FontWeight.w500,
              color: mutedColor,
            ),
          ),
          const SizedBox(height: 24),
          // Button
          ElevatedButton(
            onPressed: () {
              // Add invite action logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              elevation: 4,
              shadowColor: primaryColor.withValues(alpha: 0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              minimumSize: const Size(double.infinity, 56), // Full width
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.send, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Invite Friends',
                  style: GoogleFonts.splineSans(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Simple internal helper for number formatting
class NumberFormat {
  final String pattern;
  NumberFormat(this.pattern);
  
  String format(int number) {
    if (pattern == '#,###') {
       return number.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},');
    }
    return number.toString();
  }
}


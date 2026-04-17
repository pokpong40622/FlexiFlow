import 'package:motion_kit/memberships/AuthPage.dart';
//import 'package:motion_kit/memberships/widget_tree.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_kit/memberships/widget_tree.dart';
import 'package:motion_kit/pages/ThaiIdInputPage.dart';
import 'package:motion_kit/theme/app_tokens.dart';
import 'package:motion_kit/theme/wcag_utils.dart';
import 'package:motion_kit/l10n/app_localizations.dart';
import 'package:motion_kit/l10n/app_language.dart';

import '../fake_var.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final tokens = tokensOf(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          SizedBox(height: screenHeight * 0.0265), // Top padding
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0425),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Custom Back Button
                Semantics(
                  button: true,
                  label: l10n.goBack,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      size: screenWidth * 0.065,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
                Text(
                  l10n.profileTitle,
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: screenWidth * 0.054,
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.06,
                ), // Placeholder for alignment
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ), // Space between header and profile pic
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: screenWidth * 0.12,
                backgroundImage: const AssetImage(
                  'assets/FlexiFlowProfilePic.png',
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey[300]!, width: 1),
                  ),
                  child: Icon(
                    Icons.edit, // Edit icon for profile picture
                    size: screenWidth * 0.04,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.015),
          Text(
            'Pummiphach Paisanwatcharakij',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: screenHeight * 0.005),
          Text(
            'pummiphach@gmail.com',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: screenWidth * 0.035,
              fontWeight: FontWeight.w600, // Changed to semibold
              color: wcagColor(
                context,
                standard: Colors.grey[600]!,
                wcag: tokens.textMuted,
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Container(
                  width: (screenWidth - (screenWidth * 0.16)) * (Globals.leftoverExp / Globals.requiredExp),
                  height: 12,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0397FD), // Specific blue color
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.005),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${l10n.levelShort} ${Globals.level}',
                  style: GoogleFonts.inter(
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.w600, // Changed to semibold
                    color: wcagColor(
                      context,
                      standard: Colors.grey[600]!,
                      wcag: tokens.textMuted,
                    ),
                  ),
                ),
                Text(
                  '${Globals.leftoverExp}/${Globals.requiredExp} XP',
                  style: GoogleFonts.inter(
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.w600, // Changed to semibold
                    color: wcagColor(
                      context,
                      standard: Colors.grey[600]!,
                      wcag: tokens.textMuted,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.035),

          _buildProfileOption(context, l10n.profileEditPersonalInfo, () => _showResetDialog(context)),
          SizedBox(
            height: screenHeight * 0.013,
          ), // Added spacing between list tiles
          _buildProfileOption(context, l10n.profileFeedback, () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.profileFeedbackComingSoon))
                );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ThaiIdInputPage()),
              );
          }),
          SizedBox(
            height: screenHeight * 0.013,
          ), // Added spacing between list tiles
          _buildLanguageSelector(context),
          SizedBox(
            height: screenHeight * 0.013,
          ),
          _buildAccessibilityToggle(context),
          SizedBox(
            height: screenHeight * 0.013,
          ),
          _buildTextScaleSlider(context),
          SizedBox(
            height: screenHeight * 0.013,
          ),
          // Sign Out option - now with consistent styling
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.0425,
            ), // Consistent padding
            child: ListTile(
              tileColor: Color(0xFFFAFAFA),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.0142,
              ),
              title: Text(
                l10n.profileSignOut,
                style: GoogleFonts.inter(
                  fontSize: screenWidth * 0.042,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.red,
              ),
              onTap: () => _showSignOutDialog(context),
            ),
          ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build profile options
  Widget _buildProfileOption(
      BuildContext context,
      String title,
      VoidCallback onTap,
      ) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(
      context,
    ).size.height; // Get screenHeight here

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0425),
      child: ListTile(
        tileColor: Color(0xFFFAFAFA), // Set tile color
        shape: RoundedRectangleBorder(
          // Apply border radius
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.0142,
        ),
        title: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: screenWidth * 0.042,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
        onTap: onTap,
      ),
    );
  }

  Widget _buildAccessibilityToggle(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0425),
      child: SwitchListTile(
        value: Globals.wcagModeEnabled,
        onChanged: (value) async {
          await Globals.setWcagMode(value);
          if (!mounted) return;
          setState(() {});
        },
        tileColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.012,
        ),
        title: Text(
          l10n.useWcag,
          style: GoogleFonts.inter(
            fontSize: screenWidth * 0.040,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          l10n.useWcagSubtitle,
          style: GoogleFonts.inter(
            fontSize: screenWidth * 0.03,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildTextScaleSlider(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = Globals.textScaleFactor;
    final textScalePercent = (textScaleFactor * 100).round();
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0425),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.012,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.textSize,
                    style: GoogleFonts.inter(
                      fontSize: screenWidth * 0.040,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  '$textScalePercent%',
                  style: GoogleFonts.inter(
                    fontSize: screenWidth * 0.036,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            Text(
              l10n.adjustTextScale,
              style: GoogleFonts.inter(
                fontSize: screenWidth * 0.03,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            Slider(
              value: textScaleFactor,
              min: AppTokens.userTextScaleMin,
              max: AppTokens.userTextScaleMax,
              divisions: 30,
              label: '$textScalePercent%',
              onChanged: (value) {
                Globals.setTextScale(value, persist: false);
                setState(() {});
              },
              onChangeEnd: (value) {
                Globals.setTextScale(value);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Dialog for sign out confirmation
  void _showSignOutDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.confirmSignOutTitle),
        content: Text(l10n.confirmSignOutMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () async {
              await Auth().signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => WidgetTree()),
                (route) => false,
              );
            },
            child: Text(l10n.yes),
          ),
        ],
      ),
    );
  }

  void _showResetDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.resetProgressTitle),
        content: Text(l10n.resetProgressMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () async {
              await Globals.reset();
              setState(() {}); // Update the UI
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.progressResetDone))
              );
            },
            child: Text(l10n.reset, style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSelector(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0425),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.012,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                l10n.languageSetting,
                style: GoogleFonts.inter(
                  fontSize: screenWidth * 0.040,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            DropdownButton<String>(
              value: Globals.locale.languageCode,
              onChanged: (value) async {
                if (value == null) return;
                await Globals.setLanguageCode(value);
                if (!mounted) return;
                setState(() {});
              },
              items: AppLanguage.supportedLanguages.map((language) {
                final label = language.code == 'th'
                    ? l10n.thaiLanguage
                    : l10n.englishLanguage;
                return DropdownMenuItem<String>(
                  value: language.code,
                  child: Text(label),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

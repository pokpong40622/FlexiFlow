import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_kit/app/app_settings.dart';
import 'package:motion_kit/fake_var.dart';
import 'package:motion_kit/main.dart';
import 'package:motion_kit/l10n/l10n.dart';
import 'package:motion_kit/memberships/AuthPage.dart';
import 'package:motion_kit/memberships/widget_tree.dart';
import 'package:motion_kit/pages/ThaiIdInputPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final settings = AppSettingsScope.of(context);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: screenHeight * 0.0265),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0425),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    size: screenWidth * 0.065,
                    color: Colors.black,
                  ),
                ),
                Text(
                  l10n.profile,
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: screenWidth * 0.054,
                  ),
                ),
                SizedBox(width: screenWidth * 0.06),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: screenWidth * 0.12,
                backgroundImage: const AssetImage('assets/FlexiFlowProfilePic.png'),
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
                    Icons.edit,
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
            style: GoogleFonts.inter(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: screenHeight * 0.005),
          Text(
            'pummiphach@gmail.com',
            style: GoogleFonts.inter(
              fontSize: screenWidth * 0.035,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
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
                    color: const Color(0xFF0397FD),
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
                  l10n.lvlShort(Globals.level),
                  style: GoogleFonts.inter(
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  '${Globals.leftoverExp}/${Globals.requiredExp} XP',
                  style: GoogleFonts.inter(
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.035),
          _buildProfileOption(context, l10n.editPersonalInformation, () => _showResetDialog(context)),
          SizedBox(height: screenHeight * 0.013),
          _buildProfileOption(context, l10n.language, () => _showLanguageDialog(context, settings)),
          SizedBox(height: screenHeight * 0.013),
          _buildProfileOption(context, l10n.feedback, () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.feedbackComingSoon)),
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ThaiIdInputPage()),
            );
          }),
          SizedBox(height: screenHeight * 0.013),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0425),
            child: ListTile(
              tileColor: const Color(0xFFFAFAFA),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.0142,
              ),
              title: Text(
                l10n.signOut,
                style: GoogleFonts.inter(
                  fontSize: screenWidth * 0.042,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.red),
              onTap: () => _showSignOutDialog(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption(BuildContext context, String title, VoidCallback onTap) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0425),
      child: ListTile(
        tileColor: const Color(0xFFFAFAFA),
        shape: RoundedRectangleBorder(
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
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
        onTap: onTap,
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, AppSettings settings) {
    final l10n = AppLocalizations.of(context)!;

    String labelForKey(String key) {
      switch (key) {
        case 'languageThai':
          return l10n.languageThai;
        case 'languageEnglish':
        default:
          return l10n.languageEnglish;
      }
    }

    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(l10n.languageSelectorTitle),
        children: [
          for (final language in AppSettings.supportedLanguages)
            RadioListTile<Locale>(
              value: language.locale,
              groupValue: settings.locale ?? L10n.defaultLocale,
              title: Text(labelForKey(language.labelKey)),
              onChanged: (value) async {
                await settings.setLocale(value);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
            ),
        ],
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.signOut),
        content: Text(l10n.signOutConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () async {
              await Auth().signOut();
              if (!context.mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const WidgetTree()),
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
        title: Text(l10n.resetProgress),
        content: Text(l10n.resetProgressConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () async {
              await Globals.reset();
              setState(() {});
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.allProgressReset)),
              );
            },
            child: Text(l10n.reset, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

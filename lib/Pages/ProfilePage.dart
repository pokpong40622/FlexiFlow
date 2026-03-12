import 'package:flexiflow/Memberships/AuthPage.dart';
import 'package:flexiflow/Memberships/LoginPage.dart';
import 'package:flexiflow/Memberships/widget_tree.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: screenHeight * 0.0265), // Top padding
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0425),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Custom Back Button
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new, // Changed to match button style
                    size: screenWidth * 0.065,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Profile',
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
            'Jiravit Hiransak',
            style: GoogleFonts.inter(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: screenHeight * 0.005),
          Text(
            'jiravithero@gmail.com',
            style: GoogleFonts.inter(
              fontSize: screenWidth * 0.035,
              fontWeight: FontWeight.w600, // Changed to semibold
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
                  width: screenWidth * 0.55,
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
                  'Lvl 14',
                  style: GoogleFonts.inter(
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.w600, // Changed to semibold
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  '827/1000',
                  style: GoogleFonts.inter(
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.w600, // Changed to semibold
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.035),

          _buildProfileOption(context, 'Edit personal information', () {}),
          SizedBox(
            height: screenHeight * 0.013,
          ), // Added spacing between list tiles
          _buildProfileOption(context, 'Feedback', () {}),
          SizedBox(
            height: screenHeight * 0.013,
          ), // Added spacing between list tiles
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
                'Sign Out',
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

  // Dialog for sign out confirmation
  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sign Out'),
        content: Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await Auth().signOut();
              Navigator.pop(context); // close dialog
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WidgetTree()),
              );
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }
}

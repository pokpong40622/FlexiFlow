import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_kit/memberships/AuthPage.dart';
import 'package:motion_kit/memberships/LoginPage.dart';
import 'package:motion_kit/others/NavigationBar.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _obscurePassword = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerBirthday = TextEditingController();
  final TextEditingController _controllerGender = TextEditingController();

  String? errorMessage = '';

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerName.dispose();
    _controllerPhone.dispose();
    _controllerBirthday.dispose();
    _controllerGender.dispose();
    super.dispose();
  }

  Future<void> createUserWithEmailAndPassword() async {
    final l10n = AppLocalizations.of(context)!;
    try {
      if (_controllerEmail.text.trim().isEmpty || _controllerPassword.text.trim().isEmpty || _controllerName.text.trim().isEmpty) {
        setState(() {
          errorMessage = l10n.pleaseFillRequiredFields;
        });
        return;
      }

      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text.trim(),
        password: _controllerPassword.text.trim(),
      );

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NavigationBarSet()),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    } catch (_) {
      setState(() {
        errorMessage = l10n.unexpectedError;
      });
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? _obscurePassword : false,
        decoration: InputDecoration(
          labelText: label,
          hintText: label,
          hintStyle: GoogleFonts.inter(
            color: Colors.grey[400],
            fontSize: 14,
          ),
          prefixIcon: Icon(icon, color: Colors.grey[500], size: 22),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: Colors.grey[500],
                    size: 22,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
        style: GoogleFonts.inter(
          fontSize: 14,
          color: const Color(0xFF2C2C2C),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.25,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x331E88E5),
                    spreadRadius: 4,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ExcludeSemantics(
                    child: Image.asset(
                      'assets/FlexiFlowLogoWhite.png',
                      width: screenWidth * 0.2,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.createAccount,
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                children: [
                  _buildTextField(controller: _controllerName, icon: Icons.person_outline, label: l10n.fullName),
                  const SizedBox(height: 16),
                  _buildTextField(controller: _controllerEmail, icon: Icons.email_outlined, label: l10n.email),
                  const SizedBox(height: 16),
                  _buildTextField(controller: _controllerPassword, icon: Icons.lock_outline, label: l10n.password, isPassword: true),
                  const SizedBox(height: 16),
                  _buildTextField(controller: _controllerPhone, icon: Icons.phone_outlined, label: l10n.emergencyContact),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(controller: _controllerBirthday, icon: Icons.calendar_today_outlined, label: l10n.birthday),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildTextField(controller: _controllerGender, icon: Icons.people_outline, label: l10n.gender),
                      ),
                    ],
                  ),
                  if (errorMessage != null && errorMessage!.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.error_outline, color: Colors.red, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              errorMessage!,
                              style: GoogleFonts.inter(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: createUserWithEmailAndPassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E88E5),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        shadowColor: const Color(0x4D1E88E5),
                      ),
                      child: Text(
                        l10n.signUp,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${l10n.alreadyHaveAccount} ',
                        style: GoogleFonts.inter(color: Colors.grey[600], fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                            (route) => false,
                          );
                        },
                        child: Text(
                          l10n.signIn,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF1E88E5),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

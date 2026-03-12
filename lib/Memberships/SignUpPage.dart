import 'package:flexiflow/Memberships/AuthPage.dart';
import 'package:flexiflow/Memberships/LoginPage.dart';
import 'package:flexiflow/Others/NavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  String? errorMessage = '';
  bool isLogin = true;

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NavigationBarSet()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _buildTextField({
    required IconData icon,
    required String hint,
    required TextEditingController controller,
    bool isPassword = false,
    bool obscureText = false,
    void Function()? toggleObscure,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFE0E0E0), width: 2),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: GoogleFonts.montserrat(
                  color: Color(0xFFBDBDBD),
                  fontWeight: FontWeight.w600,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                suffixIcon: isPassword
                    ? IconButton(
                        icon: Icon(
                          obscureText
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.black,
                          size: 22,
                        ),
                        onPressed: toggleObscure,
                      )
                    : null,
              ),
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Image.asset('assets/FlexiFlowLogoColor.png', width: 100),
                const SizedBox(height: 16),
                Text(
                  'Create an account',
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 48),
                _buildTextField(
                  controller: _controllerName,
                  icon: Icons.person_outline,
                  hint: 'Full name',
                ),
                _buildTextField(
                  controller: _controllerEmail,
                  icon: Icons.email_outlined,
                  hint: 'Email',
                ),
                _buildTextField(
                  controller: _controllerPassword,
                  icon: Icons.lock_outline,
                  hint: 'Password',
                  isPassword: true,
                  obscureText: _obscurePassword,
                  toggleObscure: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                _buildTextField(
                  controller: TextEditingController(),
                  icon: Icons.phone_outlined,
                  hint: 'Emergency contact',
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: TextEditingController(),
                        icon: Icons.calendar_today_outlined,
                        hint: 'Birthday',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildTextField(
                        controller: TextEditingController(),
                        icon: Icons.people_outline,
                        hint: 'Gender',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                GestureDetector(
                  onTap: isLogin ? createUserWithEmailAndPassword : null,
                  child: Container(
                    width: screenWidth * 0.9,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        'Back',
                        style: GoogleFonts.montserrat(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_kit/fake_var.dart';
import 'package:motion_kit/theme/wcag_utils.dart';

class ThaiIdInputPage extends StatefulWidget {
  const ThaiIdInputPage({super.key});

  @override
  State<ThaiIdInputPage> createState() => _ThaiIdInputPageState();
}

class _ThaiIdInputPageState extends State<ThaiIdInputPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _frontIdController = TextEditingController();
  final TextEditingController _backIdController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Logic for submitting the ID goes here
      Globals.isThaiIdVerified = true;
      Globals.save();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Thai ID successfully verified',
            style: GoogleFonts.inter(fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context, true);
    }
  }

  @override
  void dispose() {
    _frontIdController.dispose();
    _backIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final tokens = tokensOf(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black, size: screenWidth * 0.055),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'ID Verification',
          style: GoogleFonts.montserrat(
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Please enter the numerical details exactly as they appear on your Thai National ID Card.',
                  style: GoogleFonts.inter(
                    fontSize: screenWidth * 0.035,
                    color: wcagColor(
                      context,
                      standard: Colors.grey[700]!,
                      wcag: tokens.textSecondary,
                    ),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 30),

                // Front ID Section
                Text(
                  'Front ID Number',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: screenWidth * 0.04,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                _buildInputField(
                  controller: _frontIdController,
                  hintText: 'X-XXXX-XXXXX-XX-X',
                  maxLength: 13,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your front ID number';
                    }
                    if (value.length != 13) {
                      return 'Front ID must be 13 digits';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/ThaiID-Front.png',
                    width: double.infinity,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.grey[300],
                      alignment: Alignment.center,
                      child: Text(
                        'Front ID Mockup Missing',
                        style: GoogleFonts.inter(
                          color: wcagColor(
                            context,
                            standard: Colors.grey[600]!,
                            wcag: tokens.textMuted,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Back ID Section
                Text(
                  'Back Laser Code',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: screenWidth * 0.04,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                _buildInputField(
                  controller: _backIdController,
                  hintText: 'XX0000000000 (2 letters, 10 digits)',
                  maxLength: 12,
                  textCapitalization: TextCapitalization.characters,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your back ID laser code';
                    }
                    if (value.length != 12) {
                      return 'Laser code must be 12 characters';
                    }
                    // Optional regex check for 2 letters and 10 numbers
                    if (!RegExp(r'^[A-Za-z]{2}\d{10}$').hasMatch(value)) {
                      return 'Must be 2 letters followed by 10 digits';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/ThaiID-Back.png',
                    width: double.infinity,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.grey[300],
                      alignment: Alignment.center,
                      child: Text(
                        'Back ID Mockup Missing',
                        style: GoogleFonts.inter(
                          color: wcagColor(
                            context,
                            standard: Colors.grey[600]!,
                            wcag: tokens.textMuted,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Submit Button
                GestureDetector(
                  onTap: _submit,
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0397FD), Color(0xFF0262A4)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0397FD).withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Verify ID',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required int maxLength,
    TextInputType keyboardType = TextInputType.text,
    TextCapitalization textCapitalization = TextCapitalization.none,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      maxLength: maxLength,
      style: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.inter(
          fontSize: 14,
          color: wcagColor(
            context,
            standard: Colors.grey[400]!,
            wcag: tokensOf(context).textDisabled,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        counterText: '',
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: wcagColor(
              context,
              standard: Colors.grey[300]!,
              wcag: tokensOf(context).borderDisabled,
            ),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: wcagColor(
              context,
              standard: Colors.grey[300]!,
              wcag: tokensOf(context).borderDisabled,
            ),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF0397FD), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
      validator: validator,
    );
  }
}

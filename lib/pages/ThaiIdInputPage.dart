import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_kit/fake_var.dart';

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
    final l10n = AppLocalizations.of(context)!;

    if (_formKey.currentState!.validate()) {
      Globals.isThaiIdVerified = true;
      Globals.save();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n.thaiIdSuccessfullyVerified,
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
    final l10n = AppLocalizations.of(context)!;
    double screenWidth = MediaQuery.of(context).size.width;

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
          l10n.idVerification,
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
                  l10n.thaiIdInstruction,
                  style: GoogleFonts.inter(
                    fontSize: screenWidth * 0.035,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  l10n.frontIdNumber,
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
                    if (value == null || value.isEmpty) return l10n.pleaseEnterFrontId;
                    if (value.length != 13) return l10n.frontIdMustBe13Digits;
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
                        l10n.frontIdMockupMissing,
                        style: GoogleFonts.inter(color: Colors.grey[600]),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  l10n.backLaserCode,
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
                    if (value == null || value.isEmpty) return l10n.pleaseEnterBackLaserCode;
                    if (value.length != 12) return l10n.laserCodeMustBe12Chars;
                    if (!RegExp(r'^[A-Za-z]{2}\d{10}$').hasMatch(value)) {
                      return l10n.laserCodePatternError;
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
                        l10n.backIdMockupMissing,
                        style: GoogleFonts.inter(color: Colors.grey[600]),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0397FD),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text(
                      l10n.verifyId,
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
          color: Colors.grey[400],
        ),
        filled: true,
        fillColor: Colors.white,
        counterText: '',
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
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

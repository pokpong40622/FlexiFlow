import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class SawasdeeWanPage extends StatefulWidget {
  final int score;

  const SawasdeeWanPage({super.key, this.score = 100});

  @override
  State<SawasdeeWanPage> createState() => _SawasdeeWanPageState();
}

class _SawasdeeWanPageState extends State<SawasdeeWanPage> {
  final GlobalKey _globalKey = GlobalKey();
  bool _isSharing = false;

  Future<void> _shareImage() async {
    if (_isSharing) return;
    setState(() {
      _isSharing = true;
    });

    try {
      RenderRepaintBoundary boundary =
          _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        Uint8List pngBytes = byteData.buffer.asUint8List();
        final directory = await getTemporaryDirectory();
        final imagePath = await File('${directory.path}/sawasdee_share.png').create();
        await imagePath.writeAsBytes(pngBytes);

        await Share.shareXFiles([XFile(imagePath.path)],
            text: 'สวัสดีวันจันทร์ จาก FlexiFlow!');
      }
    } catch (e) {
      debugPrint('Error sharing image: $e');
    } finally {
      setState(() {
        _isSharing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: RepaintBoundary(
                key: _globalKey,
                child: Container(
                  color: const Color(0xFFF9F9F9),
                  child: Column(
                    children: [
                      // Top Image section
                      Stack(
                        children: [
                          ClipPath(
                            clipper: BottomCurveClipper(),
                            child: Image.asset(
                              'assets/sawasdee/default/monday.jpg',
                              width: sw,
                              height: sh * 0.55,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: sh * 0.1,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Text(
                                'สวัสดีวันจันทร์',
                                style: GoogleFonts.kanit(
                                  fontSize: sw * 0.12,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      offset: const Offset(1, 2),
                                      blurRadius: 4.0,
                                      color: Colors.black.withOpacity(0.3),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: sh * 0.02),
                      
                      // Score Text
                      Text(
                        'คะแนนพลังสมองวันนี้:',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.kanit(
                          fontSize: sw * 0.075,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          height: 1.2,
                        ),
                      ),
                      Text(
                        '${widget.score} แต้ม!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.kanit(
                          fontSize: sw * 0.09,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          height: 1.2,
                        ),
                      ),
                      
                      SizedBox(height: sh * 0.04),
                      
                      // Message Text
                      Text(
                        'ฉันดูแลตัวเองแล้ว',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.kanit(
                          fontSize: sw * 0.055,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFBC471A),
                          height: 1.2,
                        ),
                      ),
                      Text(
                        'เธออย่าลืมดูแลตัวเองนะ',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.kanit(
                          fontSize: sw * 0.055,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFBC471A),
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: sh * 0.01),
                      Text(
                        'มาดาวน์โหลดแอป FlexiFlow กันเลย!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.kanit(
                          fontSize: sw * 0.055,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF140854),
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Buttons Section (Not inside RepaintBoundary)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF140854),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        'ออก',
                        style: GoogleFonts.kanit(
                          fontSize: sw * 0.065,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _isSharing ? null : _shareImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC75416),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: _isSharing
                          ? const SizedBox(
                              height: 28,
                              width: 28,
                              child: CircularProgressIndicator(color: Colors.white),
                            )
                          : Text(
                              'ส่งให้เพื่อน',
                              style: GoogleFonts.kanit(
                                fontSize: sw * 0.065,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
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

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
        size.width / 2, size.height + 40, size.width, size.height - 60);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

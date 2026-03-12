import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexiflow/Memberships/AuthPage.dart';
import 'package:flexiflow/Memberships/SignUpPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
        print('KIM $errorMessage');
      });
    }
  }

  // Future<void> createUserWithEmailAndPassword() async {
  //   try {
  //     await Auth().createUserWithEmailAndPassword(
  //       email: _controllerEmail.text,
  //       password: _controllerPassword.text,
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     setState(() {
  //       errorMessage = e.message;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0397FD), // Background color
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height:
                MediaQuery.of(context).size.height *
                0.1635, // Adjust the height
            color: Color(0xFF0397FD),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              // Wrap content in SingleChildScrollView to handle keyboard overflow
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50),
                      Image.asset('assets/FlexiFlowLogoColor.png', width: 98),
                      SizedBox(height: 24),
                      Text(
                        'Welcome Back',
                        style: GoogleFonts.montserrat(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 68),

                      // Email TextField
                      Container(
                        width: MediaQuery.of(context).size.width * 0.864638,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey[300]!,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.email_outlined,
                              color: Colors.black,
                              size: 30.0,
                            ),
                            SizedBox(width: 12.0),
                            Expanded(
                              child: TextField(
                                controller: _controllerEmail,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: GoogleFonts.montserrat(
                                    color: Color(0xFFCCCCCC),
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 12.0,
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                style: GoogleFonts.montserrat(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      // Password TextField
                      Container(
                        width: MediaQuery.of(context).size.width * 0.864638,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey[300]!,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lock_outline,
                              color: Colors.black,
                              size: 30.0,
                            ),
                            SizedBox(width: 12.0),
                            Expanded(
                              child: TextField(
                                controller: _controllerPassword,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: GoogleFonts.montserrat(
                                    color: Color(0xFFCCCCCC),
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 12.0,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: Colors.black,
                                      size: 26.0,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  ),
                                ),
                                style: GoogleFonts.montserrat(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      // Error Message
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 10, top: 5),
                          child: Text(
                            errorMessage == ''
                                ? ''
                                : (errorMessage ==
                                        'The supplied auth credential is incorrect, malformed or has expired.'
                                    ? 'Incorrect email or password'
                                    : 'An error occurred, please try again'),
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700,
                              color: Colors.red,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 42),
                      GestureDetector(
                        onTap: isLogin ? signInWithEmailAndPassword : null,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8649,
                          height: MediaQuery.of(context).size.height * 0.06111,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Color(0xFF0397FD),
                          ),
                          child: Center(
                            child: Text(
                              'Sign in',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupPage(),
                                ),
                              );
                            },
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignupPage(),
                                  ),
                                );
                              },
                              child: Text(
                                'Create an account',
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF0397FD),
                                  fontSize: 9,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 34),
                        ],
                      ),
                      // Add extra space at bottom to ensure everything is visible when keyboard is open
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // Enable resizeToAvoidBottomInset
    );
  }
}

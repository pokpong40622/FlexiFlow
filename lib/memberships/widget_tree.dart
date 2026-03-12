import 'package:firebase_auth/firebase_auth.dart';
import 'package:motion_kit/others/NavigationBar.dart';
import 'package:motion_kit/memberships/AuthPage.dart';
import 'package:motion_kit/memberships/LoginPage.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context,snapshot) {
        if(snapshot.hasData){
          return NavigationBarSet();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexiflow/Memberships/AuthPage.dart';
import 'package:flexiflow/Memberships/LoginPage.dart';
import 'package:flexiflow/Others/NavigationBar.dart';
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
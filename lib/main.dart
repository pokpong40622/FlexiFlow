import 'package:flexiflow/Others/NavigationBar.dart';
import 'package:flexiflow/Pages/GetStarted.dart';
import 'package:flexiflow/Pages/HomePage.dart';
import 'package:flexiflow/Pages/ShopPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); 

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);


  runApp(MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavigationBarSet(),
      
    );
  }
}

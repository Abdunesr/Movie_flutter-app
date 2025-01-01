import 'package:flutter/material.dart';
import 'dart:async';
import 'componets/homepage.dart';
import 'Anim/anim.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF1A1A2E), // Dark Blue
        hintColor: Color(0xFFFFC947), // Accent Yellow
        scaffoldBackgroundColor: Color(0xFF1A1A2E), // Dark Blue
        textTheme: TextTheme(
          displayLarge: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFFF9F9F9)), // Soft White
          bodyLarge:
              TextStyle(fontSize: 16.0, color: Color(0xFFE3E3E3)), // Cool Gray
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFFFFC947), // Accent Yellow
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        appBarTheme: AppBarTheme(
          color: Color(0xFF1A1A2E), // Dark Blue
          iconTheme: IconThemeData(color: Color(0xFFFFC947)), // Accent Yellow
          titleTextStyle: TextStyle(
              color: Color(0xFFF9F9F9),
              fontSize: 20.0,
              fontWeight: FontWeight.bold),
        ),
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to Homepage after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreens();
  }
}

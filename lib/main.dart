import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const BloomifyApp());
}

class BloomifyApp extends StatelessWidget {
  const BloomifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bloomify',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: const Color(0xfffdf4ff),
      ),
      home: const LoginScreen(),
    );
  }
}

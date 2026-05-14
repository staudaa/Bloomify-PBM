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

        scaffoldBackgroundColor:
            Colors.white,

        fontFamily: 'Roboto',

        appBarTheme: const AppBarTheme(
          backgroundColor:
              Color(0xffBFA2DB),

          elevation: 0,

          centerTitle: true,

          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),

          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),

        elevatedButtonTheme:
            ElevatedButtonThemeData(

          style:
              ElevatedButton.styleFrom(

            backgroundColor:
                const Color(0xffBFA2DB),

            foregroundColor:
                Colors.white,

            elevation: 5,

            shape:
                RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(
                20,
              ),
            ),
          ),
        ),
      ),

      home: const LoginScreen(),
    );
  }
}
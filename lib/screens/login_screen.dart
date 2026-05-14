import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../services/storage_service.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final TextEditingController
      usernameController =
      TextEditingController();

  final TextEditingController
      passwordController =
      TextEditingController();

  bool isLoading = false;

  Future<void> login() async {

    setState(() {
      isLoading = true;
    });

    String? token =
        await ApiService.login(
      usernameController.text,
      passwordController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (token != null) {

      await StorageService.saveToken(
        token,
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) =>
                  const HomeScreen(),
        ),
      );

    } else {

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
              Text('Login gagal'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.all(20),

          child: Column(
            children: [

              const Icon(
                Icons.local_florist,
                size: 100,
                color: Colors.pink,
              ),

              const SizedBox(height: 20),

              const Text(
                'Bloomify',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight:
                      FontWeight.bold,
                  color: Colors.blue,
                ),
              ),

              const SizedBox(height: 40),

              TextField(
                controller:
                    usernameController,

                decoration:
                    InputDecoration(
                  labelText:
                      'Username',

                  border:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(
                      20,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller:
                    passwordController,

                obscureText: true,

                decoration:
                    InputDecoration(
                  labelText:
                      'Password',

                  border:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(
                      20,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed: login,

                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.pink,
                  ),

                  child: isLoading
                      ? const CircularProgressIndicator(
                          color:
                              Colors.white,
                        )
                      : const Text(
                          'LOGIN',
                          style:
                              TextStyle(
                            color:
                                Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
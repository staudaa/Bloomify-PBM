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

      body: Container(

        decoration: const BoxDecoration(

          gradient: LinearGradient(

            begin: Alignment.topLeft,
            end: Alignment.bottomRight,

            colors: [

              Color(0xffF8D7E8),
              Color(0xffEBDCF8),
              Color(0xffDCCEF9),
            ],
          ),
        ),

        child: Center(

          child: SingleChildScrollView(

            padding:
                const EdgeInsets.all(25),

            child: Container(

              padding:
                  const EdgeInsets.all(25),

              decoration: BoxDecoration(

                color:
                    Colors.white.withOpacity(
                  0.9,
                ),

                borderRadius:
                    BorderRadius.circular(
                  30,
                ),

                boxShadow: [

                  BoxShadow(
                    color:
                        Colors.black12,

                    blurRadius: 15,

                    offset:
                        const Offset(0, 5),
                  ),
                ],
              ),

              child: Column(
                children: [

                  Container(
                    width: 100,
                    height: 100,

                    decoration: BoxDecoration(
                      color:
                          const Color(
                        0xffF8D7E8,
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        30,
                      ),
                    ),

                    child: const Icon(
                      Icons.local_florist,
                      size: 60,
                      color:
                          Color(0xffBFA2DB),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Bloomify',

                    style: TextStyle(
                      fontSize: 35,
                      fontWeight:
                          FontWeight.bold,

                      color:
                          Color(0xff5E548E),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Flower Catalog App',

                    style: TextStyle(
                      color:
                          Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 40),

                  TextField(
                    controller:
                        usernameController,

                    decoration:
                        InputDecoration(

                      filled: true,

                      fillColor:
                          const Color(
                        0xffF9F4FC,
                      ),

                      hintText:
                          'Username',

                      prefixIcon:
                          const Icon(
                        Icons.person,
                        color:
                            Color(
                          0xffBFA2DB,
                        ),
                      ),

                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(
                          20,
                        ),

                        borderSide:
                            BorderSide.none,
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

                      filled: true,

                      fillColor:
                          const Color(
                        0xffF9F4FC,
                      ),

                      hintText:
                          'Password',

                      prefixIcon:
                          const Icon(
                        Icons.lock,
                        color:
                            Color(
                          0xffBFA2DB,
                        ),
                      ),

                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(
                          20,
                        ),

                        borderSide:
                            BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 55,

                    child: ElevatedButton(

                      onPressed: login,

                      child: isLoading
                          ? const CircularProgressIndicator(
                              color:
                                  Colors.white,
                            )
                          : const Text(
                              'LOGIN',

                              style: TextStyle(
                                fontSize: 16,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../services/storage_service.dart';

class SubmitScreen
    extends StatefulWidget {

  const SubmitScreen({
    super.key,
  });

  @override
  State<SubmitScreen>
      createState() =>
          _SubmitScreenState();
}

class _SubmitScreenState
    extends State<SubmitScreen> {

  final TextEditingController
      nameController =
      TextEditingController();

  final TextEditingController
      priceController =
      TextEditingController();

  final TextEditingController
      descriptionController =
      TextEditingController();

  final TextEditingController
      githubController =
      TextEditingController();

  bool isLoading = false;

  Future<void> submitTask() async {

    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        githubController.text.isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Semua field wajib diisi',
          ),
        ),
      );

      return;
    }

    bool? confirm =
        await showDialog(

      context: context,

      builder: (context) {

        return AlertDialog(

          title: const Text(
            'Konfirmasi Submit',
          ),

          content: const Text(
            'Pastikan data dan GitHub URL sudah benar karena submit tidak dapat diedit kembali.',
          ),

          actions: [

            TextButton(
              onPressed: () {

                Navigator.pop(
                  context,
                  false,
                );
              },

              child: const Text(
                'Batal',
              ),
            ),

            ElevatedButton(
              onPressed: () {

                Navigator.pop(
                  context,
                  true,
                );
              },

              child: const Text(
                'Submit',
              ),
            ),
          ],
        );
      },
    );

    if (confirm != true) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    String? token =
        await StorageService.getToken();

    if (token != null) {

      bool success =
          await ApiService.submitTask(
        token,
        nameController.text,
        int.parse(priceController.text),
        descriptionController.text,
        githubController.text,
      );

      setState(() {
        isLoading = false;
      });

      if (success) {

        if (!mounted) return;

        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content:
                Text(
              'Tugas berhasil disubmit 🌸',
            ),
          ),
        );

        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Submit Tugas',

          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller: nameController,

              decoration:
                  InputDecoration(
                labelText:
                    'Nama Produk',

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
                  priceController,

              keyboardType:
                  TextInputType.number,

              decoration:
                  InputDecoration(
                labelText:
                    'Harga',

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
                  descriptionController,

              maxLines: 4,

              decoration:
                  InputDecoration(
                labelText:
                    'Deskripsi',

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
                  githubController,

              decoration:
                  InputDecoration(
                labelText:
                    'GitHub URL',

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
                onPressed:
                    submitTask,

                style:
                    ElevatedButton.styleFrom(
                  // backgroundColor:
                  //     Colors.blue,

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      20,
                    ),
                  ),
                ),

                child: isLoading
                    ? const CircularProgressIndicator(
                        color:
                            Colors.white,
                      )
                    : const Text(
                        'SUBMIT TUGAS',

                        style: TextStyle(
                          color:
                              Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
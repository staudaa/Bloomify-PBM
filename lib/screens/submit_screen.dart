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

    if (priceController.text.isEmpty) {
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
                Text('Submit berhasil'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.pink,

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
                  const InputDecoration(
                labelText:
                    'Nama Produk',
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller:
                  priceController,

              keyboardType:
                  TextInputType.number,

              decoration:
                  const InputDecoration(
                labelText: 'Harga',
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller:
                  descriptionController,

              decoration:
                  const InputDecoration(
                labelText:
                    'Deskripsi',
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller:
                  githubController,

              decoration:
                  const InputDecoration(
                labelText:
                    'GitHub URL',
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton(
                onPressed:
                    submitTask,

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.blue,
                ),

                child: isLoading
                    ? const CircularProgressIndicator(
                        color:
                            Colors.white,
                      )
                    : const Text(
                        'SUBMIT',
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
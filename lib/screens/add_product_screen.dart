import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../services/storage_service.dart';

class AddProductScreen
    extends StatefulWidget {

  const AddProductScreen({
    super.key,
  });

  @override
  State<AddProductScreen>
      createState() =>
          _AddProductScreenState();
}

class _AddProductScreenState
    extends State<AddProductScreen> {

  final TextEditingController
      nameController =
      TextEditingController();

  final TextEditingController
      priceController =
      TextEditingController();

  final TextEditingController
      descriptionController =
      TextEditingController();

  bool isLoading = false;

  Future<void> addProduct() async {

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
          await ApiService.addProduct(
        token,
        nameController.text,
        int.parse(priceController.text),
        descriptionController.text,
      );

      setState(() {
        isLoading = false;
      });

      if (success) {

        if (!mounted) return;

        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blue,

        title: const Text(
          'Tambah Produk',
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
                    'Nama Bunga',
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

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton(
                onPressed: addProduct,

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
                        'SIMPAN',
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
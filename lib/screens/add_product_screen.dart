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

    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        descriptionController.text.isEmpty) {

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
            'Konfirmasi Produk',
          ),

          content: const Text(
            'Pastikan data produk sudah benar karena tidak dapat diedit kembali.',
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
                'Lanjut',
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

        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              'Produk berhasil ditambahkan 🌸',
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
                  InputDecoration(
                labelText:
                    'Nama Bunga',

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
                labelText: 'Harga',

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

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                onPressed:
                    addProduct,

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.pink,

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
                        'SIMPAN PRODUK',

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
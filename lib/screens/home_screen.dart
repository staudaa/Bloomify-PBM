import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

import '../widgets/product_card.dart';

import 'add_product_screen.dart';
import 'submit_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  List<ProductModel> products = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  Future<void> getProducts() async {

    String? token =
        await StorageService.getToken();

    if (token != null) {

      List<ProductModel> result =
          await ApiService.getProducts(
        token,
      );

      setState(() {
        products = result;
        isLoading = false;
      });
    }
  }

  Future<void> logout() async {

    await StorageService.deleteToken();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Bloomify',
          style: TextStyle(
            color: Colors.white,
          ),
        ),

        actions: [

          IconButton(
            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          const SubmitScreen(),
                ),
              );
            },

            icon: const Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),

          IconButton(
            onPressed: logout,

            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),

      body: isLoading
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : products.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    children: [

                      Icon(
                        Icons.local_florist,
                        size: 80,
                        color:
                            Colors.pink.shade200,
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      const Text(
                        'Belum ada katalog bunga 🌸',

                        style: TextStyle(
                          fontSize: 20,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      const Text(
                        'Tambahkan produk bunga pertamamu',
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount:
                      products.length,

                  itemBuilder:
                      (context, index) {

                    return ProductCard(

                      product:
                          products[index],

                      onDelete: () {

                        showDialog(
                          context: context,

                          builder:
                              (context) {

                            return AlertDialog(

                              title:
                                  const Text(
                                'Hapus Draft?',
                              ),

                              content:
                                  const Text(
                                'Produk hanya akan dihapus dari tampilan aplikasi mahasiswa.',
                              ),

                              actions: [

                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(
                                      context,
                                    );
                                  },

                                  child:
                                      const Text(
                                    'Batal',
                                  ),
                                ),

                                ElevatedButton(
                                  onPressed:
                                      () {

                                    setState(() {
                                      products.removeAt(
                                        index,
                                      );
                                    });

                                    Navigator.pop(
                                      context,
                                    );

                                    ScaffoldMessenger.of(
                                            context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text(
                                          'Draft berhasil disembunyikan 🌸',
                                        ),
                                      ),
                                    );
                                  },

                                  child:
                                      const Text(
                                    'Hapus',
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                ),

      floatingActionButton:
          FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),

        onPressed: () async {

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      const AddProductScreen(),
            ),
          );

          getProducts();
        },
      ),
    );
  }
}
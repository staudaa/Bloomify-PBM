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
        backgroundColor: Colors.pink,

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
              ? const Center(
                  child: Text(
                    'Belum ada produk bunga',
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
                    );
                  },
                ),

      floatingActionButton:
          FloatingActionButton(
        backgroundColor: Colors.blue,

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
import 'package:flutter/material.dart';

import '../models/product_model.dart';

class ProductCard extends StatelessWidget {

  final ProductModel product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      margin:
          const EdgeInsets.all(10),

      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20),
      ),

      elevation: 5,

      child: ListTile(

        leading: Container(
          width: 50,
          height: 50,

          decoration: BoxDecoration(
            color: Colors.pink.shade100,
            borderRadius:
                BorderRadius.circular(15),
          ),

          child: const Icon(
            Icons.local_florist,
            color: Colors.pink,
          ),
        ),

        title: Text(
          product.name,
          style: const TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),

        subtitle: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const SizedBox(height: 5),

            Text(product.description),

            const SizedBox(height: 5),

            Text(
              'Rp ${product.price.toStringAsFixed(0)}',

              style: const TextStyle(
                color: Colors.blue,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
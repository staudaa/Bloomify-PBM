import 'package:flutter/material.dart';

import '../models/product_model.dart';

class ProductCard extends StatelessWidget {

  final ProductModel product;

  final VoidCallback onDelete;

  const ProductCard({
    super.key,
    required this.product,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      margin:
          const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),

      decoration: BoxDecoration(

        gradient: const LinearGradient(

          colors: [

            Color(0xffFFF7FB),
            Color(0xffF3ECFF),
          ],
        ),

        borderRadius:
            BorderRadius.circular(25),

        boxShadow: [

          BoxShadow(
            color:
                Colors.purple.shade100,

            blurRadius: 10,

            offset:
                const Offset(0, 5),
          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.all(15),

        child: Row(
          children: [

            Container(
              width: 70,
              height: 70,

              decoration: BoxDecoration(

                color:
                    const Color(
                  0xffF8D7E8,
                ),

                borderRadius:
                    BorderRadius.circular(
                  20,
                ),
              ),

              child: const Icon(
                Icons.local_florist,

                color:
                    Color(0xffBFA2DB),

                size: 40,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    product.name,

                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,

                      color:
                          Color(0xff5E548E),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    product.description,

                    style: const TextStyle(
                      color:
                          Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Rp ${product.price.toStringAsFixed(0)}',

                    style: const TextStyle(
                      color:
                          Color(0xffBFA2DB),

                      fontWeight:
                          FontWeight.bold,

                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            IconButton(
              onPressed: onDelete,

              icon: const Icon(
                Icons.delete_outline,

                color:
                    Color(0xffBFA2DB),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
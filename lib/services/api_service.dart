import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';

class ApiService {

  static const String baseUrl =
      'https://task.itprojects.web.id';

  // LOGIN
  static Future<String?> login(
    String username,
    String password,
  ) async {

    try {

      final response = await http.post(
        Uri.parse(
          '$baseUrl/api/auth/login',
        ),

        headers: {
          'Content-Type':
              'application/json',
          'Accept':
              'application/json',
        },

        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {

        final data =
            jsonDecode(response.body);

        return data['data']['token'];
      }

      return null;

    } catch (e) {

      return null;
    }
  }

  // GET PRODUCTS
  static Future<List<ProductModel>>
      getProducts(String token) async {

    try {

      final response = await http.get(
        Uri.parse(
          '$baseUrl/api/products',
        ),

        headers: {
          'Authorization':
              'Bearer $token',
          'Accept':
              'application/json',
        },
      );

      if (response.statusCode == 200) {

        final data =
            jsonDecode(response.body);

        List products = [];

        if (data['data'] is List) {

          products = data['data'];

        } else if (
            data['data']['products']
                !=
            null) {

          products =
              data['data']['products'];
        }

        return products
            .map(
              (e) =>
                  ProductModel.fromJson(e),
            )
            .toList();
      }

      return [];

    } catch (e) {

      return [];
    }
  }

  // ADD PRODUCT
  static Future<bool> addProduct(
    String token,
    String name,
    int price,
    String description,
  ) async {

    try {

      final response = await http.post(
        Uri.parse(
          '$baseUrl/api/products',
        ),

        headers: {
          'Authorization':
              'Bearer $token',

          'Content-Type':
              'application/json',

          'Accept':
              'application/json',
        },

        body: jsonEncode({
          'name': name,
          'price': price,
          'description':
              description,
        }),
      );

      return response.statusCode ==
              200 ||
          response.statusCode == 201;

    } catch (e) {

      return false;
    }
  }

  // SUBMIT TUGAS
  static Future<bool> submitTask(
    String token,
    String name,
    int price,
    String description,
    String githubUrl,
  ) async {

    try {

      final response = await http.post(
        Uri.parse(
          '$baseUrl/api/products/submit',
        ),

        headers: {
          'Authorization':
              'Bearer $token',

          'Content-Type':
              'application/json',

          'Accept':
              'application/json',
        },

        body: jsonEncode({
          'name': name,
          'price': price,
          'description':
              description,
          'github_url':
              githubUrl,
        }),
      );

      return response.statusCode ==
              200 ||
          response.statusCode == 201;

    } catch (e) {

      return false;
    }
  }
}
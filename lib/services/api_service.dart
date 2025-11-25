import 'dart:convert';
import 'dart:io'; // Untuk cek Platform
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  // 1. Define baseUrl with platform-specific logic
  static String get baseUrl {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8000/api';
    } else {
      return 'http://127.0.0.1:8000/api';
    }
  }

  // 2. Create fetchProducts method (returns Future<List<Product>>)
  static Future<List<Product>> fetchProducts() async {
    try {
      // GET request to '$baseUrl/products'
      final response = await http.get(Uri.parse('$baseUrl/products'));

      // Check if statusCode is 200
      if (response.statusCode == 200) {
        // Decode JSON. The structure is { "data": [...] }
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        
        // Check if the response has the expected structure
        if (jsonResponse.containsKey('data') && jsonResponse['data'] is List) {
          // Map the 'data' list to Product objects using Product.fromJson
          final List<dynamic> dataList = jsonResponse['data'];
          final List<Product> products = dataList
              .map((json) => Product.fromJson(json as Map<String, dynamic>))
              .toList();
          
          return products;
        } else {
          throw Exception('Invalid response structure: missing "data" field');
        }
      } else {
        // Throw Exception if failed
        throw Exception('Failed to load products. Status code: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('Network error: Unable to connect to server');
    } on FormatException {
      throw Exception('Invalid JSON response from server');
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  // Additional helper method for getting a single product
  static Future<Product> fetchProduct(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products/$id'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        
        if (jsonResponse.containsKey('data')) {
          return Product.fromJson(jsonResponse['data'] as Map<String, dynamic>);
        } else {
          throw Exception('Invalid response structure: missing "data" field');
        }
      } else {
        throw Exception('Failed to load product. Status code: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('Network error: Unable to connect to server');
    } on FormatException {
      throw Exception('Invalid JSON response from server');
    } catch (e) {
      throw Exception('Error fetching product: $e');
    }
  }
}
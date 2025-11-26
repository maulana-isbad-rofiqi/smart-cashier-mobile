import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import 'test_data_service.dart';

class ApiService {
  // Base URL: 'http://127.0.0.1:8000/api'
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  // Static method to fetch products - can be called as ApiService.fetchProducts()
  static Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Handle JSON decoding
        final Map<String, dynamic> responseData = json.decode(response.body);
        
        // Extract the products list from the response
        final List<dynamic> productsList = responseData['data'] ?? responseData['products'] ?? [];
        
        // Map to Product model and return the list
        final List<Product> products = productsList
            .map((json) => Product.fromJson(json))
            .toList();
        
        return products;
      } else {
        throw Exception('Failed to fetch products. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // If API fails, return test data
      print('API Error: $e');
      print('Using test data instead...');
      
      // Wait a bit to simulate API delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Return test data with placeholder images
      return TestDataService.getProductsWithPlaceholder();
    }
  }
}
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  // Create a Future<List<Product>> variable called _productsFuture
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    // In initState, initialize _productsFuture by calling ApiService.fetchProducts()
    _productsFuture = ApiService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    // In build method: Return a Scaffold with AppBar "Smart Cashier"
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Cashier'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      // Body should be a FutureBuilder
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          // - If connectionState is waiting: show CircularProgressIndicator (centered)
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // - If hasError: show error text
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _productsFuture = ApiService.fetchProducts();
                      });
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // - If hasData: show a GridView.builder (2 columns)
          if (snapshot.hasData) {
            final products = snapshot.data!;
            
            if (products.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.inventory_2_outlined,
                      size: 64,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No products available',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 columns as specified
                childAspectRatio: 0.75,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product name
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8.0),
                        
                        // Product price
                        Text(
                          'Price: ${product.price}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        
                        // Product stock
                        Text(
                          'Stock: ${product.stock}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                          ),
                        ),
                        
                        const Spacer(),
                        
                        // Optional: Show image if available
                        if (product.image != null) ...[
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              color: Colors.grey[200],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4.0),
                              child: Image.network(
                                product.image!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey,
                                  );
                                },
                              ),
                            ),
                          ),
                        ] else
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              color: Colors.grey[200],
                            ),
                            child: const Icon(
                              Icons.image_not_supported,
                              color: Colors.grey,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          // Fallback for any other state
          return const Center(
            child: Text('Something went wrong'),
          );
        },
      ),
    );
  }
}
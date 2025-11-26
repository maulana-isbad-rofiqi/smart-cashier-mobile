import '../models/product.dart';

class TestDataService {
  static List<Product> getSampleProducts() {
    return [
      Product(
        id: 1,
        name: 'Kopi Arabika Premium',
        price: '25000',
        stock: 50,
        image: 'https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=400&h=400&fit=crop',
      ),
      Product(
        id: 2,
        name: 'Teh Hijau Organik',
        price: '15000',
        stock: 30,
        image: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&h=400&fit=crop',
      ),
      Product(
        id: 3,
        name: 'Snack Keripik Singkong',
        price: '8000',
        stock: 100,
        image: 'https://images.unsplash.com/photo-1585238342020-96629c81756d?w=400&h=400&fit=crop',
      ),
      Product(
        id: 4,
        name: 'Minyak Kelapa Murni',
        price: '35000',
        stock: 25,
        image: 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=400&h=400&fit=crop',
      ),
      Product(
        id: 5,
        name: 'Gulaaren Organik',
        price: '28000',
        stock: 40,
        image: 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=400&h=400&fit=crop',
      ),
      Product(
        id: 6,
        name: 'Bumbu Instan Rendang',
        price: '12000',
        stock: 75,
        image: 'https://images.unsplash.com/photo-1563245372-f21724e3856d?w=400&h=400&fit=crop',
      ),
      Product(
        id: 7,
        name: 'Kecap ManisPremium',
        price: '18000',
        stock: 60,
        image: 'https://images.unsplash.com/photo-1568607689150-17e625c1586b?w=400&h=400&fit=crop',
      ),
      Product(
        id: 8,
        name: 'Beras Rojo Lele',
        price: '45000',
        stock: 80,
        image: 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=400&h=400&fit=crop',
      ),
    ];
  }
  
  // Fallback products with local placeholder
  static List<Product> getProductsWithPlaceholder() {
    final products = getSampleProducts();
    // Add some products without images to test placeholder
    products.addAll([
      Product(
        id: 9,
        name: 'Produk Lokal 1',
        price: '20000',
        stock: 20,
      ),
      Product(
        id: 10,
        name: 'Produk Lokal 2',
        price: '30000',
        stock: 35,
      ),
    ]);
    return products;
  }
}
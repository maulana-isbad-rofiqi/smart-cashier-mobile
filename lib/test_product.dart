import 'models/product.dart';

void main() {
  // Test creating a Product instance
  final product = Product(
    id: 1,
    name: 'Test Product',
    price: '10000',
    stock: 50,
    image: 'product_image.jpg',
  );
  
  print('Product instance: $product');
  
  // Test JSON serialization
  final jsonMap = product.toJson();
  print('JSON: $jsonMap');
  
  // Test JSON deserialization
  final parsedProduct = Product.fromJson(jsonMap);
  print('Parsed product: $parsedProduct');
  
  // Test with null image
  final productWithoutImage = Product(
    id: 2,
    name: 'Product without image',
    price: '20000',
    stock: 30,
  );
  
  print('Product without image: $productWithoutImage');
  
  // Test JSON parsing with null image
  final jsonWithoutImage = productWithoutImage.toJson();
  final parsedWithoutImage = Product.fromJson(jsonWithoutImage);
  print('Parsed without image: $parsedWithoutImage');
}
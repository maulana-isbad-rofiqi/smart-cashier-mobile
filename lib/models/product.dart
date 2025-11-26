class Product {
  // Fields
  final int id;
  final String name;
  final String price;
  final int stock;
  final String? image;

  // Getter for price as double
  double get priceAsDouble {
    return double.tryParse(price) ?? 0.0;
  }

  // Constructor
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    this.image,
  });

  // Factory method to parse JSON data safely
  factory Product.fromJson(Map<String, dynamic> json) {
    try {
      return Product(
        id: json['id'] as int,
        name: json['name'] as String,
        price: json['price'] as String,
        stock: json['stock'] as int,
        image: json['image'] as String?,
      );
    } catch (e) {
      throw FormatException('Invalid JSON data for Product: $e');
    }
  }

  // Convert Product to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'stock': stock,
      'image': image,
    };
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, stock: $stock, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.price == price &&
        other.stock == stock &&
        other.image == image;
  }

  @override
  int get hashCode {
    return Object.hash(id, name, price, stock, image);
  }
}
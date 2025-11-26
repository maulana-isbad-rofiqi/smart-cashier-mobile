import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartService extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  bool get isEmpty => _items.isEmpty;
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  double get totalAmount => _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  void addItem(Product product, {int quantity = 1}) {
    final existingIndex = _items.indexWhere((item) => item.product.id == product.id);
    
    if (existingIndex != -1) {
      _items[existingIndex].quantity += quantity;
    } else {
      _items.add(CartItem(product: product, quantity: quantity));
    }
    
    notifyListeners();
  }

  void removeItem(Product product) {
    _items.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  void updateQuantity(Product product, int quantity) {
    if (quantity <= 0) {
      removeItem(product);
      return;
    }

    final item = _items.firstWhere((item) => item.product.id == product.id);
    item.quantity = quantity;
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  bool containsProduct(Product product) {
    return _items.any((item) => item.product.id == product.id);
  }

  CartItem? getCartItem(Product product) {
    try {
      return _items.firstWhere((item) => item.product.id == product.id);
    } catch (e) {
      return null;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'items': _items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'itemCount': itemCount,
    };
  }

  static CartService fromJson(Map<String, dynamic> json, List<Product> allProducts) {
    final service = CartService();
    final itemsJson = json['items'] as List;
    
    for (final itemJson in itemsJson) {
      final cartItem = CartItem.fromJson(itemJson);
      // Find the corresponding product from allProducts to ensure we have the latest data
      final product = allProducts.firstWhere(
        (p) => p.id == cartItem.product.id,
        orElse: () => cartItem.product,
      );
      service._items.add(CartItem(product: product, quantity: cartItem.quantity));
    }
    
    return service;
  }
}
import 'package:flutter/material.dart';
import 'screens/product_list_screen.dart'; // Import screen yang baru dibuat

void main() {
  runApp(const SmartCashierApp());
}

class SmartCashierApp extends StatelessWidget {
  const SmartCashierApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Cashier',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // Panggil Screen Utama di sini
      home: const ProductListScreen(),
    );
  }
}
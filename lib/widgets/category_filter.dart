import 'package:flutter/material.dart';
import '../models/product.dart';

class CategoryFilter extends StatefulWidget {
  final List<String> categories;
  final Function(String?) onCategorySelected;
  final String? selectedCategory;

  const CategoryFilter({
    super.key,
    required this.categories,
    required this.onCategorySelected,
    this.selectedCategory,
  });

  @override
  State<CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          // All Categories Chip
          _buildCategoryChip(
            category: null,
            label: 'Semua',
            icon: Icons.grid_view,
          ),
          const SizedBox(width: 8),
          // Category Chips
          ...widget.categories.map((category) => _buildCategoryChip(
            category: category,
            label: category,
            icon: _getCategoryIcon(category),
          )),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _buildCategoryChip({
    required String? category,
    required String label,
    required IconData icon,
  }) {
    final isSelected = widget.selectedCategory == category;
    
    return GestureDetector(
      onTap: () => widget.onCategorySelected(category),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected 
              ? const Color(0xFF2196F3)
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected 
                ? const Color(0xFF2196F3)
                : Colors.grey[300]!,
            width: 1,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: const Color(0xFF2196F3).withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ] : [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected 
                  ? Colors.white
                  : const Color(0xFF2196F3),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected 
                    ? Colors.white
                    : const Color(0xFF1F2937),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'minuman':
      case 'beverage':
        return Icons.local_drink;
      case 'makanan':
      case 'food':
        return Icons.restaurant;
      case 'snack':
        return Icons.cookie;
      case 'bumbu':
      case 'spices':
        return Icons.science;
      case 'beras':
      case 'rice':
        return Icons.grass;
      case 'minyak':
      case 'oil':
        return Icons.water_drop;
      default:
        return Icons.category;
    }
  }
}

// Category mapping for products
extension ProductCategory on Product {
  String get category {
    final name = this.name.toLowerCase();
    if (name.contains('kopi') || name.contains('teh')) {
      return 'Minuman';
    } else if (name.contains('snack') || name.contains('keripik')) {
      return 'Snack';
    } else if (name.contains('bumbu') || name.contains('kecap')) {
      return 'Bumbu';
    } else if (name.contains('beras')) {
      return 'Beras';
    } else if (name.contains('minyak') || name.contains('kelapa')) {
      return 'Minyak';
    } else if (name.contains('gula')) {
      return 'Gula';
    }
    return 'Lainnya';
  }
}
import 'package:flutter/material.dart';
import '../widgets/product_card.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../models/product.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final String categoryName;

  const CategoryDetailsScreen({super.key, required this.categoryName});

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  final ApiService _apiService = ApiService();
  final StorageService _storageService = StorageService();
  late Future<List<Product>> _categoryProductsFuture;

  @override
  void initState() {
    super.initState();
    _categoryProductsFuture = _fetchCategoryWithOfflineSupport();
  }

  Future<List<Product>> _fetchCategoryWithOfflineSupport() async {
    final cacheSuffix = '_${widget.categoryName.replaceAll(' ', '_')}';
    try {
      // Fix: Ensure we use 'category' instead of 'query' to match ApiService.fetchProducts
      final products = await _apiService.fetchProducts(
        category: widget.categoryName,
      );
      await _storageService.saveProductsCache(products, suffix: cacheSuffix);
      return products;
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('يتم عرض البيانات المحفوظة للقسم'),
            backgroundColor: Theme.of(
              context,
            ).colorScheme.primary.withValues(alpha: 0.85),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
      return await _storageService.loadProductsCache(suffix: cacheSuffix);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryName.toUpperCase())),
      body: FutureBuilder<List<Product>>(
        future: _categoryProductsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('خطأ: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.book_outlined, size: 80, color: Colors.grey[800]),
                  const SizedBox(height: 16),
                  Text(
                    'لا توجد بيانات محفوظة في ${widget.categoryName}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          final filteredBooks = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
            ),
            itemCount: filteredBooks.length,
            itemBuilder: (context, index) {
              return ProductCard(product: filteredBooks[index]);
            },
          );
        },
      ),
    );
  }
}

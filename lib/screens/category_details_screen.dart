import 'package:flutter/material.dart';
import '../widgets/product_card.dart';
import '../constants/mock_data.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final String categoryName;

  const CategoryDetailsScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final filteredBooks = MockData.mockBooks
        .where((book) => book.category.toLowerCase() == categoryName.toLowerCase())
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName.toUpperCase()),
      ),
      body: filteredBooks.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.book_outlined, size: 80, color: Colors.grey[800]),
                  const SizedBox(height: 16),
                  Text('No books found in $categoryName', style: const TextStyle(color: Colors.grey)),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
              ),
              itemCount: filteredBooks.length,
              itemBuilder: (context, index) {
                return ProductCard(product: filteredBooks[index]);
              },
            ),
    );
  }
}

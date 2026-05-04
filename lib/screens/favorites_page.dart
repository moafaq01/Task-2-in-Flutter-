import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task2/providers/library_provider.dart';
import 'package:animate_do/animate_do.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LibraryProvider>(context);
    final favorites = provider.favorites;

    return Scaffold(
      appBar: AppBar(title: const Text('My Wishlist')),
      body: favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 80, color: Colors.white.withOpacity(0.2)),
                  const SizedBox(height: 20),
                  const Text('No favorites yet', style: TextStyle(fontSize: 20, color: Colors.grey)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final book = favorites[index];
                return FadeInRight(
                  delay: Duration(milliseconds: index * 100),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(book.imageUrl, width: 80, height: 100, fit: BoxFit.cover),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(book.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                              Text(book.author, style: TextStyle(color: Colors.white.withOpacity(0.6))),
                              const SizedBox(height: 10),
                              Text('\$${book.price}', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFE94560))),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => provider.toggleFavorite(book.id),
                          icon: const Icon(Icons.favorite, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

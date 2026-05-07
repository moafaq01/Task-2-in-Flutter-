import 'package:flutter/material.dart';
import '../models/product.dart';

class FavoritesProvider with ChangeNotifier {
  final List<Product> _favoriteProducts = [];

  List<Product> get favoriteProducts => [..._favoriteProducts];

  bool isFavorite(String productId) {
    return _favoriteProducts.any((p) => p.id == productId);
  }

  void toggleFavorite(Product product) {
    final index = _favoriteProducts.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _favoriteProducts.removeAt(index);
    } else {
      _favoriteProducts.add(product);
    }
    notifyListeners();
  }
}

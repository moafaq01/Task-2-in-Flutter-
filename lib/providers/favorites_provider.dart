import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../services/storage_service.dart';

/// يدير قائمة المفضلة ويتكامل مع [StorageService] للحفظ والاستعادة
class FavoritesProvider with ChangeNotifier {
  final StorageService _storage = StorageService();

  List<Product> _favoriteProducts = [];

  List<Product> get favoriteProducts => [..._favoriteProducts];

  bool isFavorite(String productId) =>
      _favoriteProducts.any((p) => p.id == productId);

  // ─── Actions ──────────────────────────────────────────────────

  /// تبديل حالة المفضلة لمنتج معين، ثم حفظها محلياً
  Future<void> toggleFavorite(Product product) async {
    final index = _favoriteProducts.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _favoriteProducts.removeAt(index);
    } else {
      _favoriteProducts.add(product);
    }
    notifyListeners();
    await _storage.saveFavorites(_favoriteProducts);
  }

  // ─── Persistence ──────────────────────────────────────────────

  /// تحميل المفضلة من الملف المحلي (يُستدعى من main قبل تشغيل التطبيق)
  Future<void> loadFromStorage(StorageService storage) async {
    _favoriteProducts = await storage.loadFavorites();
    notifyListeners();
  }

  /// تحميل قائمة جاهزة (يُستدعى من HomeScreen بعد تحميل البيانات)
  void loadFavoritesList(List<Product> loadedFavorites) {
    _favoriteProducts = loadedFavorites;
    notifyListeners();
  }
}

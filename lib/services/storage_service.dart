import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import '../models/product.dart';

/// مسؤول عن جميع عمليات القراءة والكتابة على الملفات المحلية باستخدام path_provider
class StorageService {
  Future<File> _getFile(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$fileName');
  }

  // ─── Cache ───────────────────────────────────────────────────

  /// حفظ قائمة المنتجات في الـ Cache
  Future<void> saveProductsCache(List<Product> products, {String suffix = ''}) async {
    try {
      final file = await _getFile('products_cache$suffix.json');
      final data = products.map((p) => p.toJson()).toList();
      await file.writeAsString(jsonEncode(data));
    } catch (e) {
      debugPrint('StorageService: خطأ في حفظ الـ Cache: $e');
    }
  }

  /// استعادة قائمة المنتجات من الـ Cache
  Future<List<Product>> loadProductsCache({String suffix = ''}) async {
    try {
      final file = await _getFile('products_cache$suffix.json');
      if (await file.exists()) {
        final String content = await file.readAsString();
        final List<dynamic> jsonData = jsonDecode(content);
        return jsonData.map((json) => Product.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('StorageService: خطأ في قراءة الـ Cache: $e');
      return [];
    }
  }

  // ─── Favorites ────────────────────────────────────────────────

  /// حفظ قائمة المفضلة
  Future<void> saveFavorites(List<Product> favorites) async {
    try {
      final file = await _getFile('favorites.json');
      final data = favorites.map((p) => p.toJson()).toList();
      await file.writeAsString(jsonEncode(data));
    } catch (e) {
      debugPrint('StorageService: خطأ في حفظ المفضلة: $e');
    }
  }

  /// تحميل قائمة المفضلة
  Future<List<Product>> loadFavorites() async {
    try {
      final file = await _getFile('favorites.json');
      if (await file.exists()) {
        final String content = await file.readAsString();
        final List<dynamic> jsonData = jsonDecode(content);
        return jsonData.map((json) => Product.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('StorageService: خطأ في قراءة المفضلة: $e');
      return [];
    }
  }

  // ─── Cart ─────────────────────────────────────────────────────

  /// حفظ محتوى السلة
  Future<void> saveCart(List<Map<String, dynamic>> cartItems) async {
    try {
      final file = await _getFile('cart.json');
      await file.writeAsString(jsonEncode(cartItems));
    } catch (e) {
      debugPrint('StorageService: خطأ في حفظ السلة: $e');
    }
  }

  /// تحميل محتوى السلة
  Future<List<Map<String, dynamic>>> loadCart() async {
    try {
      final file = await _getFile('cart.json');
      if (await file.exists()) {
        final String content = await file.readAsString();
        final List<dynamic> jsonData = jsonDecode(content);
        return jsonData.cast<Map<String, dynamic>>();
      }
      return [];
    } catch (e) {
      debugPrint('StorageService: خطأ في قراءة السلة: $e');
      return [];
    }
  }
}

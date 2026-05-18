import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../services/storage_service.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

/// يدير سلة التسوق ويحفظها تلقائياً عند كل تعديل
class CartProvider with ChangeNotifier {
  final StorageService _storage = StorageService();

  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};
  int get itemCount => _items.length;

  double get totalAmount {
    var total = 0.0;
    _items.forEach((_, cartItem) {
      total += cartItem.product.price * cartItem.quantity;
    });
    return total;
  }

  // ─── Actions ──────────────────────────────────────────────────

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existing) => CartItem(product: existing.product, quantity: existing.quantity + 1),
      );
    } else {
      _items.putIfAbsent(product.id, () => CartItem(product: product));
    }
    notifyListeners();
    _save();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) return;
    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (existing) => CartItem(product: existing.product, quantity: existing.quantity - 1),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
    _save();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
    _save();
  }

  void clear() {
    _items.clear();
    notifyListeners();
    _save();
  }

  // ─── Persistence ──────────────────────────────────────────────

  /// استدعاء هذه الدالة مرة واحدة عند بدء التطبيق
  Future<void> loadFromStorage() async {
    final savedItems = await _storage.loadCart();
    for (final entry in savedItems) {
      final product = Product.fromJson(entry['product'] as Map<String, dynamic>);
      final quantity = (entry['quantity'] as num).toInt();
      _items[product.id] = CartItem(product: product, quantity: quantity);
    }
    notifyListeners();
  }

  Future<void> _save() async {
    final cartList = _items.values.map((item) => {
      'product': item.product.toJson(),
      'quantity': item.quantity,
    }).toList();
    await _storage.saveCart(cartList);
  }
}

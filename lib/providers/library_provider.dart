import 'package:flutter/material.dart';
import 'package:task2/models/book.dart';
import 'package:task2/models/cart_item.dart';

class LibraryProvider with ChangeNotifier {
  final List<Book> _books = [
    Book(
      id: '1',
      title: 'The Great Gatsby',
      author: 'F. Scott Fitzgerald',
      price: 25.00,
      imageUrl: 'https://m.media-amazon.com/images/I/71FTb9X6djL._AC_UF1000,1000_QL80_.jpg',
      category: 'Classics',
      description: 'A novel that depicts the roaring twenties...',
      rating: 4.5,
    ),
    Book(
      id: '2',
      title: 'Atomic Habits',
      author: 'James Clear',
      price: 18.99,
      imageUrl: 'https://m.media-amazon.com/images/I/81bgE7F74ML._AC_UF1000,1000_QL80_.jpg',
      category: 'Self-Help',
      description: 'An easy & proven way to build good habits & break bad ones.',
      rating: 4.9,
    ),
    Book(
      id: '3',
      title: 'The Alchemist',
      author: 'Paulo Coelho',
      price: 15.50,
      imageUrl: 'https://m.media-amazon.com/images/I/51Z0nLAfLmL.jpg',
      category: 'Adventure',
      description: 'A global phenomenon, The Alchemist has been read and loved by over sixty-two million readers.',
      rating: 4.7,
    ),
    Book(
      id: '4',
      title: 'Dune',
      author: 'Frank Herbert',
      price: 22.00,
      imageUrl: 'https://m.media-amazon.com/images/I/81E6kL45sBL._AC_UF1000,1000_QL80_.jpg',
      category: 'Sci-Fi',
      description: 'Set on the desert planet Arrakis, Dune is the story of the boy Paul Atreides...',
      rating: 4.8,
    ),
    Book(
      id: '5',
      title: 'The Psychology of Money',
      author: 'Morgan Housel',
      price: 19.99,
      imageUrl: 'https://m.media-amazon.com/images/I/71TRu76z70L._AC_UF1000,1000_QL80_.jpg',
      category: 'Finance',
      description: 'Timeless lessons on wealth, greed, and happiness.',
      rating: 4.9,
    ),
    Book(
      id: '6',
      title: 'Deep Work',
      author: 'Cal Newport',
      price: 17.50,
      imageUrl: 'https://m.media-amazon.com/images/I/417S8-U0s1L.jpg',
      category: 'Business',
      description: 'Rules for focused success in a distracted world.',
      rating: 4.6,
    ),
  ];

  final List<String> _favoriteIds = [];
  final List<CartItem> _cart = [];

  List<Book> get books => [..._books];
  List<Book> get favorites => _books.where((book) => _favoriteIds.contains(book.id)).toList();
  List<CartItem> get cart => [..._cart];

  double get cartTotal {
    return _cart.fold(0, (sum, item) => sum + (item.book.price * item.quantity));
  }

  int get cartCount {
    return _cart.fold(0, (sum, item) => sum + item.quantity);
  }

  bool isFavorite(String id) => _favoriteIds.contains(id);

  void toggleFavorite(String id) {
    if (_favoriteIds.contains(id)) {
      _favoriteIds.remove(id);
    } else {
      _favoriteIds.add(id);
    }
    notifyListeners();
  }

  void addToCart(Book book) {
    final index = _cart.indexWhere((item) => item.book.id == book.id);
    if (index >= 0) {
      _cart[index].quantity++;
    } else {
      _cart.add(CartItem(book: book));
    }
    notifyListeners();
  }

  void removeFromCart(String id) {
    _cart.removeWhere((item) => item.book.id == id);
    notifyListeners();
  }

  void updateQuantity(String id, int delta) {
    final index = _cart.indexWhere((item) => item.book.id == id);
    if (index >= 0) {
      _cart[index].quantity += delta;
      if (_cart[index].quantity <= 0) {
        _cart.removeAt(index);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}

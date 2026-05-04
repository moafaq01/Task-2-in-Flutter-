import 'package:task2/models/book.dart';

class CartItem {
  final Book book;
  int quantity;

  CartItem({
    required this.book,
    this.quantity = 1,
  });
}

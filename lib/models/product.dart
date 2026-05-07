class Product {
  final String id;
  final String title;
  final String author;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final double rating;

  Product({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.rating = 4.5,
  });

  // Getter for backward compatibility if needed, though we'll update UI
  String get name => title;
}

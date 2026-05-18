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

  factory Product.fromJson(Map<String, dynamic> json) {
    // Handle both Google Books API format and Fake Store API format
    final ratingData = json['rating'];
    double parsedRating = 4.5;
    if (ratingData is num) {
      parsedRating = ratingData.toDouble();
    } else if (ratingData is Map) {
      parsedRating = (ratingData['rate'] ?? 4.5).toDouble();
    }

    return Product(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? 'Unknown Title',
      author: json['author'] ?? json['category']?.toString().toUpperCase() ?? 'Fake Store Product',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      imageUrl: json['image'] ?? json['imageUrl'] ?? 'https://via.placeholder.com/150',
      category: json['category'] ?? 'General',
      rating: parsedRating,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'rating': rating,
    };
  }

  // Getter for backward compatibility if needed, though we'll update UI
  String get name => title;
}

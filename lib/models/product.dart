import 'dart:convert';

import 'package:eat_easy/models/review.dart';

class Product {
  final String id;
  final String title, description;
  final List<String> images;
  final List<String> colors;
  int price;
  int? quantity;
  final double rating;
  bool isFavourite, isPopular;
  final List<String> categories;
  final List<Review> reviews;

  Product({
    this.categories = const [],
    required this.id,
    required this.images,
    this.colors = const ["#000000"],
    this.reviews = const [],
    this.rating = 0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    this.quantity,
    this.description = 'Default Description string lorem34',
  });

  static Product fromSnapshot(productData) {
    return Product(
      id: productData.id,
      images: productData['images'],
      title: productData['title'],
      price: productData['price'],
      quantity: productData['quantity'],
      description: productData['description'],
      rating: productData['rating'],
      isFavourite: productData['isFavourite'],
      categories: productData['categories'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'images': images,
      'price': price,
      'quantity': quantity,
      'categories': categories,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      categories: List<String>.from(map['categories'] ?? []),
      id: map['id'] as String? ?? '',
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      images: List<String>.from(map['images'] ?? []),
      price: map['price'] ?? 0,
      quantity: map['quantity'] ?? 0,
      rating: map['rating'] ?? 0,
      isFavourite: map['isFavourite'] as bool? ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}

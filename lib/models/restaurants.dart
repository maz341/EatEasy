import 'dart:convert';
import 'package:eat_easy/models/review.dart';

class Restaurant {
  final String id;
  final String name, description, address;
  final List<String> images;
  final double rating;
  final List<Review> reviews;

  Restaurant({
    required this.id,
    required this.images,
    this.reviews = const [],
    this.rating = 0,
    required this.name,
    this.description = 'Some description here',
    this.address = 'Some address here',
  });

  static Restaurant fromSnapshot(restaurantData) {
    return Restaurant(
      id: restaurantData.id,
      images: restaurantData['images'],
      name: restaurantData['name'],
      description: restaurantData['description'],
      address: restaurantData['address'],
      rating: restaurantData['rating'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'description': description,
      'images': images,
      'rating': rating,
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      description: map['description'] as String? ?? '',
      address: map['address'] as String? ?? '',
      images: List<String>.from(map['images'] ?? []),
      rating: map['rating'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Restaurant.fromJson(String source) =>
      Restaurant.fromMap(json.decode(source));
}

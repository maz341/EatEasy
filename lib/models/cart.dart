import 'dart:convert';
import 'package:eat_easy/models/product.dart';

class Cart {
  final int id;

  final Product products;
   int quantity;

  Cart({
    required this.id,

    required this.products,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {

      'products': products.toMap(),
      // List<dynamic>.from(products.map((product) => product.toMap())),
      'quantity': quantity,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'],

      products: Product.fromMap(
          map['products'].map((product) => Product.fromMap(product))),
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));
}

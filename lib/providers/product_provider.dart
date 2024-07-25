import 'package:flutter/material.dart';
import '../models/models.dart' as models;

class ProductProvider with ChangeNotifier {
  final List<models.Product> _products = [];
  List<models.Product> get products => _products;

  models.Product? _product;
  models.Product? get product => _product;

  String _id = '';
  String get id => _id;

  int _quantity = 1;
  int get quantity => _quantity;

  int _totalPrice = 0;
  int get totalPrice => _totalPrice;

  int get totalAmount => _product?.price ?? 0 * _quantity;

  void setProduct(models.Product product) {
    _product = product;
    _id = product.id;
    _quantity = 1;
    _totalPrice = _product?.price ?? 0;
    notifyListeners();
  }

  void increaseQuantity() {
    _quantity++;
    updateTotalPrice();
  }

  void decreaseQuantity() {
    if (_quantity > 1) {
      _quantity--;
      updateTotalPrice();
    }
  }

  void updateTotalPrice() {
    if (_quantity > 0 && _product != null) {
      _totalPrice = _product!.price * _quantity;
    }
    notifyListeners();
  }
}

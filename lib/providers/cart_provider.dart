import 'dart:convert';
import 'dart:developer';
import 'package:eat_easy/models/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:eat_easy/models/models.dart' as models;

class CartProvider with ChangeNotifier {
  final List<models.Cart> _cartItems = [];
  List<models.Cart> get cartItems => _cartItems;

  models.Product? _cartItem;
  models.Product? get product => _cartItem;

  // int _quantity = 1;
  // int get quantity => _quantity;

  final double _totalPrice = 0;
  double get totalPrice => _totalPrice;

  void increaseQuantity(models.Cart cart) async {
    // _quantity++;
    cart.quantity++;
    notifyListeners();
  }

  void decreaseQuantity(models.Cart cart) async {
    if (cart.quantity > 1) {
      // _quantity--;
      cart.quantity--;
      notifyListeners();
    }
  }

  Future<int> cartItemQuantity(models.Cart cart) async {
    return cart.quantity;
  }

  void clearCartItems() {
    _cartItems.clear();
  }

  Future<void> addToCart(models.Cart cart, int quantity) async {
    // Check if the product already exists in the cart
    final existingProductIndex =
        _cartItems.indexWhere((item) => item.products.id == cart.products.id);

    debugPrint("cart.products.quantity ${cart.quantity}");

    if (existingProductIndex != -1) {
      _cartItems.removeAt(existingProductIndex);
    } else {
      _cartItems.add(cart);
    }

    notifyListeners();
  }

  Future<void> addToCartFromDetails(models.Product productsData) async {
    try {
      final existingProductIndex =
          _cartItems.indexWhere((item) => item.products.id == productsData.id);

      debugPrint("product Data asas ${jsonEncode(productsData)}");

      if (existingProductIndex != -1) {
        _cartItems.removeAt(existingProductIndex);
      }
      final cartModelTemp = Cart(
        id: 12,
        products: productsData,
        quantity: productsData.quantity ?? 0,
      );
      _cartItems.add(cartModelTemp);
    } catch (e) {
      log(e.toString());
    }

    notifyListeners();
  }

  Future<void> removeFromCart(models.Cart cart) async {
    // Remove the product from the _cartItems list
    _cartItems.removeWhere((item) => item.products.id == cart.products.id);

    notifyListeners();
  }

  Future<List<models.Cart>> getCartItems() async {
    debugPrint("getCartItems After ${_cartItems.length}");

    return _cartItems;
  }

  bool isItemInCart(models.Cart cart) {
    bool isExist =
        _cartItems.any((item) => item.products.id == cart.products.id);

    return isExist;
  }

  Future<double> totalPriceFunc() async {
    double total = 0;
    late int quantity;
    for (var element in _cartItems) {
      quantity = await cartItemQuantity(element);

      total += (element.products.price * quantity);
    }
    return total;
  }
}

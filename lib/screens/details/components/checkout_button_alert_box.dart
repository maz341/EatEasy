// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:eat_easy/models/order.dart';
import 'package:eat_easy/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../../providers/address_provider.dart';
import '../../../providers/providers.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';
import '../../cart/cart_screen.dart';
import '../../home/home_screen.dart';
import 'components.dart';

class CheckoutButtonAlertBox extends StatelessWidget {
  const CheckoutButtonAlertBox({
    Key? key,
    required this.widget,
    required this.width,
    required this.price,
    required this.quantity,
    required this.productId,
    required this.productImage,
  }) : super(key: key);

  final double width;
  final String price;
  final String productId;
  final String productImage;
  final AfterBuyNowButtonSheet widget;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Column(
          children: [
            // * continue shopping button
            Container(
              width: double.infinity,
              height: getProportionateScreenHeight(50),
              margin: const EdgeInsets.only(top: 45, left: 15, right: 15),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                height: getProportionateScreenWidth(65),
                width: getProportionateScreenWidth(width),
                padding: EdgeInsets.only(
                  bottom: getProportionateScreenHeight(2),
                  top: getProportionateScreenHeight(2),
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextButton(
                  child: const Text(
                    "Continue Shopping",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                ),
              ),
            ),

            // * checkout button
            Container(
              width: double.infinity,
              height: getProportionateScreenHeight(50),
              margin: const EdgeInsets.only(
                  top: 15, left: 15, right: 15, bottom: 25),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                height: getProportionateScreenWidth(65),
                width: getProportionateScreenWidth(width),
                padding: EdgeInsets.only(
                  bottom: getProportionateScreenHeight(2),
                  top: getProportionateScreenHeight(2),
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextButton(
                  child: const Text(
                    "Checkout",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () async {
                    await showPaymentDialog(
                        context, productId, productImage, quantity);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> showPaymentDialog(BuildContext context, String productId,
      String productImage, int quantity) async {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    OrderProvider orderProvider =
        Provider.of<OrderProvider>(context, listen: false);
    AddressProvider addressProvider =
        Provider.of<AddressProvider>(context, listen: false);

    bool success = false;
    String orderStatus = 'Processing';

    String? orderId;

    String generateOrderId() {
      const uuid = Uuid();
      return uuid.v4();
    }

    orderId = generateOrderId();

    log('---------------');
    log('PRODUCT_ID = $productId');
    log('---------------');
    log('PRODUCT_IMAGE = $productImage');
    log('---------------');
    log('PRICE = ${price.toString()}');
    log('---------------');
    log('---------------');
    log('QUANTITY = ${quantity.toString()}');
    log('---------------');
    log('ORDER STATUS = $orderStatus');
    log('---------------');
    log('ORDER ID = $orderId');
    log('---------------');

    Order ordermodel = Order(
      orderId: orderId,
      address:
          '${addressProvider.selectedAddress.address} ${addressProvider.selectedAddress.postalCode}',
      orderedDate: DateTime.now().toString(),
      orderStatus: orderStatus,
      amount: double.parse(price),
      // productId: generateOrderId().substring(0, 8),
      productImage: productImage,
      quantity: quantity,
      orderProducts: "",
    );

    // final orderData = {
    //   'orderId': orderId,
    //   'number': addressProvider.selectedAddress.phone,
    //   'address': addressProvider.selectedAddress.address +
    //       addressProvider.selectedAddress.pincode,
    //   'orderedDate': DateTime.now().toString(),
    //   'productId': productId,
    //   'amount': double.parse(price),
    //   'productImage': productImage,
    //   'quantity': quantity,
    //   'orderStatus': orderStatus,
    // };

    final productData = {
      'id': productId,
      'categories': widget.widget.product.categories,
      'title': widget.widget.product.title,
      'description': widget.widget.product.description,
      'images': widget.widget.product.images,
      'price': int.parse(price),
      'rating': widget.widget.product.rating,
      'isFavourite': widget.widget.product.isFavourite,
      'quantity': quantity,
    };

    try {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Center(
              child: Text(
                'Checkout With',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () async {
                    try {
                      await orderProvider
                          .addOrder(order: ordermodel)
                          .then((value) {
                        success = true;
                        orderId = value;
                      });

                      success = true;
                    } catch (error) {
                      log('---------------');
                      log(error.toString());
                      log('---------------');
                      success = false;
                    } finally {
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: getProportionateScreenHeight(50),
                    margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Cash on Delixvery',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.snackbar(
                      'Under Development ℹ',
                      'Feature is Under Development!',
                      backgroundColor: kPrimaryColor,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: getProportionateScreenHeight(50),
                    margin: const EdgeInsets.only(
                      top: 15,
                      left: 15,
                      right: 15,
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Online Payment',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    cartProvider
                        .addToCartFromDetails(Product.fromMap(productData));

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const CartScreen()),
                        (Route<dynamic> route) => route is HomeScreen);
                  },
                  child: Container(
                    width: double.infinity,
                    height: getProportionateScreenHeight(50),
                    margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Go to Cart',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: getProportionateScreenHeight(50),
                    margin: const EdgeInsets.only(
                      top: 15,
                      left: 15,
                      right: 15,
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    } catch (e) {
      success = false;
      log('Error occurred while adding the order: $e');
    }

    if (success) {
      Get.snackbar(
        'Success',
        'Order added successfully! 🎉',
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (route) => false, // Remove all existing routes from the stack
      );
      log('---------------');
      log('PRICE = ${price.toString()}');
      log('---------------');
      log('QUANTITY = ${quantity.toString()}');
      log('---------------');
      log('ORDER STATUS = $orderStatus');
      log('---------------');
      log('ORDER ID = $orderId');
      log('---------------');
    } else {
      Get.snackbar(
        'Error',
        'Failed to add order. Please try again! 😕',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
    }
  }
}

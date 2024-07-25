import 'dart:developer';
import 'package:eat_easy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:eat_easy/utils/constants.dart';
import '../../../components/default_button.dart';
import '../../../models/models.dart';
import '../../../providers/address_provider.dart';
import '../../../providers/providers.dart';
import '../../../utils/size_config.dart';
import '../../details/address/delivery_addresses_list_screen.dart';
import '../../home/home_screen.dart';
import '../../loading/shimmer_box.dart';

class CheckoutCard extends StatelessWidget {
  const CheckoutCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    final OrderProvider orderProvider =
        Provider.of<OrderProvider>(context, listen: false);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      decoration: BoxDecoration(
        color: kPrimaryLight,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(getProportionateScreenWidth(10)),
          topRight: Radius.circular(getProportionateScreenWidth(10)),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Get.to(() => DeliveryAddressesListScreen()),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Text(
                      "Delivery Address:",
                      style: TextStyle(
                        fontSize: 12,
                        color: kSecondaryColor,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      context
                              .watch<AddressProvider>()
                              .selectedAddress
                              .address
                              .isEmpty
                          ? "No Address Selected"
                          : context
                              .watch<AddressProvider>()
                              .selectedAddress
                              .address,
                      //  addressProvider.selectedAddress.address,
                      style: const TextStyle(
                        fontSize: 12,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Consumer<CartProvider>(
              builder: (context, cartProvider, _) {
                return FutureBuilder<double>(
                    future: cartProvider.totalPriceFunc(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Loading state code

                        return Center(
                          child: SizedBox(
                            height: getProportionateScreenHeight(120),
                            width: MediaQuery.of(context).size.width * .9,
                            child: ShimmerBox(
                              child: SizedBox(
                                height: getProportionateScreenHeight(100),
                                width: getProportionateScreenWidth(100),
                              ),
                            ),
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        // Error state code
                        return const Center(
                            child: Text('Error fetching quantity'));
                      }

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: getProportionateScreenWidth(90),
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Total:",
                                ),
                                Text(
                                  "\$ ${snapshot.data ?? 0.0}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(190),
                            child: DefaultButton(
                                btnColor: kPrimaryColor,
                                txtColor: Colors.white,
                                text: "Place Order",
                                press: () => cartProvider.cartItems.isNotEmpty
                                    ? addressProvider
                                            .selectedAddress.addressId.isEmpty
                                        ? Get.snackbar(
                                            'No delivery address!',
                                            'Please select the delivery address first! ❗⚠',
                                            backgroundColor: Colors.red,
                                            snackPosition: SnackPosition.BOTTOM,
                                            colorText: Colors.white,
                                          )
                                        : showPaymentDialog(
                                            context,
                                            orderProvider,
                                            cartProvider,
                                          )
                                    : Get.snackbar(
                                        'Cart Empty!',
                                        'No Items in cart! ❗⚠',
                                        backgroundColor: Colors.red,
                                        snackPosition: SnackPosition.BOTTOM,
                                        colorText: Colors.white,
                                      )),
                          ),
                        ],
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showPaymentDialog(
    BuildContext context,
    OrderProvider orderProvider,
    CartProvider cartProvider,
  ) async {
    bool success = false;
    String orderStatus = 'Processing';

    String orderId = generateStaticId();

    AddressProvider addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    List<Cart> cartItems = cartProvider.cartItems;

    double totalPrice = 0.0;
    List<Map<String, dynamic>> orderItems = [];

    // Create order items and calculate total price
    for (int i = 0; i < cartItems.length; i++) {
      String productId = cartItems[i].products.id;
      String productImage = cartItems[i].products.images.first;
      int quantity = cartItems[i].quantity;
      double price = double.parse(cartItems[i].products.price.toString());
      totalPrice += price * quantity;

      Map<String, dynamic> orderItem = {
        'productId': productId,
        'productImage': productImage,
        'quantity': quantity,
        'price': price,
      };

      orderItems.add(orderItem);
    }


    Order order = Order(
      orderId: orderId,
      address:
          '${addressProvider.selectedAddress.address} ${addressProvider.selectedAddress.postalCode}',
      orderedDate: DateTime.now().toString(),
      orderStatus: orderStatus,
      amount: totalPrice,
      // productId: generateOrderId().substring(0, 8),
      productImage:
          cartItems.isNotEmpty ? cartItems.first.products.images.first : '',
      quantity: cartItems.length,
      orderProducts: "",
    );

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
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () async {
                    try {
                      log('---------------');
                      log("ordermodel ${order.toJson()}");
                      log('---------------');

                      log("x ordermodel ${order.amount}");

                      await orderProvider.addOrder(order: order);

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
                        'Cash on Delivery',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontSize: 14,
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
                      'Feature is Under Development! ',
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
                                  fontSize: 14,
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
                    margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontSize: 14,
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
      cartProvider.clearCartItems();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => false);
    } else {
      Get.snackbar(
        'Error',
        'Failed to add order! ❗⚠',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
    }
  }
}

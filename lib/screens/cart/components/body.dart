import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:eat_easy/models/models.dart' as models;
import 'package:eat_easy/providers/providers.dart';
import 'package:eat_easy/screens/cart/components/cart_card.dart';
import 'package:eat_easy/utils/size_config.dart';
import '../../loading/shimmer_box.dart';
class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          left: getProportionateScreenWidth(20),
          right: getProportionateScreenWidth(20),
          top: getProportionateScreenHeight(20),
          bottom: getProportionateScreenHeight(20),
        ),
        child:  Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return FutureBuilder<List<models.Cart>>(
            future: cartProvider.getCartItems(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView.separated(
                    itemCount: 5,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: getProportionateScreenHeight(15));
                    },
                    itemBuilder: (context, index) {
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
                    });
              }

              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }

              List<models.Cart> cartItems = snapshot.data ?? [];

              if (cartItems.isEmpty) {
                return const Center(child: Text('Your cart is empty'));
              }

              return ListView.separated(
                itemCount: cartItems.length,
                separatorBuilder: (context, index) {
                  return SizedBox(height: getProportionateScreenHeight(15));
                },
                itemBuilder: (context, index) {
                  final cartItem = cartItems[index];
                  return Dismissible(
                    key: Key(cartItem.id.toString()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) async {
                      await cartProvider.removeFromCart(cartItem);
                      setState(() {
                        cartItems.removeWhere((item) =>
                            item.products.title == cartItem.products.title);
                      });
                      const GetSnackBar(
                        title: 'Item removed from cart',
                        message: 'Item removed from cart',
                      );
                    },
                    background: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFE6E6),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Spacer(),
                          SvgPicture.asset("assets/icons/Trash.svg"),
                        ],
                      ),
                    ),
                    child: CartCard(
                      quantity: cartItem.quantity,
                      cart: cartItem,
                      onDecrease: () => cartProvider.decreaseQuantity(cartItem),
                      onIncrease: () => cartProvider.increaseQuantity(cartItem),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

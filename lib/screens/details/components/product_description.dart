import 'dart:developer';
import 'package:eat_easy/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:eat_easy/providers/cart_provider.dart';
import 'package:eat_easy/screens/details/components/product_details_sheet.dart';
import '../../../utils/size_config.dart';
import '../address/delivery_address_sheet.dart';

class FoodDescription extends StatefulWidget {
  const FoodDescription({
    Key? key,
    required this.product,
    required this.pressOnSeeMore,
    this.isFav,
  }) : super(key: key);

  final Product product;
  final GestureTapCallback pressOnSeeMore;
  final bool? isFav;

  @override
  State<FoodDescription> createState() => _FoodDescriptionState();
}

class _FoodDescriptionState extends State<FoodDescription>
    with SingleTickerProviderStateMixin {
  late AnimationController bottomSheetAnimationController;
  bool isCartButtonActive = false;

  @override
  void initState() {
    super.initState();

    bottomSheetAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bottomSheetAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: getProportionateScreenWidth(20),
              left: getProportionateScreenWidth(20),
              bottom: getProportionateScreenHeight(15),
            ),
            child: Text(
              widget.product.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/Star Icon.svg",
                            height: getProportionateScreenHeight(14),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.product.rating.toString(),
                            style: TextStyle(
                              fontSize: getProportionateScreenHeight(14),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      ' ( ${widget.product.reviews.length} Reviews )',
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(12),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      widget.product.isFavourite = !widget.product.isFavourite;
                    });

                    Cart myCart =
                        Cart(id: 1, products: widget.product, quantity: 1);
                    log("isCartButtonActive $isCartButtonActive");

                    if (isCartButtonActive) {
                      await cartProvider.removeFromCart(myCart);
                      setState(() {
                        isCartButtonActive = false;
                        widget.product.isFavourite = false;
                      });
                      log('BEFORE Removed from cart, marked inactive');
                    } else {
                      // Check if item already exists in cart
                      bool itemExists = cartProvider.isItemInCart(myCart);

                      if (itemExists) {
                        log('It already exist');

                        await cartProvider.removeFromCart(myCart);
                        setState(() {
                          isCartButtonActive = false;
                          widget.product.isFavourite = false;
                        });
                        log('Removed from cart, marked inactive');
                      } else {
                        await cartProvider.addToCart(myCart, 1);
                        setState(() {
                          isCartButtonActive = true;
                          widget.product.isFavourite = true;
                        });
                        log('Added to cart, marked active');
                      }
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                    width: getProportionateScreenWidth(64),
                    decoration: BoxDecoration(
                      color: widget.product.isFavourite
                          ? const Color(0xFFFFE6E6)
                          : const Color(0xFFF5F6F9),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/Cart Icon.svg",
                      colorFilter: ColorFilter.mode(
                        widget.product.isFavourite
                            ? const Color(0xFFFF4848)
                            : const Color(0xFFDBDEE4),
                        BlendMode.srcIn,
                      ),
                      height: getProportionateScreenWidth(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              left: getProportionateScreenWidth(20),
              right: getProportionateScreenWidth(64),
            ),
            child: Text(
              widget.product.description,
              maxLines: 3,
            ),
          ),
          ProductDetailsSheet(
            bottomSheetAnimationController: bottomSheetAnimationController,
            widget: widget,
          ),
          DeliveryAddressSheet(
            bottomSheetAnimationController: bottomSheetAnimationController,
          )
        ],
      ),
    );
  }
}

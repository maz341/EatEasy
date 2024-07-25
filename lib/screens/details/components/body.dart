import 'package:flutter/material.dart';
import 'package:eat_easy/screens/details/components/product_description.dart';
import 'package:eat_easy/screens/details/components/product_images.dart';
import 'package:eat_easy/screens/details/components/rating_tile.dart';
import 'package:eat_easy/screens/details/components/top_rounded_container.dart';
import 'package:eat_easy/screens/details/reviews/reviews_sheet.dart';

import '../../../models/product.dart';
import '../../../utils/size_config.dart';
import 'buy_now_button.dart';
import 'custom_app_bar.dart';

class DetailBody extends StatefulWidget {
  const DetailBody({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  State<DetailBody> createState() => _DetailBodyState();
}

class _DetailBodyState extends State<DetailBody>
    with SingleTickerProviderStateMixin {
  late AnimationController bottomSheetAnimationController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bottomSheetAnimationController.forward();
  }

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
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        ListView(
          children: [
            Stack(
              children: [
                ProductImages(product: widget.product),
                CustomAppBar(
                  rating: widget.product.rating,
                  color: Colors.transparent,
                ),
              ],
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TopRoundedContainer(
                    color: Colors.white,
                    child: Column(
                      children: [
                        FoodDescription(
                          product: widget.product,
                          pressOnSeeMore: () {},
                        ),
                        ReviewsSheet(
                          product: widget.product,
                          image: widget.product.images.first,
                        ),
                        RatingTile(
                          rating: widget.product.reviews.length.toString(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(120)),
          ],
        ),
        BuyNowButton(
          product: widget.product,
          width: width,
          widget: widget,
        ),
      ],
    );
  }
}

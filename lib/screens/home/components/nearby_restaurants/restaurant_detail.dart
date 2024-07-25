import 'package:eat_easy/models/restaurants.dart';
import 'package:eat_easy/screens/details/components/restaurant_description.dart';
import 'package:eat_easy/screens/details/components/restaurant_images.dart';
import 'package:eat_easy/screens/details/reviews/restaurant_reviews_sheet.dart';
import 'package:eat_easy/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:eat_easy/screens/details/components/rating_tile.dart';
import 'package:eat_easy/screens/details/components/top_rounded_container.dart';

import '../../../details/components/custom_app_bar.dart';

class RestaurantDetailScreen extends StatefulWidget {
  const RestaurantDetailScreen({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final Restaurant restaurant;

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen>
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
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              Stack(
                children: [
                  RestaurantImages(restaurant: widget.restaurant),
                  CustomAppBar(
                    rating: widget.restaurant.rating,
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
                          RestaurantDescription(
                            restaurant: widget.restaurant,
                            pressOnSeeMore: () {},
                          ),
                          RatingTile(
                            rating: widget.restaurant.reviews.length.toString(),
                          ),
                          RestaurantReviewsSheet(
                            restaurant: widget.restaurant,
                            image: widget.restaurant.images.first,
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
          // go to restaurant
          // BuyNowButton(
          //   product: widget.product,
          //   width: width,
          //   widget: widget,
          // ),
        ],
      ),
    );
  }
}

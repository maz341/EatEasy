import 'package:flutter/material.dart';
import 'package:eat_easy/screens/home/components/promotion/promotion_banner.dart';
import 'package:eat_easy/screens/home/components/home_header.dart';
import 'package:eat_easy/screens/home/components/nearby_restaurants/nearby_restaurants.dart';
import '../../../utils/size_config.dart';
import 'categories/categories.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: getProportionateScreenHeight(10)),
            const HomeHeader(),
            SizedBox(height: getProportionateScreenHeight(10)),
            const PromotionalBanner(),
            SizedBox(height: getProportionateScreenHeight(10)),
            const Categories(),
            SizedBox(height: getProportionateScreenHeight(20)),
            const NearbyRestaurants(),
            SizedBox(height: getProportionateScreenHeight(20)),
          ],
        ),
      ),
    );
  }
}

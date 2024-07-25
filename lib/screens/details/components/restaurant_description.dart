import 'package:eat_easy/models/restaurants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/size_config.dart';

class RestaurantDescription extends StatefulWidget {
  const RestaurantDescription({
    Key? key,
    required this.restaurant,
    required this.pressOnSeeMore,
    this.isFav,
  }) : super(key: key);

  final Restaurant restaurant;
  final GestureTapCallback pressOnSeeMore;
  final bool? isFav;

  @override
  State<RestaurantDescription> createState() => _RestaurantDescriptionState();
}

class _RestaurantDescriptionState extends State<RestaurantDescription>
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
              widget.restaurant.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
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
                        widget.restaurant.rating.toString(),
                        style: TextStyle(
                          fontSize: getProportionateScreenHeight(14),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  ' ( ${widget.restaurant.reviews.length} Reviews )',
                  style: TextStyle(
                    fontSize: getProportionateScreenHeight(12),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: getProportionateScreenWidth(20),
              right: getProportionateScreenWidth(64),
            ),
            child: Text(
              widget.restaurant.description,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}

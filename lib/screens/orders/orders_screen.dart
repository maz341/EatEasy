import 'package:eat_easy/components/custom_bottom_nav_bar.dart';
import 'package:eat_easy/screens/orders/components/body.dart';
import 'package:eat_easy/utils/enums.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class OrderScreen extends StatelessWidget {
  static String routeName = "/cart";

  const OrderScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: const Body(),
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.orders),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Orders",
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: kPrimaryColor),
      ),
      backgroundColor: Colors.white,
      leading: const Icon(
        Icons.arrow_back_ios,
        color: kPrimaryColor,
      ),
      elevation: 0,
      centerTitle: true,
    );
  }
}

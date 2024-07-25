import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eat_easy/screens/details/address/delivery_addresses_list_screen.dart';
import 'package:eat_easy/utils/constants.dart';

import '../../../utils/size_config.dart';

class DeliveryAddressSheet extends StatelessWidget {
  const DeliveryAddressSheet({
    super.key,
    required this.bottomSheetAnimationController,
  });

  final AnimationController bottomSheetAnimationController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const DeliveryAddressesListScreen(),
            ),
          );
        },
        child: Container(
          height: getProportionateScreenHeight(60),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: kPrimaryColor.withOpacity(.3),
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.truckDroplet,
                    size: 12,
                    color: kPrimaryColor,
                  ),
                  SizedBox(width: getProportionateScreenWidth(10)),
                  const Text(
                    "Delivery Address",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                size: 12,
                color: kPrimaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

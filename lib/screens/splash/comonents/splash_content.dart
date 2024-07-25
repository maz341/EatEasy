import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';

class SplashContent extends StatelessWidget {
  final String text, image;

  const SplashContent({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Text(
          "EatEasy",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(46),
            color: kPrimaryColor,
            fontFamily: 'TitanOne',
          ),
        ),
        const SizedBox(height: 15),
        Text(
          text,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        SvgPicture.asset(
          image,
          height: getProportionateScreenHeight(220),
          width: getProportionateScreenWidth(220),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:eat_easy/utils/constants.dart';
import 'package:get/get.dart';

import '../screens/signup/sign_up_screen.dart';
import '../utils/size_config.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account? ",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(12),
            ),
          ),
          GestureDetector(
            onTap: () => Get.to(() => const SignUpScreen()),
            child: Text(
              "Sign Up",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(12),
                color: kPrimaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}

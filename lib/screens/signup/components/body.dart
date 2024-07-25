import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';
import 'sign_up_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Register Account",
                  style: headingStyle.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.01), // 4%
                const Text(
                  "Complete your details or continue \nwith social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.06),
                const SignUpForm(),
                SizedBox(height: getProportionateScreenHeight(20)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w600,
                      ),
                      children: <TextSpan>[
                        const TextSpan(
                            text: 'By registering you agree to our '),
                        TextSpan(
                            text: 'Terms and conditions',
                            style: const TextStyle(
                              color: kPrimaryColor,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w500,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {}),
                        const TextSpan(text: ' and '),
                        TextSpan(
                            text: 'Privacy and Policy',
                            style: const TextStyle(
                              color: kPrimaryColor,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w500,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {}),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

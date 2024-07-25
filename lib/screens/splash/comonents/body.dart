import 'package:eat_easy/screens/home/home_screen.dart';
import 'package:eat_easy/screens/login/login_screen.dart';
import 'package:eat_easy/session_manager/session_manager.dart';
import 'package:eat_easy/utils/size_config.dart';
import 'package:flutter/material.dart';

import '../../../components/default_button.dart';
import '../../../models/splash.dart';
import 'dot_indicator.dart';
import 'splash_content.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Splash> splashData = [
    Splash(
      text: "Eat with Friends\nJust Easily Get it with EatEasy.",
      image: "assets/icons/splash1.svg",
    ),
    Splash(
      text: "Order From Your\nNearest Restaurants",
      image: "assets/icons/splash2.svg",
    ),
    Splash(
      text: "Every Friday Amazing New\nBeers For Real Drinkers",
      image: "assets/icons/splash3.svg",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Expanded(
              flex: 4,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index].image,
                  text: splashData[index].text,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                ),
                child: Column(
                  children: <Widget>[
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => DotIndicator(
                          currentPage: currentPage,
                          index: index,
                        ),
                      ),
                    ),
                    const Spacer(flex: 1),
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: DefaultButton(
                        text: "Continue",
                        txtColor: Colors.white,
                        press: () async {
                          bool isSessionExist = false;
                          String? userId =
                              await SessionManager().getUserEmail();

                          userId != null && userId.isNotEmpty
                              ? isSessionExist = true
                              : isSessionExist = false;

                          // Session Exist then go to Home
                          // No Session then go to Login

                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => isSessionExist
                                  ? const HomeScreen()
                                  : const LoginScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

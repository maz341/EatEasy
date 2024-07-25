import 'package:eat_easy/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/splash/splash_screen.dart';

class PreSplashScreen extends StatefulWidget {
  const PreSplashScreen({super.key});

  @override
  State<PreSplashScreen> createState() => _PreSplashScreenState();
}

class _PreSplashScreenState extends State<PreSplashScreen> {
  late Size size;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(color: kPrimaryColor),
        child: Stack(
          children: [
            bgTransparent(),
            Center(
              child: Container(
                // height: 100,
                // width: 100,
                color: kPrimaryColor,
                child: const Text(
                  "EatEasy",
                  style: TextStyle(
                    fontFamily: 'TitanOne',
                    fontSize: 70,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void gotoNextScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SplashScreen()));
  }

  bgTransparent() {
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Stack(children: [
        Positioned(
          top: -70,
          right: -70,
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
        Positioned(
          bottom: -70,
          left: -70,
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
        soManyCircles(),
      ]),
    );
  }

  soManyCircles() {
    return Stack(
      children: [
        positionedWidget(top: 50, left: -5),
        positionedWidget(top: 50, left: 25),
        positionedWidget(top: 50, left: 55),
        positionedWidget(top: 50, left: 85),
        //
        positionedWidget(top: 80, left: -5),
        positionedWidget(top: 80, left: 25),
        positionedWidget(top: 80, left: 55),
        positionedWidget(top: 80, left: 85),
        //
        positionedWidget(top: 110, left: -5),
        positionedWidget(top: 110, left: 25),
        positionedWidget(top: 110, left: 55),
        positionedWidget(top: 110, left: 85),
        //
        positionedWidget(top: 140, left: -5),
        positionedWidget(top: 140, left: 25),
        positionedWidget(top: 140, left: 55),
        positionedWidget(top: 140, left: 85),
      ],
    );
  }

  positionedWidget({required double top, required double left}) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }

  void startTimer() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.to(() => const SplashScreen());
    });
  }
}

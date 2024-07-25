import 'package:flutter/material.dart';
import 'package:eat_easy/components/custom_bottom_nav_bar.dart';
import 'package:eat_easy/screens/home/components/body.dart';

import '../../utils/constants.dart';
import '../../utils/enums.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? mtoken = " ";

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const Body(),
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.home),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        backgroundColor: kPrimaryColor,
        child: const Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
    );
  }
}

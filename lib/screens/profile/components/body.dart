import 'package:eat_easy/session_manager/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:eat_easy/screens/profile/components/my_account.dart';
import 'package:eat_easy/screens/profile/settings.dart';
import '../help_center.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  late AnimationController bottomSheetAnimationController;

  @override
  void initState() {
    super.initState();
    bottomSheetAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      children: [
        Column(
          children: [
            const ProfilePic(),
            const SizedBox(height: 20),
            Column(
              children: [
                const SizedBox(height: 20),
                // * My Account
                ProfileMenu(
                  text: "My Account",
                  icon: "assets/icons/User Icon.svg",
                  press: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MyAccount(),
                      ),
                    ),
                  },
                ),

                // * Settings
                ProfileMenu(
                  text: "Settings",
                  icon: "assets/icons/Settings.svg",
                  press: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Settings(),
                      ),
                    );
                  },
                ),

                // * Help Center
                ProfileMenu(
                  text: "Help Center",
                  icon: "assets/icons/Question mark.svg",
                  press: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HelpCenter(),
                      ),
                    );
                  },
                ),

                // * Log Out
                ProfileMenu(
                  text: "Log Out",
                  icon: "assets/icons/Log out.svg",
                  press: () async {
                    SessionManager().logout(context);
                    // Navigator.of(context).pushAndRemoveUntil(
                    //   MaterialPageRoute(
                    //       builder: (context) => const LoginScreen()),
                    //   (route) => false,
                    // );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

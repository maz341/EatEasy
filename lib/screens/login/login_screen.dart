import 'package:eat_easy/screens/login/components/body.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatelessWidget {
  static const routeName = '/sign-in';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Sign In",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 18,
          ),
        ),
        elevation: 0,
      ),
      body: const Body(),
    );
  }
}

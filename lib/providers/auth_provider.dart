import 'dart:convert';
import 'dart:core';
import 'package:eat_easy/models/user.dart';
import 'package:eat_easy/resources/data/database_service.dart';
import 'package:eat_easy/session_manager/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/address.dart';

class AuthProvider with ChangeNotifier {
  final String _email = '';
  String get email => _email;

  final String _username = '';
  String get username => _username;

  final List<Address?> _addresses = [];
  List<Address?>? get addresses => _addresses;

  Address? _selectedAddress;
  Address? get selectedAddress => _selectedAddress;

  Future<String> registerUser(User tempUser) async {
    try {
      if (tempUser.email.isNotEmpty &&
          tempUser.password!.isNotEmpty &&
          tempUser.name!.isNotEmpty) {
        debugPrint("tempUser ${jsonEncode(tempUser)}");
        String valueToReturn = '';
        await DatabaseHelper.internal().saveUser(tempUser).then((value) {
          debugPrint("value $value");
          if (value != 0) {
            valueToReturn = tempUser.name!;
          } else {
            valueToReturn = 'Something went wrong';
          }
        });
        return valueToReturn;
      } else {
        return '';
      }
    } catch (err) {
      return err.toString();
    }
  }

  Future<String> authenticateUser(
      {required String email, required String password}) async {
    String res = "❓Error occurred";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await DatabaseHelper.internal()
            .validateUser(email, password)
            .then((value) {
          debugPrint("Login=> $value");
          if (value) {
            res = 'success';

            // Save User Data to Session
            SessionManager().setUserInfo(email);
          } else {
            res = "failure";
          }
        });
      } else {
        res = '❗Please enter both email and password';
      }
    } catch (err) {
      res = err.toString();
      debugPrint("CATCH!");
      Get.snackbar(
        'Error Message',
        err.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return res;
  }

}

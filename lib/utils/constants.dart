import 'package:flutter/material.dart';
import 'package:eat_easy/utils/size_config.dart';

const kPrimaryColor = Color(0xFF6952ff);
const kPrimaryLight = Color(0xFFbfadff);
const kSecondaryColor2 = Color(0xFFfeebe2);
const kPrimaryLightColor = Color(0xFFdad4ff);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF5b42ff), kPrimaryColor],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please enter your email";
const String kInvalidEmailError = "Please enter valid email";
const String kNameNullError = "Please Enter your password";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kPhoneNumberNullError = "Please Eeter your phone number";
const String kAddressNullError = "Please enter your address";

// Database Tables with Column Names
const String cartTableName = 'cart_table';
const String cartItemName = 'name';
const String cartProduct = 'product';
const String cartQuantity = 'quantity';
const String cartId = 'id';

const String userTable = 'user_table';
const String userId = 'id';
const String userName = 'name';
const String userPassword = 'password';
const String userEmail = 'email';

const String orderTable = 'order_table';
const String orderId = 'id';
const String orderStatus = 'status';
const String orderAmount = 'amount';
const String orderQuantity = 'quantity';
const String orderAddress = 'address';
const String orderDate = 'date';
const String orderImage = 'image';
const String orderProducts = 'products';

const String addressTable = 'address_table';
const String addressId = 'id';
const String addressAddress = 'address';
const String addressType = 'type';
const String addressPostalCode = 'postal_code';

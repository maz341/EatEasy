import 'package:flutter/material.dart';
import '../models/user.dart';

class ProfileProvider with ChangeNotifier {
  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _numberController = TextEditingController();
  TextEditingController get numberController => _numberController;


  bool loading = false;

  void setUserFromAuthProvider(User user) {
    // nameController.text = user.username ?? '';
    emailController.text = user.email;


    notifyListeners();
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _numberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

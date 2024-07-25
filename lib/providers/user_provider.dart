import 'package:flutter/material.dart';
import 'package:eat_easy/models/models.dart' as models;
class UserProvider with ChangeNotifier {
  models.User _currentUser = models.User(email: '', id: '');
  late String _username;
  late String _email;
  late String _profileImage;

  String? _error;

  models.User get currentUser => _currentUser;
  String get uid => _currentUser.id;
  String get username => _username;
  String get email => _email;
  String get profileImage => _profileImage;

  String? get error => _error;

 
}

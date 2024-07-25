import 'package:eat_easy/screens/login/login_screen.dart';
import 'package:eat_easy/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SessionManager {
  String? _userId, _name, _email;

  setUserInfo(email) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
  }

  String get email => _email!;
  String get name => _name!;
  String get userId => _userId!;

  Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    var tempUserId = prefs.getString('email');
    return tempUserId;
  }

  logout(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    pushAndRemoveUntil(context, const LoginScreen());
  }
}

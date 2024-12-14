import 'package:shared_preferences/shared_preferences.dart';

class AuthSource {
  static final AuthSource _instance = AuthSource._internal();
  factory AuthSource() => _instance;
  AuthSource._internal();

  String? _token;
  String? _name;
  String? _email;
  String? _phone;

  String? get getToken => _token;
  String? get getName => _name;
  String? get getEmail => _email;
  String? get getPhone => _phone;

  Future<void> initialAuthSource() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    _name = prefs.getString('name');
    _email = prefs.getString('email');
    _phone = prefs.getString('phone');
    return;
  }

  set setToken(String token) {
    _token = token;
  }

  set setName(String name) {
    _name = name;
  }

  set setEmail(String email) {
    _email = email;
  }

  set setPhone(String phone) {
    _phone = phone;
  }
}

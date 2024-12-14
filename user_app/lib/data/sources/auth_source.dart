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

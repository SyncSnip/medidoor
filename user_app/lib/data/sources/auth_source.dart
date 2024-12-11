class AuthSource {
  String? _token;
  String? _name;
  String? _email;

  String? get getToken => _token;
  String? get getName => _name;
  String? get getEmail => _email;

  set setToken(String token) {
    _token = token;
  }

  set setName(String name) {
    _name = name;
  }

  set setEmail(String email) {
    _email = email;
  }
}

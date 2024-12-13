import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/common/helper_function/http_provider.dart';
import 'package:user_app/config/backend_utils/api_endpoints.dart';

import 'package:user_app/config/config_files/api_operations.dart';
import 'package:user_app/config/config_files/local_storage_key.dart';

class AuthRepository {
  static Future<int> signIn(String email, String password) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await request(ApiOperations.post, AuthEndpoints.signIn,
        json: {"email": email, "password": password});
    int code = response.statusCode;

    if (code == 200) {
      final responseData = jsonDecode(response.body);

      if (responseData['token'] != null) {
        await pref.setString(AppKey().getTokenKey, responseData['token']);
      }
      if (responseData['data']['name'] != null) {
        await pref.setString(AppKey().getNameKey, responseData['data']['name']);
      }
      if (responseData['data']['email'] != null) {
        await pref.setString(
            AppKey().getEmailKey, responseData['data']['email']);
      }
    }

    return response.statusCode;
  }

  static Future<int> signUp(String email, String password, String name) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await request(ApiOperations.post, AuthEndpoints.signUp,
        json: {"email": email, "password": password, "name": name});
    int code = response.statusCode;

    log(response.body.toString());

    if (code == 200) {
      final responseData = jsonDecode(response.body);

      if (responseData['token'] != null) {
        await pref.setString(AppKey().getTokenKey, responseData['token']);
      }
      if (responseData['data']['name'] != null) {
        await pref.setString(AppKey().getNameKey, responseData['data']['name']);
      }
      if (responseData['data']['email'] != null) {
        await pref.setString(
            AppKey().getEmailKey, responseData['data']['email']);
      }
    }

    return response.statusCode;
  }

  static Future<int> verifyEmail(String otp) async {
    try {
      final response = await request(
          ApiOperations.post, AuthEndpoints.verifyEmail,
          json: {"otp": otp});

      log('api res: ${response.body}');

      return response.statusCode;
    } catch (e) {
      log(e.toString());
      return 400;
    }
  }
}

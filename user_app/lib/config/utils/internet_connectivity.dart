import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectivityManager {
  static bool _isInternetAvailable = false;

  static bool get isInternetAvailable => _isInternetAvailable;

  static Future<bool> checkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    _isInternetAvailable = connectivityResult.first != ConnectivityResult.none;
    return _isInternetAvailable;
  }

  static void setInternetStatus(bool status) {
    _isInternetAvailable = status;
  }
}

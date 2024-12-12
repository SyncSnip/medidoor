import 'package:user_app/common/constants/global_constants.dart';
import 'package:user_app/domain/local_data/local_data.dart';

class HomeRepository {
  static Future<Map<String, dynamic>> getFetchHomepage() async {
    if (!isOnlineBackend) {
      return productDetails;
    }

    return productDetails;
  }
}

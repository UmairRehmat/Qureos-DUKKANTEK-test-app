import 'package:flutter/foundation.dart';
import 'package:testforqureos/providers/user_login_provider.dart';

class SignUpRepository {
  static Future<String> createUser(var userData) {
    if (kDebugMode) {
      print("create user data");
      print(userData);
    }
    return UserProvider.createUser(userData);
  }
}

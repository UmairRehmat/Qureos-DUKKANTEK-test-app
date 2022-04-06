import 'package:testforqureos/models/User.dart';
import 'package:testforqureos/providers/user_login_provider.dart';

class UserRepository {
  static Future<UserResponse> loginUser(var credentials) {
    if (credentials is String) {
      return UserProvider.getUser(credentials);
    } else {
      return UserProvider.loginUser(credentials);
    }
  }

  static Future<String> logoutUser() {
    return UserProvider.logoutUser();
  }

  static Future<String> resetPassword(var data) {
    return UserProvider.resetPassword(data);
  }
}

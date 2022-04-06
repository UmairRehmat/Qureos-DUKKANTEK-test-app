import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:testforqureos/models/User.dart';
import 'package:testforqureos/providers/shared_pref_provider.dart';
import 'package:testforqureos/utills/constants.dart';
import 'package:testforqureos/utills/network_collection.dart';

class UserProvider {
  static Future<UserResponse> loginUser(Map credentials) async {
    try {
      String url = "$BASE_URL$loginApi";
      var response = await http.post(Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
          body: jsonEncode(credentials));
      return UserResponse.fromJson(json.decode(response.body));
    } catch (error) {
      return UserResponse.withError(error);
    }
  }

  static Future<UserResponse> getUser(String token) async {
    try {
      String url = "$BASE_URL$getUserApi";
      var response = await http.get(Uri.parse(url), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      });
      return UserResponse.fromJson(json.decode(response.body));
    } catch (error) {
      return UserResponse.withError(error);
    }
  }

  static Future<String> logoutUser() async {
    try {
      String token = await SharedPrefProvider.getString(userToken);
      String url = "$BASE_URL$logoutApi";
      var response = await http.post(Uri.parse(url), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      });
      if (kDebugMode) {
        print('Logout Response status: ${response.statusCode}');
        print('Logout Response body: ${response.body}');
      }
      return response.statusCode.toString();
    } catch (error) {
      return "error $error";
    }
  }

  static Future<String> resetPassword(Map data) async {
    try {
      String url = "$BASE_URL$resetPasswordApi";
      var response = await http.post(Uri.parse(url), body: data);
      if (kDebugMode) {
        print('Reset Response status: ${response.statusCode}');
        print('Reset Response body: ${response.body}');
      }
      String message = json.decode(response.body)['message'];
      return message;
    } catch (error) {
      return "error $error";
    }
  }

  static Future<String> createUser(Map userData) async {
    try {
      String url = "$BASE_URL$signupApi";
      var response = await http.post(Uri.parse(url), body: userData);
      if (kDebugMode) {
        print('Sign up Response status: ${response.statusCode}');
        print('Sign up Response body: ${response.body}');
      }
      if (response.statusCode == 200) {
        return json.decode(response.body)['message'].toString();
      } else {
        String message = json.decode(response.body)['message'].toString();
        return 'error ${response.statusCode} $message';
      }
    } catch (error) {
      return 'error${error.toString()}';
    }
  }
}

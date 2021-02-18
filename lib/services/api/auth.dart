import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:ct_hunt/data/constants.dart';

class Auth {
  static const String _url = "/auth";

   static Future<Response> register(Map<String, dynamic> data) {
      return Dio().post('${Constants.API_BASE_URL}/$_url/register', data: data ).then((Response value) {
        Map<String, dynamic> data = value.data;
        if (data.containsKey('data')) {
          Constants.preferences.setString(Constants.TOKEN, data["token"]);
          Constants.preferences
              .setString(Constants.USER, jsonEncode(data["data"]));
        }
        return value;
      });
  }

  static Future<Response> login(Map<String, dynamic> data) {
    return Dio().post('${Constants.API_BASE_URL}/$_url/login', data: data).then((Response value) {
      Map<String, dynamic> data = value.data;
      if (data.containsKey('data')) {
        Constants.preferences.setString(Constants.TOKEN, data["token"]);
        Constants.preferences
            .setString(Constants.USER, jsonEncode(data["data"]));
      }
      return value;
    });
  }

  static void logOut() {
    Constants.preferences.setString(Constants.TOKEN, null);
    Constants.preferences.setString(Constants.USER, null);
  }

  static bool isAuth() {
    return Constants.preferences.getString(Constants.TOKEN) != null;
  }
}
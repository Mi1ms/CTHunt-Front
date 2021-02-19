import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  Constants._();
  static SharedPreferences preferences;
  // ignore: non_constant_identifier_names
  static const String IS_AUTH = "is_auth";
  static const String TOKEN = "token";
  static const String USER = "user";
  static const String API_BASE_URL = "http://10.0.2.2:4242";
  static const GOOGLE_API_KEY = "AIzaSyBTb7kOmEr1PnhhdVB8AUSRllfYorxiqPY";
}
import 'package:ct_hunt/data/constants.dart';

class ApiHeader {
  static Map<String, String> getAuthorization() {
    var token = Constants.preferences.getString(Constants.TOKEN);

    return {"Authorization": "Bearer $token"};
  }
  static Map<String, String> contentTypeJson() {
    return {"Content-Type": "application/json"};
  }

  static Map<String, String> contentTypeFormData() {
    return {"Content-Type": "multipart/form-data"};
  }
}

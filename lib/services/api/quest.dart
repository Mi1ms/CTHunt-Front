import 'package:dio/dio.dart';
import 'package:ct_hunt/data/constants.dart';
import 'package:ct_hunt/utils/apiHeader.dart';

class Quest {
  static const String _url = "${Constants.API_BASE_URL}/quests";

  static Future<Response> add(FormData data) {
    return Dio().post(_url, data: data,  options: Options(headers: {
      ...ApiHeader.getAuthorization(),
    }) );
  }

  static Future<Response> getAll() {
    return Dio().get(_url, options: Options(headers: {
      ...ApiHeader.getAuthorization(),
    }) );
  }
}
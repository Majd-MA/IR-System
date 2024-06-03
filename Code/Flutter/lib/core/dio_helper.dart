

import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'http://192.168.1.110:3000/',
          receiveDataWhenStatusError: true),
    );

  }


  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'Accept-Encoding': 'gzip, deflate, br',
      'User-Agent': 'PostmanRuntime/7.32.3',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':'',
    };

    return await dio.post(url, queryParameters: query, data: data);
  }

}

// 封装请求
import 'package:dio/dio.dart';
import 'package:flutter_douban/services/http_config.dart';

class HttpRequest {
  // 1、创建dio实例
  static BaseOptions baseOptions = new BaseOptions(
    baseUrl: BASE_URL,
    connectTimeout: CONNECT_TIMEOUT * 1000,
    // receiveTimeout: RECEIVE_TIMEOUT * 1000,
  );
  static Dio dio = new Dio(baseOptions);

  static Future request(String url,
      {String method = "get", Map<String, dynamic> params}) async {
    // 2、发送请求
    Options options = new Options(method: method);
    try {
      final result =
          await dio.request(url, queryParameters: params, options: options);
      return result;
    } on DioError catch (e) {
      // throw e;
      print("request error: $e");
    }
  }
}

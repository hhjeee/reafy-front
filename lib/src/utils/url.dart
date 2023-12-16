import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppUrl {
  static String baseurl = 'http://13.125.145.165:3000';
}

class ApiClient {
  final Dio dio = Dio();

  ApiClient() {
    dio.options.baseUrl = AppUrl.baseurl;
    dio.options.headers = {
      'Content-Type': "application/json",
    };

    dio.interceptors.add(LogInterceptor(responseBody: true));
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? userToken = prefs.getString('token');
        if (userToken != null) {
          options.headers['Authorization'] = 'Bearer $userToken';
        }
        return handler.next(options); //continue
      },
    ));
  }
}

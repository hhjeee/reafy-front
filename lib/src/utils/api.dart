import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide Response;
import 'package:provider/provider.dart';
import 'package:reafy_front/src/pages/login_page.dart';
import 'package:reafy_front/src/provider/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final baseUrl = dotenv.env['BASE_URL'];

class authDio {
  authDio._privateConstructor();
  static final authDio _instance = authDio._privateConstructor();
  factory authDio() {
    return _instance;
  }

  Dio getDio() {
    final baseUrl = dotenv.env['BASE_URL'] ?? 'https://dev.reafydevkor.xyz';
    Dio dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(milliseconds: 5000),
        receiveTimeout: Duration(milliseconds: 3000)));

    dio.interceptors.clear();
    dio.interceptors.add(CustomLogInterceptor());
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('token');

      /// Add headers before request is sent
      options.headers['content-type'] = "application/json";
      options.headers['Authorization'] = 'Bearer $accessToken';
      return handler.next(options); //continue
    }, onError: (DioError e, handler) async {
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          final newToken = await refreshToken();
          e.requestOptions.headers['Authorization'] = 'Bearer $newToken';
          final opts = Options(
            method: e.requestOptions.method,
            headers: e.requestOptions.headers,
          );
          final cloneResponse = await dio.request(e.requestOptions.path,
              options: opts,
              data: e.requestOptions.data,
              queryParameters: e.requestOptions.queryParameters);
          return handler.resolve(cloneResponse);
        } else if (e.response?.statusCode == 500 ||
            e.response?.statusCode == 404) {
          // 서버 에러 발생 시, 알림 대화 상자 표시
          final BuildContext? context = Get.context;
          if (context != null) {
            _showServerErrorDialog(
                context,
                e.response?.statusCode.toString() ??
                    "Unknown Error"); // e.response?.statusCode.toString() ??
          }
        } else {
          print("Error without response: $e");
          /*
          print("========500 =====");
          print(e.requestOptions.path);
          print(e.requestOptions.method);
          print(e.requestOptions.headers);
          print("$refreshToken");
          print(e.requestOptions.data);
          print(e.requestOptions.queryParameters);
          print(e.response);
          print("===========");*/

          /*final BuildContext? context = Get.context;
          if (context != null) {
            _showLoginExpiredDialog(context);
          }*/
        }

        return handler.next(e);
      }
    }));
    return dio;
  }

  static Future<String?> refreshToken() async {
    var refreshDio = Dio();
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refreshToken');

    final baseUrl = dotenv.env['BASE_URL'] ?? 'https://dev.reafydevkor.xyz';

    print("[***] Starting token refresh");

    refreshDio.interceptors.add(CustomLogInterceptor());
    try {
      final refreshResponse = await refreshDio.post(
          '${baseUrl}/authentication/refresh',
          options: Options(headers: {
            'content-type': "application/json",
            'Authorization': "Bearer $refreshToken"
          }));

      if (refreshResponse.statusCode == 200 ||
          refreshResponse.statusCode == 201) {
        final newAccessToken = refreshResponse.data['accessToken'];
        await prefs.setString('token', newAccessToken);
        print(
            "[***] Token refresh successful with newAccessToken: $newAccessToken"); //with newAccessToken: $newAccessToken");
        return newAccessToken;
      } else {
        print(
            "[***] Token refresh failed with statusCode: ${refreshResponse.statusCode}");
        return null;
      }
    } catch (e) {
      print("[***] Token refresh error: $e");
      final BuildContext? context = Get.context;
      if (context != null) {
        _showLoginExpiredDialog(context);
      }
      return null;
    }
  }
}

class CustomLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //print('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    // print(
    //     'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');

    super.onError(err, handler);
  }
}

Future<void> _showLoginExpiredDialog(BuildContext context) async {
  await showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Center(
            child: Text('로그인 만료',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center),
          ),
          content: Text("로그인이 만료되었습니다.\n다시 로그인 해주세요!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
              )),
          contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
          actions: [
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Provider.of<AuthProvider>(context, listen: false).logout();
                    //prefs.clear();
                    Get.off(() => LoginPage());
                    //Navigator.pop(context);
                  },
                  child: Text('확인', style: TextStyle(fontSize: 13)),
                  style: ButtonStyle()),
            )
          ],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))));
}

Future<void> _showServerErrorDialog(BuildContext context, String e) async {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Center(
        child: Text('서버 오류',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center),
      ),
      content: Text("서버에 문제가 발생했습니다. \n잠시 후 다시 시도해주세요.\n($e)",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
          )),
      contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
      actions: [
        Center(
            child: TextButton(
          child: Text('확인'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )),
      ],
    ),
  );
}

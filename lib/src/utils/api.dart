import 'package:ansicolor/ansicolor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide Response;
import 'package:reafy_front/src/provider/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

AnsiPen info = AnsiPen()..blue(bold: true);
AnsiPen success = AnsiPen()..green(bold: true);
AnsiPen error = AnsiPen()..red(bold: true);

final baseUrl = dotenv.env['BASE_URL'] ?? 'https://dev.reafy.devkor.club';

class authDio {
  authDio._privateConstructor();
  static final authDio _instance = authDio._privateConstructor();
  factory authDio() {
    return _instance;
  }

  Dio getDio() {
    Dio dio = Dio(BaseOptions(baseUrl: baseUrl));
    //connectTimeout: Duration(milliseconds: 5000),
    //receiveTimeout: Duration(milliseconds: 3000)));

    dio.interceptors.clear();
    dio.interceptors.add(CustomLogInterceptor());
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final accessToken = prefs.getString('token');
        options.headers['content-type'] = "application/json";
        options.headers['Authorization'] = 'Bearer $accessToken';
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (e.response != null) {
          if (e.response?.statusCode == 401) {
            final BuildContext? context = Get.context;
            if (context != null) {
              final newToken = await refreshToken();
              if (newToken != null) {
                debugPrint("CLONE REQUESTING");
                e.requestOptions.headers['Authorization'] = 'Bearer $newToken';
                final cloneOptions = Options(
                  method: e.requestOptions.method,
                  headers: e.requestOptions.headers,
                );
                final cloneResponse = await dio.request(e.requestOptions.path,
                    options: cloneOptions,
                    data: e.requestOptions.data,
                    queryParameters: e.requestOptions.queryParameters);
                return handler.resolve(cloneResponse);
              } else {
                // Refresh token failed, show error dialog and stop further requests
                await _showErrorDialog(
                    context, 'Token Expired', 'Please login again.');
                return handler.reject(e);
              }
            }
          } else if (e.response?.statusCode == 500 ||
              e.response?.statusCode == 404) {
            // Show server error dialog
            final BuildContext? context = Get.context;
            if (context != null) {
              await _showErrorDialog(context, 'Server Error',
                  '${e.response?.statusCode.toString() ?? "Unknown Error"}');
            }
          } else {
            debugPrint(error("[**]Error without response: $e"));
          }
        }
        return handler.next(e);
      },
    ));
    return dio;

    /*
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          final BuildContext? context = Get.context;
          if (context != null) {
            _showErrorDialog(context, 'Token Expired',
                '\n잠시 후 다시 시도해주세요.\n(${e.response?.statusCode.toString() ?? "Unknown Error"})');
            return handler.reject(e);
          }

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
            _showErrorDialog(context, 'Server Error',
                '${e.response?.statusCode.toString() ?? "Unknown Error"}');
          }
        } else {
          debugPrint(error("[**]Error without response: $e"));

          /*final BuildContext? context = Get.context;
          if (context != null) {
            _showLoginExpiredDialog(context);
          }*/
        }

        return handler.next(e);
      }
    }));
    return dio;*/
  }

  static Future<String?> refreshToken() async {
    var refreshDio = Dio();
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refreshToken');

    refreshDio.interceptors.add(RefreshLogInterceptor());
    try {
      final refreshResponse = await refreshDio.post(
          '${baseUrl}/authentication/refresh',
          options: Options(headers: {
            'content-type': "application/json",
            'Authorization': "Bearer $refreshToken"
          }));

      //debugPrint("<==== refreshResponse: $refreshResponse");
      //debugPrint("<===== Token Refresh [${refreshResponse.statusCode}]");

      if (refreshResponse.statusCode == 200 ||
          refreshResponse.statusCode == 201) {
        final newAccessToken = refreshResponse.data['accessToken'];
        await prefs.setString('token', newAccessToken);

        //debugPrint("[********** Refresh Finished ************************]");
        debugPrint("[ END REFRESH ]");
        return newAccessToken;
      } else {
        debugPrint("[ END REFRESH ]");
        return null;
      }
    } catch (e) {
      debugPrint("[ END REFRESH ]");
      //debugPrint(error("[*] Token refresh error: $e"));
      return null;
    }
  }
}

class CustomLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('REQUEST[${options.method}] => ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    debugPrint(
        'RESPONSE[${response.statusCode}] <= ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(error(
        'ERROR[${err.response?.statusCode}] || ${err.requestOptions.path}'));
    //debugPrint(error('ERROR MESSAGE : ${err.message}'));
    super.onError(err, handler);
  }
}

/*
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
                    Provider.of<AuthProvider>(context, listen: false)
                        .logout(context);
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
*/
Future<void> _showErrorDialog(
    BuildContext context, String title, String message) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Center(
        child: Text(title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            textAlign: TextAlign.center),
      ),
      content: Text("서버에 문제가 발생했습니다. \n잠시 후 다시 시도해주세요.\n($message)",
          textAlign: TextAlign.center, style: TextStyle(fontSize: 13)),
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


/*
          final BuildContext? context = Get.context;
          if (context != null) {
            _showErrorDialog(context, 'Server Error (Error without response)',
                '${e.response?.statusCode.toString() ?? "Unknown Error"}');
          }
          
          
          
           final BuildContext? context = Get.context;

      if (context != null) {
        debugPrint(error(context.toString()));
        _showErrorDialog(
            context,
            'Token Refresh error (Error without response)',
            '${e ?? "Unknown Error"}');

        //_showLoginExpiredDialog(context);
      }
      */
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reafy_front/src/provider/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class AppUrl {
  static String baseurl = 'https://reafydevkor.xyz';
}

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  final Dio dio = Dio();
  late BuildContext context;

  ApiClient._internal() {
    dio.options.baseUrl = AppUrl.baseurl;
    dio.options.headers = {
      'content-type': "application/json",
    };
    // Logging interceptor for debugging purposes
    dio.interceptors.add(LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true));
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? userToken = prefs.getString('token');
        //final prefs = await SharedPreferences.getInstance();
        //final userToken = prefs.getString('token');
        if (userToken != null) {
          options.headers['Authorization'] = 'Bearer $userToken';
        }
        //handler.next(options);
        return handler.next(options);
      },
      onError: (DioError error, handler) async {
        print("에러다");
        print(error.response);
        print("에러다");
        if (error.response?.statusCode == 401) {
          print("[*] Token expired");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? refreshToken = prefs.getString('refreshToken');
          //final prefs = await SharedPreferences.getInstance();
          //final refreshToken = prefs.getString('refreshToken');

          if (refreshToken != null) {
            try {
              final tokenres = await Dio().post(
                '${AppUrl.baseurl}/authentication/refresh',
                options: Options(headers: {
                  'content-type': 'application/json',
                  'Authorization': 'Bearer $refreshToken',
                }),
              );
              print("토큰 재발급 결과 $tokenres");

              if (tokenres.statusCode == 200 || tokenres.statusCode == 201) {
                print("토큰 대발급 성공\n\n\n\n\n");
                final newAccessToken = tokenres.data['accessToken'];
                prefs.setString('token', newAccessToken);
                final opts = Options(
                  method: error.requestOptions.method,
                  headers: {
                    ...error.requestOptions.headers,
                    'Authorization': 'Bearer $newAccessToken',
                  },
                );
                final cloneReq = await dio.request(
                  error.requestOptions.path,
                  options: opts,
                  data: error.requestOptions.data,
                  queryParameters: error.requestOptions.queryParameters,
                );
                return handler.resolve(cloneReq);
              } else {
                // Refresh token failed, trigger global logout
                Provider.of<AuthProvider>(context, listen: false).logout();
              }
            } catch (e) {
              print("Token refresh error: $e");
              Provider.of<AuthProvider>(context, listen: false).logout();
            }
          } else {
            // No refresh token available, trigger global logout
            Provider.of<AuthProvider>(context, listen: false).logout();
          }
        }
        return handler.next(error);
      },
    ));
  }

  static ApiClient get instance => _instance;
  setBuildContext(BuildContext context) {
    this.context = context;
  }
}
        //Dio tokenDio = Dio();
        //tokenDio.options.headers = {
        //  'Content-Type': 'application/json',
        //  'Authorization': 'Bearer $refreshToken'
        //};

        //try {

          //var tokenResponse =
          //    await tokenDio.post('${AppUrl.baseurl}/authentication/refresh');
          //if (tokenResponse.statusCode == 200 ||
          //    tokenResponse.statusCode == 201) {
            /*
            print("refresh req Successful");
            String newAccessToken = tokenResponse.data['accessToken'];
            prefs.setString('token', newAccessToken);

            print("[*] Token Refresh Result : ${tokenResponse.statusCode}");
            error.requestOptions.headers['Authorization'] =
                'Bearer $newAccessToken';

            final response = await dio.fetch(error.requestOptions);
            return handler.resolve(response);

            /*
            final opts = Options(
              method: error.requestOptions.method,
              headers: error.requestOptions.headers,
            );
            final cloneReq = await dio.request(
              error.requestOptions.path,
              options: opts,
              data: error.requestOptions.data,
              queryParameters: error.requestOptions.queryParameters,
            );

            return handler.resolve(cloneReq);*/
          } else {
            // Handle refresh token failure (e.g., by logging out the user)
            print("Failed to refresh token");
            //authProvider.logout();
          }
        } catch (e) {
          print("Token refresh error: \n   $e    ");
          // Handle errors from the refresh attempt
        }
      }
      return handler.next(error);
      //if (tokenResponse.statusCode == 201) {
      //String newAccessToken = tokenResponse.data['accessToken'];
      //prefs.setString('token', newAccessToken);
      // 재발급 토큰으로 기존 요청 다시
      // error(request)의 세팅들을 복사함
      //RequestOptions requestOptions = error.requestOptions;
      //requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
      // Retry the original request with the new token
      //return handler.resolve(await dio.request(
      //  requestOptions.path,
      //  options: Options(
      //    method: requestOptions.method,
      //    headers: requestOptions.headers,
      //  ),
      //  data: requestOptions.data,
      //  queryParameters: requestOptions.queryParameters,
      //));
      //}
      //} //print("handler.next(error) : ${handler.next(error)}");
      //return handler.next(error);
    }));
  }
}
*/
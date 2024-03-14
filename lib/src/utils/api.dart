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
        } else {
          final BuildContext? context = Get.context;
          if (context != null) {
            _showLoginExpiredDialog(context);
          }
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

    print("[***] Starting token refresh with refreshToken: $refreshToken");

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
            "[***] Token refresh successful with newAccessToken: $newAccessToken");
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
/*
   refreshDio.interceptors.clear();
    refreshDio.interceptors.add(CustomLogInterceptor());
    refreshDio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      options.headers['content-type'] = "application/json";
      options.headers['Authorization'] = "Bearer $refreshToken";
    }, onError: (e, handler) async {
      if (e.response?.statusCode == 401) {
        //_showLoginExpiredDialog();
        //final prefs = await SharedPreferences.getInstance();
        //prefs.clear();
        //Get.off(() => LoginPage());
      }
      return handler.next(e);
    }));
    final refreshResponse =
        await refreshDio.post('${baseUrl}/authentication/refresh');
    final newAccessToken = refreshResponse.data['accessToken'];
    prefs.setString('token', newAccessToken);
    //storage.setString('token', newToken);
  }*/
  }
}

class CustomLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
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
                  fontSize: 18,
                ),
                textAlign: TextAlign.center),
          ),
          content: Text("로그인이 만료되었습니다.\n다시 로그인 해주세요!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
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

/*
Future<Dio> authDio() async {
  var dio = Dio();
  final storage = await SharedPreferences.getInstance();
  dio.interceptors.clear();
  dio.interceptors.add(LogInterceptor(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true));

  dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
    final accessToken = storage.getString('token');
    // 매 요청마다 헤더에 AccessToken을 포함
    options.headers['Authorization'] = 'Bearer $accessToken';
    dio.options.baseUrl = AppUrl.baseurl;
    return handler.next(options);

// 기기에 저장된 AccessToken 로드
  }, onError: (error, handler) async {
    // 인증 오류가 발생했을 경우: AccessToken의 만료
    if (error.response?.statusCode == 401) {
      //final accessToken = storage.getString('token');
      final refreshToken = storage.getString('refreshToken');

      // 토큰 갱신 요청을 담당할 dio 객체 구현 후 그에 따른 interceptor 정의
      var refreshDio = Dio();
      refreshDio.options.baseUrl = AppUrl.baseurl;

      refreshDio.interceptors.clear();
      refreshDio.interceptors.add(LogInterceptor(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true));

      refreshDio.interceptors
          .add(InterceptorsWrapper(onError: (error, handler) async {
        // 다시 인증 오류가 발생했을 경우: RefreshToken의 만료
        if (error.response?.statusCode == 401) {
          // 기기의 자동 로그인 정보 삭제
          storage.clear();
          Get.off(() => LoginPage());
        }
        return handler.next(error);
      }));

      // 토큰 갱신 API 요청 시 AccessToken(만료), RefreshToken 포함
      refreshDio.options.headers['Authorization'] = 'Bearer $refreshToken';
      //refreshDio.options.headers['Authorization'] = 'Bearer $accessToken';
      //refreshDio.options.headers['Refresh'] = 'Bearer $refreshToken';
// 토큰 갱신 API 요청
      final refreshResponse =
          await refreshDio.get('${AppUrl.baseurl}/authentication/refresh');
      // response로부터 새로 갱신된 AccessToken과 RefreshToken 파싱
      final newAccessToken = refreshResponse.headers['Authorization']![0];
      //final newRefreshToken = refreshResponse.headers['Refresh']![0];

      storage.setString('token', newAccessToken);
      //storage.setString('token', newToken);

// AccessToken의 만료로 수행하지 못했던 API 요청에 담겼던 AccessToken 갱신
      error.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

// 수행하지 못했던 API 요청 복사본 생성
      final clonedRequest = await dio.request(error.requestOptions.path,
          options: Options(
              method: error.requestOptions.method,
              headers: error.requestOptions.headers),
          data: error.requestOptions.data,
          queryParameters: error.requestOptions.queryParameters);

      // API 복사본으로 재요청
      return handler.resolve(clonedRequest);
    }

    return handler.next(error);
  }));

  return dio;
}
*/

/*
  var dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(milliseconds: 5000),
      receiveTimeout: Duration(milliseconds: 3000)));

  late BuildContext context;


  authDio._internal() {
    //dio.options.baseUrl = baseUrl;
    dio.options.headers = {'content-type': "application/json"};
    //dio.interceptors.clear();

    dio.interceptors.add(LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true));

    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      // 매 요청마다 헤더에 AccessToken을 포함
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('token');
      options.headers['Authorization'] = 'Bearer $accessToken';

      //print('[**] Token : $accessToken');
      return handler.next(options);
    }, onError: (error, handler) async {
      if (error.response?.statusCode == 401) {
        print("[**] Token expired ");
        final prefs = await SharedPreferences.getInstance();
        final refreshToken = prefs.getString('refreshToken');

        // 토큰 갱신 요청을 담당할 dio 객체 구현 후 그에 따른 interceptor 정의
        var refreshDio = Dio();
        refreshDio.interceptors.clear();

        refreshDio.options.baseUrl = baseUrl;
        refreshDio.options.headers = {'content-type': "application/json"};
        refreshDio.options.headers = {'Authorization': 'Bearer $refreshToken'};

        refreshDio.interceptors.add(LogInterceptor(
            requestHeader: true,
            requestBody: true,
            responseHeader: true,
            responseBody: true));

        refreshDio.interceptors
            .add(InterceptorsWrapper(onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            // 기기의 자동 로그인 정보 삭제
            prefs.clear();
            Get.off(() => LoginPage());
          }
          return handler.next(error);
        }));

// 토큰 갱신 API 요청
        final refreshRes =
            await refreshDio.post('${baseUrl}/authentication/refresh');
        final newAccessToken = refreshRes.data['accessToken'];

        print("[**] 토큰 재발급 결과 : $refreshRes");
        prefs.setString('token', newAccessToken);

        error.requestOptions.headers['Authorization'] =
            'Bearer $newAccessToken';
        // 수행하지 못했던 API 요청 복사본 생성
        final clonedRequest = await dio.request(error.requestOptions.path,
            options: Options(
                method: error.requestOptions.method,
                headers: error.requestOptions.headers),
            data: error.requestOptions.data,
            queryParameters: error.requestOptions.queryParameters);

        // API 복사본으로 재요청
        return handler.resolve(clonedRequest);
      }

      return handler.next(error);
    }));

    //final newToken = tokenres.data['accessToken'];
    //prefs.setString('token', newToken);
  }

  //static authDio get instance => _instance;
  //setBuildContext(BuildContext context) {
   // this.context = context;
  //}*/

/*
class authDio {

  static final authDio _instance = authDio._internal();
  factory authDio() => _instance;

  static Dio _instance;
  static Dio getInstance() {
    if (_instance == null) {
      _instance = createDioInstance();
    }
    return _instance;
  }

  static Dio createDioInstance() {
    var dio = Dio();
    dio.interceptors.clear();
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) {},
        onError: (DioError e, handler) async {}));

    return dio;
  }

  static refreshToken() async {
    // TODO: new dio

    try {
      if (res.statusCode == 200) {
      } else {
        //TODO: logout
      }
    } catch (e) {
      print(e.toString()); //TODO: logout
    }
  }

  Future<Dio> authDio() async {
    // 1. Dio
    var dio = Dio(BaseOptions(
        baseUrl: baseurl,
        connectTimeout: Duration(milliseconds: 5000),
        receiveTimeout: Duration(milliseconds: 3000)));

    // 2. add interceptor : 1. for log, 2. for request+error
    final prefs = await SharedPreferences.getInstance();
    dio.interceptors.add(CustomLogInterceptor());

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        print('send request：path:${options.path}，baseURL:${options.baseUrl}');
      },
      onError: (error, handler) async {},
      onResponse: (response, handler) async {},
    ));

    // 3. 만료시 토큰 재발급
    dio.interceptors.clear();

    // 4. 재ㄹ급 받은 토큰 저장

    // 5. 에러난 요청 다시 보내기
    return dio;
  }
}*/

/*
          if (refreshToken != null) {
            try {
              final tokenres = await refreshDio.post(
                '${AppUrl.baseurl}/authentication/refresh',
                options: Options(headers: {
                  'content-type': 'application/json',
                  'Authorization': 'Bearer $refreshToken',
                }),
              );

              print("[**] 토큰 재발급 결과 : $tokenres");

              //final newToken = tokenres.data['accessToken'];
              //prefs.setString('token', newToken);

              if (tokenres.statusCode == 200 || tokenres.statusCode == 201) {
                print("[**} 토큰 재발급 성공\n");

                final newToken = tokenres.data['accessToken'];
                prefs.setString('token', newToken);

                //String newAccessToken = tokenResponse.data['accessToken'];
                //prefs.setString('token', newAccessToken);

                final opts = Options(
                  method: error.requestOptions.method,
                  headers: {
                    ...error.requestOptions.headers,
                    'Authorization': 'Bearer $newToken',
                  },
                );

                final res = await dio.request(
                  error.requestOptions.path,
                  options: opts,
                  data: error.requestOptions.data,
                  queryParameters: error.requestOptions.queryParameters,
                );

                return handler.resolve(res);
              } else {
                Provider.of<AuthProvider>(context, listen: false).logout();
              }
            } catch (e) {
              print("[**] Token refresh error: $e");
              Provider.of<AuthProvider>(context, listen: false).logout();
            }
          } else {
            Provider.of<AuthProvider>(context, listen: false).logout();
          }
        }
        return handler.next(error);
      },
    ));*/

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
}static authDio get instance => _instance;
*/

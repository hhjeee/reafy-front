import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cookie_jar/cookie_jar.dart';

class AppUrl {
  static String baseurl = 'https://dev.reafydevkor.xyz';
}

class ApiClient {
  final Dio dio = Dio();
  late PersistCookieJar cookieJar;

  ApiClient() {
    //_initCookieJar();

    dio.options.baseUrl = AppUrl.baseurl;
    dio.options.headers = {
      'Content-Type': "application/json",
    };

    dio.interceptors.add(LogInterceptor(responseBody: true));
    // Add the interceptor :  for handling authorization
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userToken = prefs.getString('token');
      if (userToken != null) {
        options.headers['Authorization'] = 'Bearer $userToken';
      }
      return handler.next(options);
    }, onError: (DioError error, handler) async {
      // 토큰 만료때문에 생긴 에러인지 체크
      // error : req

      if (error.response?.statusCode == 401) {
        print("[**]token 만료");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? refreshToken =
            prefs.getString('refreshToken'); // refreshToken은 저장해놔야함

        // 새로운 dio 생성해서 refresh 요청
        Dio tokenDio = Dio();
        tokenDio.options.baseUrl = '${AppUrl.baseurl}/authentication/refresh';
        tokenDio.options.headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $refreshToken'
        };
        var tokenResponse = await tokenDio.post(tokenDio.options.baseUrl);
        print("[**] token refresh result : ${tokenResponse.statusCode}");
        if (tokenResponse.statusCode == 201) {
          print("refresh req Successful");
          String newAccessToken = tokenResponse.data['accessToken'];
          prefs.setString('token', newAccessToken);

          // 재발급 토큰으로 기존 요청 다시
          // error(request)의 세팅들을 복사함
          RequestOptions requestOptions = error.requestOptions;
          requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
          // Retry the original request with the new token
          return handler.resolve(await dio.request(
            requestOptions.path,
            options: Options(
              method: requestOptions.method,
              headers: requestOptions.headers,
            ),
            data: requestOptions.data,
            queryParameters: requestOptions.queryParameters,
          ));
        }
      } //print("handler.next(error) : ${handler.next(error)}");
      return handler.next(error);
    }));
  }
}

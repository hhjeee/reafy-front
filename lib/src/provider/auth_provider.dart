import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/provider/stopwatch_provider.dart';
import 'package:reafy_front/src/utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  late User _userInfo;
  bool _newUser = true;
  bool _isLoggedIn = false;
  String _nickname = "Reafy";

  User get userInfo => _userInfo;
  bool get isNewUser => _newUser;
  bool get isLoggedIn => _isLoggedIn;

  String get nickname => _nickname;

  Future<void> setLoginStatus(bool loginStatus) async {
    _isLoggedIn = loginStatus;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', loginStatus);
    notifyListeners();
  }

  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    notifyListeners();
  }

  Future<void> setRefreshToken(String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('refreshToken', refreshToken);
    notifyListeners();
  }

  Future<bool> refreshToken() async {
    final refreshdio = Dio();
    refreshdio.interceptors.clear();
    refreshdio.interceptors.add(RefreshLogInterceptor());

    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refreshToken');

    try {
      final refreshRes = await refreshdio.post(
          '${baseUrl}/authentication/refresh',
          options: Options(headers: {
            'content-type': "application/json",
            'Authorization': "Bearer $refreshToken"
          }));

      if (refreshRes.statusCode == 200 || refreshRes.statusCode == 201) {
        final newAccessToken = refreshRes.data['accessToken'];
        await setToken(newAccessToken);
        return true;
      }
      return false;
    } catch (e) {
      print('[*] Refresh token error in auth provider: $e.message');
      return false;
    }
  }

  Future<bool> isTokenValid() async {
    final dio = authDio().getDio();
    try {
      final res = await dio.post('${baseUrl}/authentication/accesstokenTest');
      //debugPrint("[*] Token validation response: ${res.statusCode}");
      return res.statusCode == 200 || res.statusCode == 201;
    } catch (e) {
      //debugPrint("[*] Token validation error: $e");
      return false;
    }
  }

  Future<bool> performAuthenticatedAction() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (await isTokenValid()) {
      debugPrint(
          "[*] VALID TOKEN : ${token.toString().substring(token.toString().length - 3)}");

      return true;
    } else {
      debugPrint("[*] Expired token! Attempting to refresh.");
      return await refreshToken();
    }
  }

  Future<void> login() async {
    final dio = authDio().getDio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      setLoginStatus(true);
      _userInfo = await UserApi.instance.me();
      _nickname = _userInfo.kakaoAccount?.profile?.nickname ?? "Reafy";
      await prefs.setString('nickname', _nickname);

      var res = await dio.post("${baseUrl}/authentication/login",
          data: {"accessToken": token.accessToken, "vendor": "kakao"});

      if (res.statusCode == 200 || res.statusCode == 201) {
        var refreshToken =
            res.headers.value('set-cookie')?.split(';').first.split('=').last;
        if (refreshToken != null) {
          await setRefreshToken(refreshToken);
        }

        if (prefs.getString('token') != null) {
          _newUser = false;
        }

        await setToken(res.data["accessToken"]);
        notifyListeners();
      }
    } catch (e) {
      setLoginStatus(false);
      debugPrint('[*] LOGIN FAILED : $e');
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      /*
      final stopwatchProvider =
          Provider.of<StopwatchProvider>(context, listen: false);

      if (stopwatchProvider.status == Status.running) {
        stopwatchProvider.pause();
      }*/
      await UserApi.instance.logout(); // Kakao SDK logout
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      setLoginStatus(false);
    } catch (e) {
      debugPrint('[*] LOGOUT FAILED:  $e');
    }
  }
}

class RefreshLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("[ REFRESH DIO ]");
    debugPrint('\tREQUEST[${options.method}] => ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    debugPrint(
        '\tRESPONSE[${response.statusCode}] <= ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(error(
        "\tERROR[${err.response?.statusCode}] || ${err.requestOptions.path}"));
    //debugPrint(error('ERROR MESSAGE : ${err.message}'));
    super.onError(err, handler);
  }
}

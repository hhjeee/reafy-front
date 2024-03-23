import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/provider/stopwatch_provider.dart';
import 'package:reafy_front/src/provider/time_provider.dart';
import 'package:reafy_front/src/utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  late User _userInfo;
  bool _newUser = true;
  String _nickname = "Reafy";

  User get userInfo => _userInfo;
  bool get isNewUser => _newUser;
  String get nickname => _nickname;

  Future<void> setLoginStatus(bool loginStatus) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', loginStatus);
    notifyListeners();
  }

  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    //print("[*] Token set : $token");
  }

  Future<void> setRefreshToken(String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('refreshToken', refreshToken);
    //print("[*] refreshToken : $refreshToken");
  }

  Future<bool> refreshToken() async {
    final dio = authDio().getDio(); // Using the custom Dio
    final refreshToken =
        (await SharedPreferences.getInstance()).getString('refreshToken') ?? '';

    try {
      final res = await dio.post('/authentication/accesstokenTest',
          options: Options(headers: {'Authorization': 'Bearer $refreshToken'}));
      if (res.statusCode == 200 || res.statusCode == 201) {
        await setToken(res.data['accessToken']);
        return true;
      }
      return false;
    } catch (e) {
      print('[*] Refresh token error: $e.message');
      return false;
    }
  }

  Future<bool> isTokenValid() async {
    final dio = authDio().getDio();
    try {
      final res = await dio.post('/authentication/accesstokenTest');
      print("[*] Token validation response: ${res.statusCode}");
      return res.statusCode == 200 || res.statusCode == 201;
    } catch (e) {
      print("[*] Token validation error: $e");
      return false;
    }
  }

  Future<bool> performAuthenticatedAction() async {
    if (await isTokenValid()) {
      print("[*] Token is valid");
      return true;
    } else {
      print("[*] Expired token! Attempting to refresh.");
      return await refreshToken();
    }
  }

  @override
  Future<void> login() async {
    final dio = authDio().getDio(); // Use the custom Dio instance
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      print('[*] Kakao Login successful');
      //. Kakao Token: ${token.accessToken}');
      setLoginStatus(true);
      _userInfo = await UserApi.instance.me();
      _nickname = _userInfo.kakaoAccount?.profile?.nickname ?? "Reafy";
      await prefs.setString('nickname', _nickname);

      var res = await dio.post("/authentication/login",
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
      print('[*] LOGIN FAILED : $e.message');
      setLoginStatus(false);
    }
  }

  @override
  Future<void> logout(BuildContext context) async {
    try {
      final stopwatchProvider =
          Provider.of<StopwatchProvider>(context, listen: false);

      if (stopwatchProvider.status == Status.running) {
        stopwatchProvider.pause();
        // await sendTimeToServer(stopwatchProvider.elapsedTimeString);
      }

      await UserApi.instance.logout(); // Kakao SDK logout
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      //late StopwatchProvider stopwatch;// Clears all data in SharedPreferences
      //final timeProvider = Provider.of<TimeProvider>(context);

      print('[*] LOGOUT SUCCESSFUL');
      setLoginStatus(false); // Update login status and notify listeners
    } catch (e) {
      print('[*] LOGOUT FAILED');
    }
  }
}

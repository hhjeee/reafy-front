import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
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
    final dio = authDio().getDio(); // Using the custom Dio
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
  Future<void> logout() async {
    try {
      await UserApi.instance.logout(); // Kakao SDK logout
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear(); // Clears all data in SharedPreferences

      print('[*] LOGOUT SUCCESSFUL');
      setLoginStatus(false); // Update login status and notify listeners
    } catch (e) {
      print('[*] LOGOUT FAILED');
    }
  }

/*
  Future<void> getUsername() async {
    try {
      _userInfo = await UserApi.instance.me();
      print('사용자 정보 요청 성공'
          '\n닉네임 : ${_userInfo.kakaoAccount?.profile?.nickname}');
      return "${_userInfo.kakaoAccount?.profile?.nickname}";
      //notifyListeners();
    } catch (e) {
      print('사용자 정보요청 실패 $e');
      return "Reafy";
    }
    return "Reafy";
    //notifyListeners();
  }*/
}

//login (req, res, next)

/*

  @override
  Future<void> loginCheck() async {
    if (!_loginStat) {
      return;
    }
    if (await AuthApi.instance.hasToken()) {
      try {
        AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
        print('토큰 유효성 체크 성공 ${tokenInfo.id} ${tokenInfo.expiresIn}');
        _loginStat = true;
      } catch (e) {
        if (e is KakaoException && e.isInvalidTokenError()) {
          print('토큰 만료 $e');
        } else {
          print('토큰 정보 조회 실패 $e');
        }
        _loginStat = false;
      }
    } else {
      print('발급된 토큰 없음');
      _loginStat = false;
    }

    notifyListeners();
  }

*/

/*

  @override
  Future<void> getUserInfo() async {
    try {
      _userInfo = await UserApi.instance.me();
      print('[user.dart] 사용자 정보 요청 성공'
          '\n회원번호 : ${_userInfo.id}'
          '\n닉네임 : ${_userInfo.kakaoAccount?.profile?.nickname}');
    } catch (e) {
      print('사용자 정보요청 실패 $e');
    }
    notifyListeners();
  }*/

/* if (isInstalled) {
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
          print('카카오톡으로 로그인 성공 '); //
          print('카카오 token: $token');
          setLogin();
          _loginStat = true;
        } catch (e) {
          _loginStat = false;
          print('카카오톡으로 로그인 실패 $e');
        }
      } else {
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공'); //
          setLogin();
          _token = token.accessToken;
        } catch (e) {
          print('카카오계정으로 로그인 실패 $e');
        }
      }
    } catch (e) {
      print('로그인 실패 $e');
    }
    notifyListeners();
    
    
      try {
        var response = await apiClient.dio.post(url, data: body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          var resBody = response.data;
          if (resBody['token'] == null) {
            _newUser = true;
          }
          setToken(resBody["accessToken"]);

          notifyListeners();
        } else {
          // Handle errors
        }
      } on DioError catch (e) {
        print('error : $e');
      }
    }

        if (resBody['token'] == null) {
          _newUser = true;
        }
        // save accessToken and RefreshToken
        setToken(resBody["accessToken"]);

        notifyListeners();
      } else {
        // Handle errors
      }
    } on DioError catch (e) {
      print('error : $e');
    }
    //}

    notifyListeners();*/

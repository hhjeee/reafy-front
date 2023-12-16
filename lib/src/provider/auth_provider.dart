import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:reafy_front/src/pages/login_page.dart';
import 'package:reafy_front/src/utils/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  late User _userInfo;
  //bool _loginStat = false;
  bool _newUser = true;
  String _nickname = "Reafy";

  User get userInfo => _userInfo;

  //bool get isLogin => _loginStat;
  bool get isnewUser => _newUser;
  String get nickname => _nickname;
  //String get accessToken => _token;

  final reqBaseUrl = AppUrl.baseurl;
  final ApiClient apiClient = ApiClient();

  Future<void> setLogin(bool loginstat) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', loginstat);
  }

  Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  Future<void> setRefreshToken(String refreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('refreshToken', refreshToken);
  }

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
  Future<bool> refreshToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String refreshToken = prefs.getString('refreshToken') ?? '';
      print(refreshToken);

      Dio refreshDio = Dio();
      refreshDio.options.baseUrl =
          '${AppUrl.baseurl}/authentication/accesstokenTest';
      refreshDio.options.headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $refreshToken'
      };

      var res = await refreshDio.post(refreshDio.options.baseUrl);

      print("[*] token refresh result : ${res.statusCode}");

      if (res.statusCode == 200) {
        String newAccessToken = res.data['accessToken'];
        //await prefs.setString('token', newAccessToken);
        await setToken(newAccessToken);
        return true;
      }
      return false;
    } catch (e) {
      print('[*] Refresh token error: $e');
      return false;
    }
  }

  Future<bool> isTokenValid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('token');
    final ApiClient apiClient = ApiClient();
    if (accessToken == null) return false;

    try {
      final res = await apiClient.dio.post('/authentication/accesstokenTest');
/*
      Dio tokenDio = Dio();

      tokenDio.options.baseUrl =
          '${AppUrl.baseurl}/authentication/accesstokenTest';
      tokenDio.options.headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };

      var res = await tokenDio.post(tokenDio.options.baseUrl);
*/
      print("[*] token validation result : ${res.statusCode}");
      return res.statusCode == 201;
    } catch (e) {
      return false;
    }

    /*

        if (tokenResponse.statusCode == 200) {
          print("refresh req Successful");
          String newAccessToken = tokenResponse.data['accessToken'];
          prefs.setString('token', newAccessToken);


    try {
      var response = await apiClient.dio.get('/');
      print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
      print(response);
      print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");

      return response.statusCode == 200;
    } catch (e) {
      print('Token validation error: $e');
      return false;
    }*/
  }

  Future<bool> performAuthenticatedAction() async {
    if (await isTokenValid()) {
      return true;
    } else {
      print("[*] 만료된 토큰 재발급 시도합니다");
      return await refreshToken();
    } /*else {
      if (await refreshToken()) {
        return true;
      } else {
        print("[*]Failed to refresh token");
        logout();
        return false;
      }*/
  }

  @override
  Future<void> login() async {
    String url = "/authentication/login";
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // ... Kakao login code ...
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      OAuthToken token;

      if (isInstalled) {
        token = await UserApi.instance.loginWithKakaoTalk();
      } else {
        token = await UserApi.instance.loginWithKakaoAccount();
      }
      //print('[*]Login successful. Kakao Token: $token');
      setLogin(true);

      print('[*]Login successful. Kakao Token: ${token.accessToken}');
      //_loginStat = true;
      //_token = token.accessToken;

      _userInfo = await UserApi.instance.me();

      print('사용자 정보 요청 성공'
          '\n닉네임 : ${_userInfo.kakaoAccount?.profile?.nickname}');
      _nickname = "${_userInfo.kakaoAccount?.profile?.nickname}";
      notifyListeners();

      //// 서버랑 1. 카카오토큰 주고 토큰 받아오기   2. refresh 토큰 저장해놓기

      var res = await apiClient.dio.post(url,
          data: {"accessToken": token.accessToken, "vendor": "kakao"});
      if (res.statusCode == 200 || res.statusCode == 201) {
        var resBody = res.data;
        print("[*]서버 커스텀 토큰 : $resBody");
        //print("[*]Response :${res.headers}");

        var cookies = res.headers['set-cookie'];
        if (cookies != null && cookies.isNotEmpty) {
          var refreshToken = cookies.first.split(';')[0].split('=')[1];
          print('[*] refreshToken : $refreshToken');
          await setRefreshToken(refreshToken);
        }

        print("###########################");
        print(resBody);
        print("###########################");

        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (prefs.getString('token') != null) {
          _newUser = false;
          notifyListeners();
        }

        //if (resBody['accessToken'] == null)
        await setToken(resBody["accessToken"]);
        //await setRefreshToken(resBody["refreshToken"]);
        notifyListeners();
      }
    } catch (e) {
      print('[*]Login failed: $e');
      setLogin(false);
      //_loginStat = false;
    }
    //notifyListeners();
  }

  @override
  Future<void> logout() async {
    try {
      await UserApi.instance.logout();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('token');
      print('[*]로그아웃 성공 , SDK에서 토큰 삭제');
      print('[*]로그아웃 완료');
      setLogin(false);
      //_loginStat = false;
    } catch (e) {
      print('[*]로그아웃 실패 , SDK에서 토큰 삭제 $e');
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
      //print("token from server");
      //print(response.statusCode);
      //print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
      //print(response);
      //print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var resBody = response.data; // 서버에서 준 accessToken 1시간 짜리

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

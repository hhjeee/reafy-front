import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:reafy_front/src/pages/login_page.dart';
import 'package:reafy_front/src/utils/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  late User _userInfo;
  bool _loginStat = false;
  bool _newUser = false;
  String _token = "";

  User get userInfo => _userInfo;
  bool get isLogined => _loginStat;
  bool get isnewUser => _newUser;
  String get accessToken => _token;

  final reqBaseUrl = AppUrl.baseurl;
  final ApiClient apiClient = ApiClient();

  Future setLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', true);
  }

  Future setToken(token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

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

  Future<bool> refreshToken() async {
    try {
      var response = await apiClient.dio.post('/authentication/refresh');
      print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
      print(response);
      print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String newAccessToken =
            response.data['accessToken']; // Adjust based on your API response
        await prefs.setString('token', newAccessToken);
        return true;
      }
    } catch (e) {
      print('Refresh token error: $e');
    }
    return false;
  }

  Future<bool> isTokenValid() async {
    try {
      var response = await apiClient.dio.get('/');
      print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
      print(response);
      print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");

      return response.statusCode == 200;
    } catch (e) {
      print('Token validation error: $e');
      return false;
    }
  }

/*
  Future<bool> performAuthenticatedAction() async {
    print(isTokenValid());
    if (await isTokenValid()) {
      return true;
    } else {
      if (await refreshToken()) {
        return true;
      } else {
        print("Failed to refresh token");
        print("로그인 페이지로 이동합니다");
        Get.off(LoginPage());
        return false;

        // Handle the case where the token cannot be refreshed (e.g., redirect to login)
      }
    }
  }
*/
  @override
  Future<void> login() async {
    String url = "/authentication/login"; // Adjusted URL
    final body = {"accessToken": _token, "vendor": "kakao"};

    // ... Kakao login code ...
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      if (isInstalled) {
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
          print('카카오톡으로 로그인 성공 '); //
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

    //////// got token from kakao ////////////
    //////// now send it to our server ///////
    ///
    if (_loginStat) {
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

    notifyListeners();
  }

  @override
  Future<void> logout() async {
    try {
      await UserApi.instance.logout();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('token');
      print('로그아웃 성공 , SDK에서 토큰 삭제');
      print('로그아웃 완료');

      _loginStat = false;
    } catch (e) {
      print('로그아웃 실패 , SDK에서 토큰 삭제 $e');
    }
    notifyListeners();
  }
}




  /*

    body = {"accessToken": _token, "vendor": "kakao"};
    try {
      http.Response req = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body));

      //print(req.statusCode);

      if (req.statusCode == 200 || req.statusCode == 201) {
        var resBody = jsonDecode(utf8.decode(req.bodyBytes));

        /// 우리 서버용 커스텀 토큰
        //print(resBody["accessToken"]);

        // if no token found = new user --> onboarding page
        if (prefs.getString('token') == null) {
          setToken(resBody["accessToken"]);
          //prefs.setString('token', resBody["accessToken"]);
          _newUser = true;
          notifyListeners();
        } else
          setToken(resBody["accessToken"]);

        notifyListeners();
      } else {
        final res = json.decode(req.body);
        //_loginStat = false;
        notifyListeners();
      }
      ;
    } on SocketException catch (e) {
      print("Internet connection error");
      _loginStat = false;
      notifyListeners();
    } catch (e) {
      print("Try Again");
      _loginStat = false;
      notifyListeners();
    }*/

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
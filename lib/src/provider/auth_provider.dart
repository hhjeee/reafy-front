import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:reafy_front/src/utils/url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  late User _userInfo;
  bool _loginStat = false;
  bool _newUser = false;
  String _token = "";
  //String _token = "";

  final reqBaseUrl = AppUrl.baseurl;

  User get userInfo => _userInfo;
  bool get isLogined => _loginStat;
  bool get isnewUser => _newUser;
  String get accessToken => _token;

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

  @override
  Future<void> login() async {
    String url = "$reqBaseUrl/authentication/login";
    final headers = {"Content-Type": "application/json"};
    final body; //= {"accessToken": _token, "vendor": "kakao"};

    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      bool isInstalled = await isKakaoTalkInstalled();
      if (isInstalled) {
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
          print('카카오톡으로 로그인 성공 '); //
          setLogin();
          //print('${token.accessToken}');
          _loginStat = true;
          //getUserInfo();
          print('[user.dart]_loginStat = ${_loginStat}');
        } catch (e) {
          _loginStat = false;
          print('카카오톡으로 로그인 실패 $e');
        }
      } else {
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공'); //
          setLogin();
          //print('${token.accessToken}');

          //_loginStat = true;
          _token = token.accessToken;
          //getUserInfo();
          //print('[user.dart]_loginStat = ${_loginStat}');
          //return {'result': true, 'data': token.accessToken};
        } catch (e) {
          //_loginStat = false;
          print('카카오계정으로 로그인 실패 $e');
          //return {'result': false, 'data': e};
        }
      }
    } catch (e) {
      //_loginStat = false;
      print('로그인 실패 $e');
    }
    notifyListeners();

    //////// got token from kakao ////////////
    //////// now send it to our server ///////

    body = {"accessToken": _token, "vendor": "kakao"};

    //print(reqBaseUrl);
    //print(" == Access Token from kakao ==");
    //print(body);
    //print(" =================");
    try {
      http.Response req = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body));

      //print(req.statusCode);

      if (req.statusCode == 200 || req.statusCode == 201) {
        var resBody = jsonDecode(utf8.decode(req.bodyBytes));

        /// 우리 서버용 커스텀 토큰
        //print(" == Custom Token ==");
        //print(resBody["accessToken"]);
        //print(req.body);
        //print(" =================");
        // 토큰 저장

        //try {prefs.getString('token')};

        // if no token found = new user --> onboarding page
        if (prefs.getString('token') == null) {
          setToken(resBody["accessToken"]);
          //prefs.setString('token', resBody["accessToken"]);
          _newUser = true;
          notifyListeners();
        } else
          setToken(resBody["accessToken"]);
        //prefs.setString('token', resBody["accessToken"]);

        //String? token = prefs.getString('token');
        //print(token);

        //_loginStat = false;
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
    }
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
}

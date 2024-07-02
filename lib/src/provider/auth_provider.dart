import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:reafy_front/src/pages/login_page.dart';
import 'package:reafy_front/src/utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthProvider extends ChangeNotifier {
  late User _userInfo;
  bool _newUser = true;
  //bool _isLoggedIn = false;
  String _nickname = "Reafy";

  User get userInfo => _userInfo;
  bool get isNewUser => _newUser;
  //bool get isLoggedIn => _isLoggedIn;
  String get nickname => _nickname;
  /*
  Future<void> setLoginStatus(bool loginStatus) async {
    _isLoggedIn = loginStatus;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', loginStatus);
    notifyListeners();
  }*/

  Future<void> setNewUser(bool isnewUser) async {
    _newUser = isnewUser;
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
      return res.statusCode == 200 || res.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  Future<bool> performAuthenticatedAction() async {
    //// 1. Check if NewUser (see if token exists)
    //// 2. If New User >> FALSE >> Login 화면으로 연결 >> 로그인 화면에서 체크 후 연결
    //// 3. If Existing User >> 기존 토큰 유효성 검사 후 >>
    /// 토큰 만료 시 갱신해서 유효하게 만들어줌
    /// 유효한 토큰이면 통과
    /// >>> VALID TOKEN 여부
    /// FALSE 이면 로그인 화면으로 연결 - 로그인 오류 팝업?
    /// TRUE 면 앱으로 연결
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      setNewUser(false);
      if (await isTokenValid()) {
        debugPrint(
            "[*] VALID TOKEN : ${token.toString().substring(token.toString().length - 3)}");
        return true;
      } else {
        debugPrint("[*] Expired token! Attempting to refresh.");
        return await refreshToken();
      }
    } else {
      setNewUser(true);
      debugPrint("[*] New User");
      return false;
    }
  }

  Future<void> loginWithKaKao() async {
    final dio = authDio().getDio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

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
        await setToken(res.data["accessToken"]);
      }
    } catch (e) {
      debugPrint('[*] LOGIN FAILED : $e');
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      await UserApi.instance.logout(); // Kakao SDK logout
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      debugPrint('[*] LOGOUT SUCCESS');
    } catch (e) {
      debugPrint('[*] LOGOUT FAILED:  $e');
    }
  }

  Future<void> loginWithApple() async {
    final dio = authDio().getDio();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        //TODO : 백 완료되면 채워넣기
        //webAuthenticationOptions: WebAuthenticationOptions(
        //    clientId: "kAppleOAuthClientId",
        //    redirectUri: Uri.parse('${baseUrl}/auth/apple'))
      );
      /*
      debugPrint("userIdentifier : ${appleCredential.userIdentifier}");
      debugPrint("givenName : ${appleCredential.givenName}");
      debugPrint("familyName : ${appleCredential.familyName}");
      debugPrint("authorizationCode : ${appleCredential.authorizationCode}");
      debugPrint("email : ${appleCredential.email}");
      debugPrint("identityToken : ${appleCredential.identityToken}");
      debugPrint("state : ${appleCredential.state}");
      */
      // TODO Prepare the data to send to your backend server
      final data = {
        'userIdentifier': appleCredential.userIdentifier,
        'authorizationCode': appleCredential.authorizationCode,
        'identityToken': appleCredential.identityToken,
        //'email': appleCredential.email,
        //'fullName': appleCredential.givenName + ' ' + appleCredential.familyName,
        "vendor": "apple"
      };

      final res = await Dio().post(
        '${baseUrl}/authentication/apple', //TODO
        data: data,
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        // TODO : 백 응답 방식에 따라 파싱
        var refreshToken =
            res.headers.value('set-cookie')?.split(';').first.split('=').last;

        if (refreshToken != null) {
          await setRefreshToken(refreshToken);
        }
        await setToken(res.data["accessToken"]);
        //notifyListeners();
        //setLoginStatus(true);
        // TODO nickname 설정
        prefs.setString('nickname', appleCredential.email!);
      } else {
        // Handle sign-in failure
        debugPrint('[**] Sign-in failed: ${res.data}');
      }
    } catch (error) {
      debugPrint('[*] LOGIN FAILED : $error');
      Get.off(() => LoginPage());
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

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/pages/intro.dart';
import 'package:reafy_front/src/utils/constants.dart';

abstract class SocialLogin {
  Future<bool> login(); //성공여부

  Future<bool> logout(); //성공여부
}

class KakaoLogin implements SocialLogin {
  @override
  Future<bool> login() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      if (isInstalled) {
        try {
          await UserApi.instance.loginWithKakaoTalk();
          return true;
        } catch (e) {
          return false;
        }
      } else {
        try {
          await UserApi.instance.loginWithKakaoAccount();
          return true;
        } catch (e) {
          return false;
        }
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await UserApi.instance.unlink();
      return true;
    } catch (error) {
      return false;
    }
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // 카카오 로그인 인스턴스 생성
  final KakaoLogin _kakaoLogin = KakaoLogin();

  // 카카오 로그인 수행 함수
  Future<void> _performKakaoLogin() async {
    bool success = await _kakaoLogin.login();
    if (success) {
      Get.offAll(OnBoardingPage()); // GetX를 사용하여 모든 이전 경로를 지우고 홈 화면으로 이동
    } else {
      // 로그인 실패 시 예외 처리 (예: 에러 메시지 표시)
      // 여기에 적절한 예외 처리 코드를 추가하세요.
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Widget _bubble() {
      return Container(
          width: 240,
          child: ImageData(
            IconsPath.bubble,
            isSvg: false,
            width: 240,
          ));
    }

    Widget _logo() {
      return Container(
          child: ImageData(
        IconsPath.title_logo,
        isSvg: false,
        width: 150,
      ));
    }

    Widget _character() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: size.width,
          //height: 360, // 적절한 높이 설정

          child: ImageData(IconsPath.login_character),
        ),
      );
    }

    Widget _loginbutton() {
      return GestureDetector(
        onTap: _performKakaoLogin, // 카카오 로그인 수행
        child: Container(
          child: ImageData(
            IconsPath.login_button,
            isSvg: false,
            width: 300,
          ),
        ),
      );
    }

    return Center(
        child: Container(
      //color: bg_gray,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg_green.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _bubble(),
            _logo(),
            _character(),
            SizedBox(height: 30),
            _loginbutton()
          ]),
    ));
  }
}

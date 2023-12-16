import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/app.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/pages/intro.dart';
import 'package:reafy_front/src/provider/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isToken = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Widget _bubble() {
      return Container(
          width: 260,
          child: ImageData(
            IconsPath.bubble,
            isSvg: false,
            width: 260,
            height: 80,
          ));
    }

    Widget _logo() {
      return Container(
          child: ImageData(
        IconsPath.title_logo,
        isSvg: false,
        width: 150,
        height: 50,
      ));
    }

    Widget _character() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: size.width,
          height: size.height * 0.5, // 적절한 높이 설정

          child: ImageData(IconsPath.login_character),
        ),
      );
    }

    Widget _loginbutton() {
      return GestureDetector(
        onTap: () async {
          print(" 터치했는데");
          print("터치 했는데");

          var auth = context.read<AuthProvider>();
          await auth.login();
          //await auth.getUserInfo();
          //print(auth.nickname);

          SharedPreferences prefs = await SharedPreferences.getInstance();
          bool isLoggedIn = prefs.getBool('isLogin') ?? false;
          ////print("[*]로그인 여부 : $isLoggedIn");
          if (isLoggedIn) {
            if (await auth.performAuthenticatedAction()) {
              Get.off(() => auth.isnewUser ? OnBoardingPage() : App());
            } else {
              print("[*]토큰 재발급 실패");
              Get.off(() => LoginPage());
            }
          } else {
            print("[*]로그인되어있지 않은 경우");
            Get.off(() => LoginPage());
          }
        },
        child: Container(
          child: ImageData(
            IconsPath.login_button,
            isSvg: false,
            width: 300,
            height: 70,
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
            _loginbutton(),
          ]),
    ));
  }
}

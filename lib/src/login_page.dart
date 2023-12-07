import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/app.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/pages/intro.dart';
import 'package:reafy_front/src/provider/user_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            height: 70,
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
          var user = context.read<UserProvider>();
          user.loginCheck();
          if (!await user.isLogined) {
            await user.login();
            await user.loginCheck();
            if (await user.isLogined) {
              Get.to(OnBoardingPage());
            } else {
              Get.to(LoginPage());
            }
          } else {
            Get.to(App());
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

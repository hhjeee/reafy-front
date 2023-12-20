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

    void tapLoginButton() async {
      print(" 터치했는데");
      print("터치 했는데");

      var auth = context.read<AuthProvider>();
      await auth.login();
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
            Spacer(),
            Character(width: size.width, height: size.height),
            //SizedBox(height: 10),
            LoginButton(
              onTap: () async {
                tapLoginButton();
              },
            ),
            Spacer(),
          ]),
    ));
  }
}

class LoginButton extends StatelessWidget {
  final VoidCallback onTap;

  const LoginButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
}

/*
class Bubble extends StatelessWidget {
  const Bubble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 260,
        child: ImageData(
          IconsPath.bubble,
          isSvg: false,
          width: 260,
          height: 80,
        ));
  }
}

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ImageData(
      IconsPath.title_logo,
      isSvg: false,
      width: 150,
      height: 50,
    ));
  }
}
*/
class Character extends StatelessWidget {
  final double width;
  final double height;

  const Character({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: width,
          height: height * 0.6,
          decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.center,
              image: AssetImage(IconsPath.login_character),
              fit: BoxFit.fitWidth,
            ),
          ),
        ));
  }
}






/*
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

*/

/*
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

Widget _character(double w, double h) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      width: w,
      height: h * 0.5, // 적절한 높이 설정

      child: ImageData(IconsPath.login_character),
    ),
  );
}
*/



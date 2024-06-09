import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:reafy_front/src/app.dart';
import 'package:reafy_front/src/pages/login_page.dart';
import 'package:reafy_front/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    showSplashScreen();
  }

  void showSplashScreen() async {
    await Future.delayed(Duration(seconds: 2));
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLogin') ?? false;
    if (isLoggedIn) {
      FlutterNativeSplash.remove();
      Get.off(() => App());
    } else {
      await Future.delayed(Duration(seconds: 2));
      FlutterNativeSplash.remove();
      Get.off(() => LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        width:SizeConfig.screenWidth,//double.infinity,
        height: SizeConfig.screenHeight,
        child: Center(
            child: Lottie.asset(
      'assets/lottie/SplashScreen.json',fit: BoxFit.fill, 
    ))));
  }
}

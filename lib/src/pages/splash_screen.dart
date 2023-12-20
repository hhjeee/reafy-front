import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:reafy_front/src/app.dart';
import 'package:reafy_front/src/pages/login_page.dart';
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
    /*WidgetsBinding.instance.addPostFrameCallback((_) {
      checkLoginStatus();
    });*/
  }

  void showSplashScreen() async {
    await Future.delayed(Duration(seconds: 5));
    checkLoginStatus();
    FlutterNativeSplash.remove();
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLogin') ?? false;

    if (isLoggedIn) {
      Get.off(() => App());
    } else {
      Get.off(() => LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/lottie/SplashScreen.json',
            repeat: true, frameRate: FrameRate(10000000)),
      ),
    );
  }
}


/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/app.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/pages/login_page.dart';
import 'package:reafy_front/src/provider/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //AuthProvider auth = Provider.of<AuthProvider>(context);
  //bool isLoading = true;
  //bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLogin') ?? false;
    // is Login : 카카오 로그인페이지때 true 저장
    print("[*]로그인 여부 : $isLoggedIn");
    print("[*]토큰 : ${prefs.getString('token')}");

    if (isLoggedIn) {
      var auth = Provider.of<AuthProvider>(context, listen: false);
      if (await auth.performAuthenticatedAction()) {
        //print("[*]토큰 유효, 앱으로 이동함다");
        FlutterNativeSplash.remove();
        Get.off(() => App());
      } else {
        print("[*]토큰 재발급 실패");
        FlutterNativeSplash.remove();
        Get.off(() => LoginPage());
      }
    } else {
      FlutterNativeSplash.remove();
      print("[*]로그인되어있지 않은 경우");
      Get.off(() => LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
*/
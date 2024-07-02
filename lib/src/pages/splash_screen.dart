import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/app.dart';
import 'package:reafy_front/src/pages/login_page.dart';
import 'package:reafy_front/src/provider/auth_provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:reafy_front/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

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
    var key = await KakaoSdk.origin;
    print(key);
    await Future.delayed(Duration(seconds: 2));
    FlutterNativeSplash.remove();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    await Future.delayed(Duration(seconds: 2));
/////// USER TOKEN EXISTS
    if (token != null) {
      // Token exists, validate it
      if (await authProvider.isTokenValid()) {
        // Token is valid
        debugPrint("[checkLoginStatus] Valid Token Exists");

        Get.off(() => App());
      } else {
        debugPrint("[checkLoginStatus] Invalid Token Exists.");
        // Token is not valid, try to refresh it
        if (await authProvider.refreshToken()) {
          // Token refreshed successfully
          debugPrint("[checkLoginStatus] Refreshed successfully.");
          Get.off(() => App());
        } else {
          debugPrint(
              "[checkLoginStatus] Token refresh failed. DELETE ALL TOKENS");

          final prefs = await SharedPreferences.getInstance();
          await prefs.clear();

          Get.off(() => LoginPage());
        }
      }
    }

////// NEW USER : NO TOKEN
    else {
      debugPrint("[checkLoginStatus] No token found.");
      authProvider.setNewUser(true);
      Get.off(() => LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: green,
            width: double.infinity,
            height: double.infinity,
            child: Center(
                child: Column(children: [
              Lottie.asset(
                'assets/lottie/SplashScreen.json',
                fit: BoxFit.fill,
              )
            ]))));
  }
}

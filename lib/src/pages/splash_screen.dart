import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/app.dart';
import 'package:reafy_front/src/pages/login_page.dart';
import 'package:reafy_front/src/provider/auth_provider.dart';
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
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.isLoggedIn) {
      FlutterNativeSplash.remove();
      Get.off(() => App());
    } else {
      FlutterNativeSplash.remove();
      Get.off(() => LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Center(
                child: Lottie.asset(
              'assets/lottie/SplashScreen.json',
              fit: BoxFit.fill,
            ))));
  }
}

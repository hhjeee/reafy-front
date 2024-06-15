import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/app.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/controller/connectivity_controller.dart';
import 'package:reafy_front/src/pages/intro.dart';
import 'package:reafy_front/src/provider/auth_provider.dart';
import 'package:reafy_front/src/utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: Container(
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
            SizedBox(height: 10),
            LoginButton(
              onTap: () => _loginbuttonClick(context),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  void _loginbuttonClick(BuildContext context) async {
    final connectivityController = context.read<ConnectivityController>();

    if (connectivityController.isConnected) {
      final authProvider = context.read<AuthProvider>();
      await authProvider.login();

      final isLoggedIn =
          (await SharedPreferences.getInstance()).getBool('isLogin') ?? false;

      if (isLoggedIn && await authProvider.performAuthenticatedAction()) {
        Get.off(() => authProvider.isNewUser ? OnBoardingPage() : App());
      } else {
        Get.off(() => LoginScreen());
      }
    } else {
      //showErrorDialog(context, "Network Error", "네트워크 연결 후 다시 시도해 주세요.");
    }
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

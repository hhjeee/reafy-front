//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reafy_front/src/app.dart';
import 'package:reafy_front/src/binding/init_bindings.dart';
import 'package:reafy_front/src/components/poobao_home.dart';
import 'package:reafy_front/src/models/bookCount.dart';
import 'package:reafy_front/src/pages/intro.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/pages/login_page.dart';
import 'package:reafy_front/src/pages/mypage.dart';
import 'package:reafy_front/src/provider/auth_provider.dart';
import 'package:reafy_front/src/provider/selectedbooks_provider.dart';
import 'package:reafy_front/src/provider/state_book_provider.dart';
import 'package:reafy_front/src/provider/stopwatch_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  bool isLoading = true;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _autoLoginCheck();
  }

  Future<void> _autoLoginCheck() async {
    var auth = context.read<AuthProvider>();
    //await auth.performAuthenticatedAction();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    setState(() {
      isLoading = false;
      isLoggedIn = token != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      print("Loading...");
      return CircularProgressIndicator();
    } else {
      FlutterNativeSplash.remove();
      if (isLoggedIn) {
        print("Logged In");
        return App();
      } else {
        // User is not logged in
        return LoginPage();
      }
    }
  }
}


/*
class Root extends GetView<AuthController> {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext _, AsyncSnapshot<User?> user) {
        if (user.hasData) {
          return FutureBuilder<IUser?>(
            future: controller.loginUser(user.data!.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const App();
              } else {
                Get.put(MypageController());
                return App();
                // return Obx(
                //   () => controller.user.value.uid != null
                //       ? const App()
                //       : SignupPage(uid: user.data!.uid),
                // );
              }
            },
          );
        } else {
          return const LoginPage();
        }
      },
    );
  }
}


*/
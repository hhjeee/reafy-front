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







/*
      bool isValid = await auth.isTokenValid(); 
      if (isValid) {
        print("[*]토큰 유효, 앱으로 이동함다");
        FlutterNativeSplash.remove();
        Get.off(App());
      } else if (await auth.refreshToken()) {
        print("[*]토큰 재발급 완료, 자동 로그인 재시도 ");
        isValid = await auth.isTokenValid();
        FlutterNativeSplash.remove();
        isValid ? Get.off(App()) : Get.off(LoginPage());
      } else {
        print("[*]토큰 재발급 실패");
        FlutterNativeSplash.remove();
        Get.off(LoginPage());
      }
    }*/

/*
  Future<void> moveScreen() async {
    await autoLoginCheck().then((isLogin) {
      if (isLogin) {}
      Get.off(isLogin ? App() : LoginPage());
    });
  }

  Future<bool> autoLoginCheck() async {
    //var auth = context.read<AuthProvider>();
    //await auth.performAuthenticatedAction();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin =
        prefs.getBool('isLogin') ?? false; // 처음 앱 사용하면 isLogin =null -> false
    print("[*] isLogin : $isLogin");
    return isLogin;

    //final String? token = prefs.getString('token');
    /*
    setState(() {
      isLoading = false;
      isLoggedIn = token != null;
    });*/
  }
*/










/*if (isLoading) {
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
    }*/

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

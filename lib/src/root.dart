//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reafy_front/src/app.dart';
import 'package:reafy_front/src/pages/intro.dart';

import 'package:get/get.dart';
import 'package:reafy_front/src/pages/login.dart';

/// TODO
/// home , login 화면 연결
///

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return OnBoardingPage();
    //return GetMaterialApp(
    //  home: IntroPage(),
    //);
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
          return const Login();
        }
      },
    );
  }
}

*/

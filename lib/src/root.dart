//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reafy_front/src/app.dart';
import 'package:reafy_front/src/pages/intro.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/login_page.dart';
/*
class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            width: 300,
            height: 300,
            child: Column(children: [
              Text('islogined: ${viewModel.isLogined}'),
              ElevatedButton(
                  onPressed: () async {
                    await viewModel.login();
                    setState(() {});
                  },
                  child: const Text("Login")),
              ElevatedButton(
                  onPressed: () async {
                    await viewModel.logout();
                    setState(() {});
                  },
                  child: const Text("Logout"))
            ])));
  }
}



*/
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
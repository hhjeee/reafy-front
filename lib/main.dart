import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:reafy_front/src/app.dart';
import 'package:reafy_front/src/binding/init_bindings.dart';
import 'package:reafy_front/src/login_page.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/components/poobao_home.dart';
import 'package:reafy_front/src/models/bookCount.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:reafy_front/src/provider/user_provider.dart';
import 'dart:async';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env"); // env 파일 초기화
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  initializeDateFormatting('ko_KR', null);
  KakaoSdk.init(nativeAppKey: dotenv.env['KAKAO_NATIVE_APP_KEY']);

  runApp(ChangeNotifierProvider<UserProvider>(
      create: (context) => UserProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<BookModel>(
            create: (context) => BookModel(),
          ),
          ChangeNotifierProvider<PoobaoHome>(
            create: (context) => PoobaoHome(),
          ),
        ],
        child: GetMaterialApp(
            builder: (context, child) {
              return MediaQuery(
                child: child!,
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              );
            },
            title: 'reafy',
            debugShowCheckedModeBanner: false,
            theme: new ThemeData(
              fontFamily: 'NanumSquareRound',
            ),
            initialBinding: InitBinding(),
            home: Consumer<UserProvider>(
                builder: (context, user, child) =>
                    !user.isLogined ? App() : LoginPage())));
  }
}


/*FutureBuilder(
              future: Future.delayed(
                  const Duration(seconds: 3), () => "Intro Completed."),
              builder: (context, snapshot) {
                return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 1000),
                    child: _splashLoadingWidget(snapshot));
              },
            )*/
/*
Widget _splashLoadingWidget(AsyncSnapshot<Object?> snapshot) {
  if (snapshot.hasError) {
    return const Text("Error!!");
  } else if (snapshot.hasData) {
    return App();
  } else {
    return const OnBoardingPage();
  }
}
*/
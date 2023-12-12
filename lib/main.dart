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
import 'package:reafy_front/src/pages/splash.dart';
import 'package:reafy_front/src/provider/stopwatch_provider.dart';
import 'package:reafy_front/src/provider/auth_provider.dart';
import 'package:reafy_front/src/provider/state_book_provider.dart';
import 'package:reafy_front/src/provider/selectedbooks_provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:reafy_front/src/root.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

Future main() async {
  /*
  void _autoLoginCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token != null) {
      setState(() {
        isToken = true;
      });
    }
  }

  bool isToken = false;
  _autoLoginCheck();*/

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // env 파일 초기화
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  initializeDateFormatting('ko_KR', null);
  KakaoSdk.init(nativeAppKey: dotenv.env['KAKAO_NATIVE_APP_KEY']);

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  initializeDateFormatting().then((_) => runApp(MyApp()));
  //runApp(
  /*
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthProvider()),
        ChangeNotifierProvider(create: (ctx) => SelectedBooksProvider()),
        ChangeNotifierProvider(create: (ctx) => BookShelfProvider()),
        ChangeNotifierProvider(create: (ctx) => BookModel()),
        ChangeNotifierProvider(create: (ctx) => PoobaoHome()),
        ChangeNotifierProvider(create: (ctx) => StopwatchProvider()),
      ],
      child: */
  //    MyApp());

/*
  initializeDateFormatting().then((_) => runApp(
      ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(), child: MyApp())));*/
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (c) => AuthProvider()),
          ChangeNotifierProvider(create: (c) => SelectedBooksProvider()),
          ChangeNotifierProvider(create: (c) => BookShelfProvider()),
          ChangeNotifierProvider(create: (c) => BookModel()),
          ChangeNotifierProvider(create: (c) => PoobaoHome()),
          ChangeNotifierProvider(create: (c) => StopwatchProvider()),
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
            home:
                //FlutterNativeSplash.remove();
                Root()));

    /*GetMaterialApp(
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
            home: 
            
            Consumer<AuthProvider>(
                builder: (context, user, child) =>
                    user.isLogined ? App() : LoginPage()))*/
  }
}











  //Future<void> getToken() async {
  // ignore: await_only_futures

  //User? tokenResult = ;///await //FirebaseAuth.instance.currentUser;
  //log(tokenResult.toString());
  //if (tokenResult == null) return true;
  // ignore: unused_local_variable
  //var idToken = await tokenResult.getIdToken();
  //log(idToken.toString());

  // ignore: avoid_print
  //print("idToken : $idToken");
  //if(idToken == null) return true;
  //IdToken = idToken.toString();

  //http.Response response = await http.get(Uri.parse("${baseUrl}users/login"),
  //    headers: {'Authorization': 'bearer $IdToken'});
  //var resBody = jsonDecode(utf8.decode(response.bodyBytes));
  //UserId = resBody['data']['user_id'];

  //bool userdata = await UpdateUserData();

  //return IdToken == null || UserId == null || userdata == false;

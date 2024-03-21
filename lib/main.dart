import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:reafy_front/src/binding/init_bindings.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:reafy_front/src/models/bookcount.dart';
import 'package:reafy_front/src/provider/memo_provider.dart';
import 'package:reafy_front/src/provider/stopwatch_provider.dart';
import 'package:reafy_front/src/provider/auth_provider.dart';
import 'package:reafy_front/src/provider/state_book_provider.dart';
import 'package:reafy_front/src/provider/selectedbooks_provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:reafy_front/src/pages/splash_screen.dart';
import 'package:reafy_front/src/provider/item_provider.dart';
import 'package:reafy_front/src/provider/item_placement_provider.dart';
import 'package:reafy_front/src/provider/coin_provider.dart';
import 'package:reafy_front/src/provider/time_provider.dart';
import 'dart:async';
import 'package:reafy_front/src/utils/constants.dart';

Future main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // env 파일 초기화
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // 상태 표시줄 배경색을 투명하게 설정
    statusBarIconBrightness: Brightness.dark, // 상단바 아이콘을 밝게 설정 (어두운 배경에 적합)
  ));

  initializeDateFormatting('ko_KR', null);
  KakaoSdk.init(nativeAppKey: dotenv.env['KAKAO_NATIVE_APP_KEY']);

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    //authDio.instance.setBuildContext(context);

    SizeConfig().init(context);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (c) => AuthProvider()),
          ChangeNotifierProvider(create: (c) => SelectedBooksProvider()),
          ChangeNotifierProvider(create: (c) => BookShelfProvider()),
          ChangeNotifierProvider(create: (c) => BookModel()),
          ChangeNotifierProvider(create: (c) => ItemProvider()),
          ChangeNotifierProvider(create: (c) => ItemPlacementProvider()),
          ChangeNotifierProvider(create: (c) => StopwatchProvider()),
          ChangeNotifierProvider(create: (c) => CoinProvider()),
          ChangeNotifierProvider(create: (c) => MemoProvider()),
          ChangeNotifierProvider(create: (c) => TimeProvider()),
        ],
        child: GetMaterialApp(
            builder: (context, child) {
              return MediaQuery(
                child: child!,
                data: MediaQuery.of(context)
                    .copyWith(textScaler: TextScaler.linear(1.0)),
              );
            },
            title: 'reafy',
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            theme: new ThemeData(
              scaffoldBackgroundColor: bg_gray,
              primaryColor: yellow,
              colorScheme:
                  ColorScheme.fromSwatch(primarySwatch: Colors.yellow).copyWith(
                secondary: yellow,
              ),
              popupMenuTheme: PopupMenuThemeData(color: bg_gray),
              brightness: Brightness.light,
              dialogBackgroundColor: Color(0xffFAF9F7),
              progressIndicatorTheme: ProgressIndicatorThemeData(
                circularTrackColor: Colors.transparent,
                color: Colors.transparent, // 여기서 원하는 색상으로 변경
              ),
              fontFamily: 'NanumSquareRound',
            ),
            initialBinding: InitBinding(),
            home: SplashScreen()));
  }
}

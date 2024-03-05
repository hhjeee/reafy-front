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
import 'package:reafy_front/src/utils/url.dart';

Future main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // env 파일 초기화
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  initializeDateFormatting('ko_KR', null);
  KakaoSdk.init(nativeAppKey: dotenv.env['KAKAO_NATIVE_APP_KEY']);

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    ApiClient.instance.setBuildContext(context);
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      brightness: MediaQuery.platformBrightnessOf(context),
      seedColor: green,
    );
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
              colorScheme: colorScheme,
              progressIndicatorTheme: ProgressIndicatorThemeData(
                circularTrackColor: Colors.transparent,
                color: yellow_bg, // 여기서 원하는 색상으로 변경
              ),
              fontFamily: 'NanumSquareRound',
            ),
            initialBinding: InitBinding(),
            home: SplashScreen()));
  }
}

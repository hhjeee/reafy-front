import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:reafy_front/src/binding/init_bindings.dart';
import 'package:reafy_front/src/root.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/components/poobao_home.dart';

void main() {
  //KakaoContext.clientId = 'YOUR_KAKAO_CLIENT_ID';
  KakaoSdk.init(nativeAppKey: 'd6d001e8c5435fb63e0ab033f4cac481');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          // 여러 개의 Provider를 선언할 수 있습니다.
          ChangeNotifierProvider<PoobaoHome>(
            create: (context) => PoobaoHome(),
          ),
          // 다른 Provider들도 필요에 따라 추가 가능합니다.
        ],
        child: GetMaterialApp(
          title: 'reafy',
          debugShowCheckedModeBanner: false,
          theme: new ThemeData(
            fontFamily: 'NanumSquareRound',
          ),
          initialBinding: InitBinding(), // 앱 실행시 컨트롤러 다 접근 가능하도록
          home: const Root(),
        ));
  }
}

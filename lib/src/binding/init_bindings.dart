import 'package:reafy_front/src/controller/books_controller.dart';
import 'package:reafy_front/src/controller/bottom_nav_controller.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/controller/connectivity_controller.dart';
import 'package:reafy_front/src/controller/intro_controller.dart';
import 'package:reafy_front/src/provider/stopwatch_provider.dart';

///필요한 컨트롤러를 한번에 올려줌
class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavController(), permanent: true); // 앱 종료 전까지 true
    Get.lazyPut(() => BookshelfController());
    Get.put(IntroController(), permanent: true);
    Get.put(StopwatchProvider(), permanent: true);
    Get.put(ConnectivityController(), permanent: true);
  }
}

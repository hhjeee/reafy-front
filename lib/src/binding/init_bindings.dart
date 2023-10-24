import 'package:reafy_front/src/controller/auth_controller.dart';
import 'package:reafy_front/src/controller/bottom_nav_controller.dart';
import 'package:get/get.dart';

///필요한 컨트롤러를 한번에 올려줌
class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavController(), permanent: true); // 앱 종료 전까지 true
    //Get.put(AuthController(), permanent: true);
  }

  
}
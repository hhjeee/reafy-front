/*import 'package:get/get.dart';
import 'dart:async';

import 'package:reafy_front/src/components/stop_dialog.dart';

class StopWatchController extends GetxController {
  var value = false.obs;
  var stopwatchSeconds = 0.obs;

  void startStopwatch() {
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      stopwatchSeconds.value++;
    });
  }

  void stopStopwatch() {
    // Timer를 정지시키고 stopwatchSeconds를 초기화합니다.
    stopwatchSeconds.value = 0;
  }

  void toggleSwitch() {
    value.value = !value.value;
    if (value.value) {
      startStopwatch();
    } else {
      stopStopwatch();
      
    }
  }
}
*/
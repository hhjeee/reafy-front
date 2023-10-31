import 'package:get/get.dart';

class IntroController extends GetxController {
  var currentPage = 0.obs;

  void changePage(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < 3) {
      currentPage.value++;
    }
  }
}

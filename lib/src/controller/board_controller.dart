import 'package:get/get.dart';
import 'package:reafy_front/src/models/memo.dart';
import 'package:reafy_front/src/repository/memo_repository.dart';

class BoardController extends GetxController {
  RxList<Memo> memoList = <Memo>[].obs;

  @override
  void onInit() {
    print('aaaa');
    super.onInit();
    _loadFeedList();
  }

  void _loadFeedList() async {
    try {
      var memoDataList = await getMemoList(1);
      var loadedMemoList =
          memoDataList.map((json) => Memo.fromJson(json)).toList();
      memoList.addAll(loadedMemoList);
      print(loadedMemoList);
    } catch (e) {
      print('Error loading memo list: $e');
    }
  }
}

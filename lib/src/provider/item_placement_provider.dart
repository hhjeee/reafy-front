import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/repository/item_repository.dart';

class Item {
  String imagePath;
  int selectedIndex;
  int selectedId;

  Item({
    required this.imagePath,
    required this.selectedIndex,
    required this.selectedId,
  });
}

class ItemPlacementProvider extends ChangeNotifier {
  //사용자 이전 배치 값으로 받아오기
  //activation true인 애들
  //bookshelf, clock, otheritems, rug, window

  List<int> activatedItemIds = [];

  Item bookshelf = Item(
    imagePath: 'assets/images/nothing.png',
    selectedIndex: 0,
    selectedId: 0,
  );
  Item clock = Item(
    imagePath: 'assets/images/nothing.png',
    selectedIndex: 0,
    selectedId: 20,
  );
  Item others = Item(
    imagePath: 'assets/images/nothing.png',
    selectedIndex: 0,
    selectedId: 40,
  );
  Item rug = Item(
    imagePath: 'assets/images/nothing.png',
    selectedIndex: 0,
    selectedId: 60,
  );
  Item window = Item(
    imagePath: 'assets/images/nothing.png',
    selectedIndex: 0,
    selectedId: 80,
  );

  ItemPlacementProvider() {
    fetchDataAndUseActivatedItems();
  }

  Future<void> fetchDataAndUseActivatedItems() async {
    try {
      activatedItemIds = await getActivatedOwnedItemIds();
      print(activatedItemIds);
      updateItemValues();
      updateInitialValues();
    } catch (e) {
      print('Error during data fetching: $e');
    }
  }

  void updateItemValues() {
    int bookshelfId = -1;
    int clockId = -1;
    int othersId = -1;
    int rugId = -1;
    int windowId = -1;

    for (var id in activatedItemIds) {
      switch (id ~/ 20) {
        case 0:
          bookshelfId = id;
          break;
        case 1:
          clockId = id;
          break;
        case 2:
          othersId = id;
          break;
        case 3:
          rugId = id;
          break;
        case 4:
          windowId = id;
          break;
        default:
      }
    }

    bookshelf = (bookshelfId != -1)
        ? createItem(bookshelfId)
        : Item(
            imagePath: 'assets/images/nothing.png',
            selectedIndex: 0,
            selectedId: 0,
          );
    clock = (clockId != -1)
        ? createItem(clockId)
        : Item(
            imagePath: 'assets/images/nothing.png',
            selectedIndex: 0,
            selectedId: 20,
          );
    others = (othersId != -1)
        ? createItem(othersId)
        : Item(
            imagePath: 'assets/images/nothing.png',
            selectedIndex: 0,
            selectedId: 40,
          );
    rug = (rugId != -1)
        ? createItem(rugId)
        : Item(
            imagePath: 'assets/images/nothing.png',
            selectedIndex: 0,
            selectedId: 60,
          );
    window = (windowId != -1)
        ? createItem(windowId)
        : Item(
            imagePath: 'assets/images/nothing.png',
            selectedIndex: 0,
            selectedId: 80,
          );

    notifyListeners();
  }

  Item createItem(int itemId) {
    ItemData itemData =
        itemDataList.firstWhere((item) => item.itemId == itemId);

    return Item(
      imagePath: itemData.imagePath,
      selectedIndex: itemData.index,
      selectedId: itemId,
    );
  }

  // //초기값 저장 변수 (저장 안하고 나가면 원상복구되게)
  String initialBookshelfImagePath = 'assets/images/nothing.png';
  int initialSelectedBookshelfIndex = 0;
  int initialSelectedBookshelfId = 0;
  String initialClockImagePath = 'assets/images/nothing.png';
  int initialSelectedClockIndex = 0;
  int initialSelectedClockId = 20;
  String initialOthersImagePath = 'assets/images/nothing.png';
  int initialSelectedOthersIndex = 0;
  int initialSelectedOthersId = 40;
  String initialRugImagePath = 'assets/images/nothing.png';
  int initialSelectedRugIndex = 0;
  int initialSelectedRugId = 60;
  String initialWindowImagePath = 'assets/images/nothing.png';
  int initialSelectedWindowIndex = 0;
  int initialSelectedWindowId = 80;

  void updateInitialValues() {
    int bookshelfId = -1;
    int clockId = -1;
    int othersId = -1;
    int rugId = -1;
    int windowId = -1;

    for (var id in activatedItemIds) {
      switch (id ~/ 20) {
        case 0:
          bookshelfId = id;
          break;
        case 1:
          clockId = id;
          break;
        case 2:
          othersId = id;
          break;
        case 3:
          rugId = id;
          break;
        case 4:
          windowId = id;
          break;
        default:
      }
    }

    // bookshelf 초기값 업데이트
    ItemData initialBookshelfData = itemDataList.firstWhere(
      (item) => item.itemId == bookshelfId,
      orElse: () => ItemData(
        itemId: -1,
        imagePath: 'assets/images/nothing.png',
        text: '선택 안함',
        index: 0,
      ),
    );

    initialBookshelfImagePath = initialBookshelfData.imagePath;
    initialSelectedBookshelfIndex = initialBookshelfData.index;
    initialSelectedBookshelfId = initialBookshelfData.itemId;

    // clock 초기값 업데이트
    ItemData initialClockData = itemDataList.firstWhere(
      (item) => item.itemId == clockId,
      orElse: () => ItemData(
        itemId: -1,
        imagePath: 'assets/images/nothing.png',
        text: '선택 안함',
        index: 0,
      ),
    );
    initialClockImagePath = initialClockData.imagePath;
    initialSelectedClockIndex = initialClockData.index;
    initialSelectedClockId = initialClockData.itemId;

    // others 초기값 업데이트
    ItemData initialOthersData = itemDataList.firstWhere(
      (item) => item.itemId == othersId,
      orElse: () => ItemData(
        itemId: -1,
        imagePath: 'assets/images/nothing.png',
        text: '선택 안함',
        index: 0,
      ),
    );

    initialOthersImagePath = initialOthersData.imagePath;
    initialSelectedOthersIndex = initialOthersData.index;
    initialSelectedOthersId = initialOthersData.itemId;

    // rug 초기값 업데이트
    ItemData initialRugData = itemDataList.firstWhere(
      (item) => item.itemId == rugId,
      orElse: () => ItemData(
        itemId: -1,
        imagePath: 'assets/images/nothing.png',
        text: '선택 안함',
        index: 0,
      ),
    );

    initialRugImagePath = initialRugData.imagePath;
    initialSelectedRugIndex = initialRugData.index;
    initialSelectedRugId = initialRugData.itemId;

    // window 초기값 업데이트
    ItemData initialWindowData = itemDataList.firstWhere(
      (item) => item.itemId == windowId,
      orElse: () => ItemData(
        itemId: -1,
        imagePath: 'assets/images/nothing.png',
        text: '선택 안함',
        index: 0,
      ),
    );
    initialWindowImagePath = initialWindowData.imagePath;
    initialSelectedWindowIndex = initialWindowData.index;
    initialSelectedWindowId = initialWindowData.itemId;

    notifyListeners();
  }

  void updateBookshelfData(int newId, int newIndex, String newPath) {
    bookshelf.selectedId = newId;
    bookshelf.selectedIndex = newIndex;
    bookshelf.imagePath = newPath;

    notifyListeners();
  }

  int getSelectedBookshelfIndex() {
    return bookshelf.selectedIndex;
  }

  void updateClockData(int newId, int newIndex, String newPath) {
    clock.selectedId = newId;
    clock.selectedIndex = newIndex;
    clock.imagePath = newPath;

    notifyListeners();
  }

  int getSelectedClockIndex() {
    return clock.selectedIndex;
  }

  void updateOthersData(int newId, int newIndex, String newPath) {
    others.selectedId = newId;
    others.selectedIndex = newIndex;
    others.imagePath = newPath;

    notifyListeners();
  }

  int getSelectedOthersIndex() {
    return others.selectedIndex;
  }

  void updateRugData(int newId, int newIndex, String newPath) {
    rug.selectedId = newId;
    rug.selectedIndex = newIndex;
    rug.imagePath = newPath;

    notifyListeners();
  }

  int getSelectedRugIndex() {
    return rug.selectedIndex;
  }

  void updateWindowData(int newId, int newIndex, String newPath) {
    window.selectedId = newId;
    window.selectedIndex = newIndex;
    window.imagePath = newPath;

    notifyListeners();
  }

  int getSelectedWindowIndex() {
    return window.selectedIndex;
  }

  // 초기값 복구 메소드
  void restoreInitialValues() {
    bookshelf = Item(
      imagePath: initialBookshelfImagePath,
      selectedIndex: initialSelectedBookshelfIndex,
      selectedId: initialSelectedBookshelfId,
    );
    clock = Item(
      imagePath: initialClockImagePath,
      selectedIndex: initialSelectedClockIndex,
      selectedId: initialSelectedClockId,
    );
    others = Item(
      imagePath: initialOthersImagePath,
      selectedIndex: initialSelectedOthersIndex,
      selectedId: initialSelectedOthersId,
    );
    rug = Item(
      imagePath: initialRugImagePath,
      selectedIndex: initialSelectedRugIndex,
      selectedId: initialSelectedRugId,
    );
    window = Item(
      imagePath: initialWindowImagePath,
      selectedIndex: initialSelectedWindowIndex,
      selectedId: initialSelectedWindowId,
    );

    notifyListeners();
  }
}

class ItemData {
  final int itemId;
  final String imagePath;
  final String text;
  final int index;

  ItemData(
      {required this.itemId,
      required this.imagePath,
      required this.text,
      required this.index});
}

List<ItemData> itemDataList = [
  //bookshelf - 0~19
  ItemData(
      itemId: 0,
      imagePath: 'assets/images/nothing.png',
      text: '선택 안함',
      index: 0),
  ItemData(
      itemId: 1,
      imagePath: 'assets/images/nothing.png',
      text: '베이직 책장',
      index: 1),
  ItemData(
      itemId: 2,
      imagePath: 'assets/images/bookshelf1.png',
      text: '사다리 책장',
      index: 2),
  ItemData(
      itemId: 3,
      imagePath: 'assets/images/nothing.png',
      text: '수집가 책장',
      index: 3),

  //clock 20 ~ 39
  ItemData(
      itemId: 20,
      imagePath: 'assets/images/nothing.png',
      text: '선택 안함',
      index: 0),
  ItemData(
    itemId: 21,
    imagePath: 'assets/images/items/clock_clover.png',
    text: '클로버 시계',
    index: 1,
  ),
  ItemData(
      itemId: 22,
      imagePath: 'assets/images/items/clock_star.png',
      text: '별 시계',
      index: 2),
  ItemData(
      itemId: 23,
      imagePath: 'assets/images/items/clock_simple.png',
      text: '심플 시계',
      index: 3),
  ItemData(
      itemId: 24,
      imagePath: 'assets/images/items/clock_panda.png',
      text: '판다 시계',
      index: 4),
  ItemData(
      itemId: 25,
      imagePath: 'assets/images/items/clock_socks.png',
      text: '양말 시계',
      index: 5),

  //others 40~59
  ItemData(
      itemId: 40,
      imagePath: 'assets/images/nothing.png',
      text: '선택 안함',
      index: 0),
  ItemData(
      itemId: 41,
      imagePath: 'assets/images/items/item_flower.png',
      text: '꽃 의자',
      index: 1),
  ItemData(
      itemId: 42,
      imagePath: 'assets/images/items/item_mushroom.png',
      text: '버섯 테이블',
      index: 2),
  ItemData(
      itemId: 43,
      imagePath: 'assets/images/items/item_bear.png',
      text: '곰 인형',
      index: 3),
  ItemData(
      itemId: 44,
      imagePath: 'assets/images/items/item_tree.png',
      text: '트리',
      index: 4),
  ItemData(
      itemId: 45,
      imagePath: 'assets/images/items/item_light.png',
      text: '달빛 전구',
      index: 5),
  ItemData(
      itemId: 46,
      imagePath: 'assets/images/items/item_bamboo.png',
      text: '선인장 화분',
      index: 6),

  //rug 60~79
  ItemData(
      itemId: 60,
      imagePath: 'assets/images/nothing.png',
      text: '선택 안함',
      index: 0),
  ItemData(
      itemId: 61,
      imagePath: 'assets/images/items/rug_smile.png',
      text: '스마일 러그',
      index: 1),
  ItemData(
      itemId: 62,
      imagePath: 'assets/images/items/rug_cloud.png',
      text: '구름 러그',
      index: 2),
  ItemData(
      itemId: 63,
      imagePath: 'assets/images/items/rug_leaf.png',
      text: '나뭇잎 러그',
      index: 3),

  //window 80~99
  ItemData(
      itemId: 80,
      imagePath: 'assets/images/nothing.png',
      text: '선택 안함',
      index: 0),
  ItemData(
      itemId: 81,
      imagePath: 'assets/images/items/window1.png',
      text: '창문1',
      index: 1),
  ItemData(
      itemId: 82,
      imagePath: 'assets/images/items/window2.png',
      text: '창문2',
      index: 2),
  ItemData(
      itemId: 83,
      imagePath: 'assets/images/items/window3.png',
      text: '창문3',
      index: 3),
  ItemData(
      itemId: 84,
      imagePath: 'assets/images/items/window4.png',
      text: '창문4',
      index: 4),
  ItemData(
      itemId: 85,
      imagePath: 'assets/images/items/window5.png',
      text: '창문5',
      index: 5),
  ItemData(
      itemId: 86,
      imagePath: 'assets/images/nothing.png',
      text: '창문6',
      index: 6),
];

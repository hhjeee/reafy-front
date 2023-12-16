import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemPlacementProvider extends ChangeNotifier {
  //사용자 이전 배치 값으로 받아오기
  String bookshelfImagePath = 'assets/images/nothing.png';
  String clockImagePath = 'assets/images/nothing.png';
  String othersImagePath = 'assets/images/nothing.png';
  String rugImagePath = 'assets/images/nothing.png';
  String windowImagePath = 'assets/images/nothing.png';
  int selectedBookshelfIndex = 0;
  int selectedClockIndex = 0;
  int selectedOthersIndex = 0;
  int selectedRugIndex = 0;
  int selectedWindowIndex = 0;

  //값 저장 변수 (저장 안하고 나가면 원상복구되게)
  String initialBookshelfImagePath = 'assets/images/nothing.png';
  int initialSelectedBookshelfIndex = 0;
  String initialClockImagePath = 'assets/images/nothing.png';
  int initialSelectedClockIndex = 0;
  String initialOthersImagePath = 'assets/images/nothing.png';
  int initialSelectedOthersIndex = 0;
  String initialRugImagePath = 'assets/images/nothing.png';
  int initialSelectedRugIndex = 0;
  String initialWindowImagePath = 'assets/images/nothing.png';
  int initialSelectedWindowIndex = 0;

  ItemPlacementProvider() {
    // 초기값 저장
    initialBookshelfImagePath = bookshelfImagePath;
    initialSelectedBookshelfIndex = selectedBookshelfIndex;
    initialClockImagePath = clockImagePath;
    initialSelectedClockIndex = selectedClockIndex;
    initialOthersImagePath = othersImagePath;
    initialSelectedOthersIndex = selectedOthersIndex;
    initialRugImagePath = rugImagePath;
    initialSelectedRugIndex = selectedRugIndex;
    initialWindowImagePath = windowImagePath;
    initialSelectedWindowIndex = selectedWindowIndex;
  }

  void updateSelectedBookshelfIndex(int newIndex) {
    selectedBookshelfIndex = newIndex;
    notifyListeners();
  }

  void updateBookshelfImagePath(String newPath) {
    bookshelfImagePath = newPath;
    notifyListeners();
  }

  int getSelectedBookshelfIndex() {
    return selectedBookshelfIndex;
  }

  void updateSelectedClockIndex(int newIndex) {
    selectedClockIndex = newIndex;
    notifyListeners();
  }

  void updateClockImagePath(String newPath) {
    clockImagePath = newPath;
    notifyListeners();
  }

  int getSelectedClockIndex() {
    return selectedClockIndex;
  }

  void updateSelectedOthersIndex(int newIndex) {
    selectedOthersIndex = newIndex;
    notifyListeners();
  }

  void updateOthersImagePath(String newPath) {
    othersImagePath = newPath;
    notifyListeners();
  }

  int getSelectedOthersIndex() {
    return selectedOthersIndex;
  }

  void updateSelectedRugIndex(int newIndex) {
    selectedRugIndex = newIndex;
    notifyListeners();
  }

  void updateRugImagePath(String newPath) {
    rugImagePath = newPath;
    notifyListeners();
  }

  int getSelectedRugIndex() {
    return selectedRugIndex;
  }

  void updateSelectedWindowIndex(int newIndex) {
    selectedWindowIndex = newIndex;
    notifyListeners();
  }

  void updateWindowImagePath(String newPath) {
    windowImagePath = newPath;
    notifyListeners();
  }

  int getSelectedWindowIndex() {
    return selectedWindowIndex;
  }

  // 초기값 복구 메소드
  void restoreInitialValues() {
    bookshelfImagePath = initialBookshelfImagePath;
    selectedBookshelfIndex = initialSelectedBookshelfIndex;
    clockImagePath = initialClockImagePath;
    selectedClockIndex = initialSelectedClockIndex;
    othersImagePath = initialOthersImagePath;
    selectedOthersIndex = initialSelectedOthersIndex;
    rugImagePath = initialRugImagePath;
    selectedRugIndex = initialSelectedRugIndex;
    windowImagePath = initialWindowImagePath;
    selectedWindowIndex = initialSelectedWindowIndex;
    notifyListeners();
  }

  // 아이템 배치 저장 -> 값 업데이트
  void updateInitialValues(
      String newInitialClockImagePath, int newInitialSelectedClockIndex) {
    initialClockImagePath = newInitialClockImagePath;
    initialSelectedClockIndex = newInitialSelectedClockIndex;
  }
}

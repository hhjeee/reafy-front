import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/repository/memo_repository.dart';
import 'package:reafy_front/src/models/memo.dart';
import 'package:collection/collection.dart';

class MemoProvider with ChangeNotifier {
  List<Memo> _memos = [];
  List<Memo> _memoList = [];
  int _totalPages = 0;

  List<Memo> get memos => _memos;
  List<Memo> get memoList => _memoList;
  int get totalPages => _totalPages;

  Future<void> loadMemosByBookId(int bookId, int page) async {
    try {
      MemoResDto memoRes = await getMemoListByBookId(bookId, page);
      _memos = memoRes.items;
      _totalPages = memoRes.totalPages;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> loadAllMemos(int page) async {
    try {
      MemoResDto memoRes = await getMemoList(page);
      _memoList = memoRes.items;
      _totalPages = memoRes.totalPages;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Memo? findMemoById(int memoId) {
    return _memoList.firstWhereOrNull((memo) => memo.memoId == memoId);
  }

  void addBookMemo(Memo memo) {
    _memos.insert(0, memo);
    notifyListeners();
  }

  void addBoardMemo(Memo memo) {
    _memoList.insert(0, memo);
    notifyListeners();
  }

  Future<void> deleteMemo(int memoId) async {
    try {
      await deleteMemoById(memoId);

      int removedMemoIndex = _memos.indexWhere((memo) => memo.memoId == memoId);
      int removedMemoListIndex =
          _memoList.indexWhere((memo) => memo.memoId == memoId);

      if (removedMemoIndex != -1) {
        _memos.removeAt(removedMemoIndex);
      }
      if (removedMemoListIndex != -1) {
        _memoList.removeAt(removedMemoListIndex);
        notifyListeners();
      }
    } catch (e) {
      print("메모 삭제 중 오류 발생: $e");
    }
  }

  Future<void> updateBookMemo(Memo updatedMemo) async {
    try {
      int indexInMemos =
          _memos.indexWhere((memo) => memo.memoId == updatedMemo.memoId);
      int indexInList =
          _memoList.indexWhere((memo) => memo.memoId == updatedMemo.memoId);

      bool isUpdated = false;

      if (indexInMemos != -1) {
        _memos[indexInMemos] = updatedMemo;
        isUpdated = true;
      }
      if (indexInList != -1) {
        _memoList[indexInList] = updatedMemo;
        isUpdated = true;
      }

      if (isUpdated) {
        notifyListeners();
      }
    } catch (e) {
      print("메모 수정 중 오류 발생: $e");
    }
  }
}

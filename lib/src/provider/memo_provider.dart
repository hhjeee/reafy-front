import 'package:flutter/material.dart';
import 'package:reafy_front/src/repository/memo_repository.dart';
import 'package:reafy_front/src/models/memo.dart';

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
      _memos.removeWhere((memo) => memo.memoId == memoId);
      _memoList.removeWhere((memo) => memo.memoId == memoId);
      notifyListeners();
    } catch (e) {
      print("메모 삭제 중 오류 발생: $e");
    }
  }

  Future<void> updateBookMemo(Memo updatedMemo) async {
    try {
      int indexInMemos =
          _memos.indexWhere((memo) => memo.memoId == updatedMemo.memoId);
      if (indexInMemos != -1) {
        _memos[indexInMemos] = updatedMemo;
        notifyListeners();
      }
      int indexInList =
          _memoList.indexWhere((memo) => memo.memoId == updatedMemo.memoId);
      if (indexInList != -1) {
        _memoList[indexInList] = updatedMemo;
      }

      if (indexInMemos != -1 || indexInList != -1) {
        notifyListeners();
      }
    } catch (e) {
      print("메모 수정 중 오류 발생: $e");
    }
  }
}

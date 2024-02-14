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

  void addMemoBoard(Memo memo) {
    _memoList.add(memo);
    notifyListeners();
  }

  Future<void> deleteMemo(int memoId) async {
    try {
      await deleteMemoById(memoId);
      _memos.removeWhere((memo) => memo.memoId == memoId);
      notifyListeners();
    } catch (e) {
      print("메모 삭제 중 오류 발생: $e");
    }
  }

  void updateMemo(Memo updatedMemo) {
    int index = _memos.indexWhere((memo) => memo.memoId == updatedMemo.memoId);
    if (index != -1) {
      _memos[index] = updatedMemo;
      notifyListeners();
    }
  }
}

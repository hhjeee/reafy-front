import 'dart:async';

import 'package:flutter/material.dart';

class StopwatchProvider extends ChangeNotifier {
  Timer? _timer;
  bool _isRunning = false;
  int _countdownsec = 10;
  int _remainingsec = 0;
  late int _seconds = 0;
  int _itemCnt = 0;
  bool _isfull = false;
  bool _animationapplied = false;

  String _elapsedTime = '00:00:00';
  String _remainingTime = '00:00';

  bool get isRunning => _isRunning;
  int get remainingSec => _remainingsec;
  int get countdownSec => _countdownsec;
  int get itemCnt => _itemCnt;
  bool get isFull => _isfull;
  bool get animationApplied => _animationapplied;

  String get elapsedTimeString => _elapsedTime;
  String get remainTimeString => _remainingTime;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void setTimer(int sec) {
    _countdownsec = sec;
    notifyListeners();
  }

  void start() {
    _isRunning = true;
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      _seconds++;
      _elapsedTime = formatTime(_seconds, false);
      updateRemainingTime();
      notifyListeners();
    });
  }

  void applyAnimation() {
    _animationapplied = true;
    notifyListeners();
  }

  void pause() {
    if (_isRunning) {
      _timer?.cancel();
      _isRunning = false;
    }
    _animationapplied = false;
    notifyListeners();
  }

  void reset() {
    _timer?.cancel();
    _seconds = 0;
    _isRunning = false;
    notifyListeners();
  }

  String formatTime(int seconds, bool shortversion) {
    //int seconds = (milliseconds / 1000).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();
    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return shortversion
        ? '$minutesStr:$secondsStr'
        : '$hoursStr:$minutesStr:$secondsStr';
  }

  void updateRemainingTime() {
    _remainingsec = _countdownsec - _seconds;
    if (_remainingsec == 0) {
      incrementItemCount();
      _remainingsec = _countdownsec;
    }

    _remainingTime = formatTime(_remainingsec, true);
    notifyListeners();
  }

  void updateIsRunning(bool value) {
    _isRunning = value;
    print("_isRunning $_isRunning");
    notifyListeners();
  }

  void updateElapsedTime(String value) {
    _elapsedTime = value;
    notifyListeners();
  }

  void incrementItemCount() {
    if (_itemCnt < 6) {
      _itemCnt += 1;
    }
    if (_itemCnt == 6) {
      _isfull = true;
    }
    notifyListeners();
  }

  void decreaseItemCount() {
    if (_itemCnt > 0) {
      _itemCnt -= 1;
      _isfull = false;
      notifyListeners();
    }
  }
}




/*
class StopwatchProvider extends GetxController {
  var _isRunning = false.obs;
  var _elapsedTime = '00:00:00'.obs;
  var _remainingTime = '10:00'.obs;

  var _itemCnt = 0.obs;
  var _isFull = false.obs;

  bool get isRunning => _isRunning.value;
  String get elapsedTime => _elapsedTime.value;
  String get remainingTime => _remainingTime.value;

  int get itemCnt => _itemCnt.value;
  bool get isFull => _isFull.value;

  void updateIsRunning(bool value) {
    _isRunning.value = value;
    print("_isRunning $_isRunning");
  }

  void updateElapsedTime(String value) {
    _elapsedTime.value = value;
  }

  void incrementItemCount() {
    if (_itemCnt.value < 6) {
      _itemCnt.value += 1;
    }
    if (_itemCnt.value == 6) {
      _isFull.value = true;
    }
  }

  void decreaseItemCount() {
    if (_itemCnt.value > 0) {
      _itemCnt.value -= 1;
      _isFull.value = false;
    }
  }
}*/

import 'dart:async';
import 'package:flutter/material.dart';

enum Status { running, paused, stopped }

class StopwatchProvider extends ChangeNotifier {
  //Timer? _timer;

  late Status _status = Status.stopped;

  bool _isRunning = false;
  int _countdownsec = 10;
  int _remainingsec = 0;
  late int _seconds = 0;
  int _itemCnt = 0;
  bool _isfull = false;
  //bool _animationapplied = false;

  String _elapsedTime = '00:00:00';
  String _remainingTime = '00:00';

  Status get status => _status;
  bool get isRunning => _isRunning;
  int get remainingSec => _remainingsec;
  int get countdownSec => _countdownsec;
  int get itemCnt => _itemCnt;
  bool get isFull => _isfull;
  //bool get animationApplied => _animationapplied;

  String get elapsedTimeString => _elapsedTime;
  String get remainTimeString => _remainingTime;

  //final GiftProvider giftProvider;
  //StopwatchProvider(this.giftProvider);

  @override
  void dispose() {
    //_timer?.cancel();
    super.dispose();
  }

  void setTimer(int sec) {
    _countdownsec = sec;
    //notifyListeners();
  }

  void runStopWatch() async {
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      switch (_status) {
        case Status.paused:
          t.cancel();
          break;

        case Status.stopped:
          t.cancel();
          break;

        case Status.running:
          _seconds++;
          updateRemainingTime();
          _elapsedTime = formatTime(_seconds, false);

          if (_remainingsec <= 0) {
            incrementItemCount();
            notifyListeners();

            _remainingsec = _countdownsec; // Reset the countdown
            if (_itemCnt >= 6) {
              _isfull = true;
              notifyListeners();
              //print("[*] 대나무 만땅");
            }
          }
          notifyListeners();

          break;
      }
    });
  }

///// stopped -> running
  void run() {
    // stopped -> running
    _status = Status.running;
    print("RUN ! : $_seconds");
    runStopWatch();
    //if (_isRunning) return;
    _isRunning = true;
    notifyListeners();

/*
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      _seconds++;
      _elapsedTime = formatTime(_seconds, false);
      updateRemainingTime();
      notifyListeners();
    });*/
  }

// running -> paused
  void pause() {
    _status = Status.paused;
    print("PAUSED ! : $_seconds");
    _isRunning = false;
    notifyListeners();
  }

  // running -> stopped
  // paused -> stopped
  void stop() {
    _status = Status.stopped;
    print("STOPPED ! : $_seconds");
    _remainingsec = _countdownsec;
    updateRemainingTime();

    //notifyListeners();
    /*
    if (_isRunning) {
      _timer?.cancel();
      _isRunning = false;
    }*/
    //_animationapplied = false;
    notifyListeners();
  }

// paused -> running
  void resume() {
    print("RESUMED ! : $_seconds");
    run(); // 상태 변경됨 -> running
  }
/*
  void reset() {
    _timer?.cancel();
    _seconds = 0;
    _isRunning = false;
    notifyListeners();
  }

*/

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
    //if (_isRunning) {
    _remainingsec = _countdownsec - _seconds % _countdownsec;
    //print("$_remainingsec");
    if (_remainingsec == 1) {
      incrementItemCount();
      _remainingsec = _countdownsec;
      notifyListeners();
      //print("$_remainingsec  updated");
    }

    _remainingTime = formatTime(_remainingsec, true);
    notifyListeners();
  }
/*
  void updateIsRunning(bool value) {
    _isRunning = value;
    print("_isRunning $_isRunning");
    notifyListeners();
  }*/

  void updateElapsedTime(String value) {
    _elapsedTime = value;
    notifyListeners();
  }

  bool incrementItemCount() {
    if (_itemCnt < 6) {
      _itemCnt += 1;
      print("[*] 대나무 생김 : $_itemCnt");
      return true;
    } else {
      _isfull = true;
    }
    notifyListeners();
    //print("[*] 대나무  : $_itemCnt");

    return false;
  }

  void decreaseItemCount() {
    if (_itemCnt > 0) {
      _itemCnt -= 1;
      _isfull = false;
      notifyListeners();
      print("[*] 대나무  줍줍 : $_itemCnt");
    }
  }
/*
  void applyAnimation() {
    _animationapplied = true;
    notifyListeners();
  }*/
}
/*
class GiftProvider extends ChangeNotifier {
  List<bool> giftVisibility = [false, false, false, false, false, false];

  void addGift() {
    for (int i = 0; i < giftVisibility.length; i++) {
      if (!giftVisibility[i]) {
        giftVisibility[i] = true;
        notifyListeners();
        break;
      }
    }
  }

  void removeGift(int index) {
    if (index >= 0 && index < giftVisibility.length) {
      giftVisibility[index] = false;
      notifyListeners();
    }
  }
}
*/
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

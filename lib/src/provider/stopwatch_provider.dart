import 'dart:async';
import 'package:flutter/material.dart';

enum Status { running, paused, stopped }

class StopwatchProvider extends ChangeNotifier with WidgetsBindingObserver {
  late Status _status = Status.stopped;
  int _seconds = 0;
  int _countdownsec = 10;
  int _remainingsec = 0;
  int _itemCnt = 0;
  bool _isfull = false;
  bool _addBamboo = false;
  String _elapsedTime = '00:00:00';
  String _remainingTime = '00:00';
  bool showBambooNotification = false;

  Status get status => _status;
  int get remainingSec => _remainingsec;
  int get countdownSec => _countdownsec;
  int get itemCnt => _itemCnt;
  bool get isFull => _isfull;
  bool get addBamboo => _addBamboo;
  String get elapsedTimeString => _elapsedTime;
  String get remainTimeString => _remainingTime;

  DateTime? _pausedTime;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    late int stoppedsec = _seconds;
    super.didChangeAppLifecycleState(state);
    //print('AppLifecycleState changed to: $state');

    switch (state) {
      case AppLifecycleState.detached:
        pause();
        // SEnd data to SERVER?
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.hidden:
        break;

      case AppLifecycleState.paused:
        late int stoppedsec = _seconds;
        _pausedTime = DateTime.now();
        stoppedsec = _seconds;

        notifyListeners();
        print("_pausedTime: $_pausedTime (${formatTime(stoppedsec, true)})");
        break;

      case AppLifecycleState.resumed:
        if (_pausedTime != null) {
          final DateTime now = DateTime.now();
          final int elapsedPausedTime = now.difference(_pausedTime!).inSeconds;
          _seconds = stoppedsec + elapsedPausedTime;
          _pausedTime = null;
          updateElapsedTime(_seconds);
          notifyListeners();
          print("resumed : $elapsedPausedTime (${formatTime(_seconds, true)})");
        }

        break;

      default:
    }
    notifyListeners();
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
          updateElapsedTime(_seconds);

          if (_remainingsec <= 0) {
            bool added = incrementItemCount();
            if (added) {
              //call `regenerateBamboo` from here
              //incrementItemCount();
            }
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
    runStopWatch();
    notifyListeners();
  }

// running -> paused
  void pause() {
    _status = Status.paused;
    print("PAUSED ! : $_seconds");
    notifyListeners();
  }

  // running -> stopped
  // paused -> stopped
  void stop() {
    _status = Status.stopped;
    print("STOPPED ! : $_seconds");
    //_remainingsec = _countdownsec;
    _seconds = 0;
    updateRemainingTime();
    notifyListeners();
  }

// paused -> running
  void resume() {
    print("RESUMED ! : $_seconds");
    run(); // 상태 변경됨 -> running
  }

  String formatTime(int seconds, bool shortversion) {
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
    _remainingsec = _countdownsec - _seconds % _countdownsec;
    //print("$_remainingsec");
    if (_remainingsec == 1) {
      incrementItemCount();
      _remainingsec = _countdownsec;
    }
    _remainingTime = formatTime(_remainingsec, true);
    notifyListeners();
  }

  void updateElapsedTime(int sec) {
    _elapsedTime = formatTime(sec, false);
    notifyListeners();
  }

  bool incrementItemCount() {
    if (_itemCnt < 6) {
      _itemCnt += 1;
      print("[*] 대나무 생김 : $_itemCnt");
      showBambooNotification = true;
      notifyListeners();
      return true;
    } else {
      _isfull = true;
    }
    notifyListeners();
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
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:reafy_front/src/repository/timer_repository.dart';

enum Status { running, paused, stopped }

class StopwatchProvider extends ChangeNotifier with WidgetsBindingObserver {
  Status _status = Status.stopped;
  Duration _currentDuration = Duration.zero;
  Timer? _timer;
  DateTime? _lastTimeRecorded;
  int _defaultTime = 15 * 60;
  int _remainingsec = 0; //
  int _itemCnt = 0;
  bool _isfull = false;
  bool _addBamboo = false;
  bool showBambooNotification = false;

  int get remainingSec => _remainingsec;
  int get itemCnt => _itemCnt;
  bool get isFull => _isfull;
  bool get addBamboo => _addBamboo;
  String get remainTimeString => formatTime(_remainingsec, true);
  String get elapsedPausedTime => elapsedPausedTime;
  Status get status => _status;
  String get elapsedTimeString => formatTime(_currentDuration.inSeconds, false);

  StopwatchProvider() {
    print("StopwatchProvider created");
    WidgetsBinding.instance.addObserver(this); // 생명주기 감지자 등록
    fetchTimer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // 생명주기 감지자 제거
    _timer?.cancel(); // 타이머 정지
    super.dispose();
  }

  Future<void> fetchTimer() async {
    try {
      // Fetch timer data from server
      Map<String, dynamic> data = await getRemainingTime();
      debugPrint("data['timer'] ${data['timer']}");
      _remainingsec = data['timer'] as int? ?? _defaultTime;
    } catch (e) {
      print('Error fetching user timer data: $e');
      _remainingsec = _defaultTime; // Default to 15 minutes if fetching fails
    }
    notifyListeners(); // Notify listeners to update UI
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint("Lifecycle state changed to: $state at ${DateTime.now()}");

    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.paused:
        // 앱이 백그라운드로 이동했을 때
        if (_status == Status.running) {
          _lastTimeRecorded = DateTime.now(); // 현재 시간 기록
          pause(); // 자동으로 일시정지
        }
        break;
      case AppLifecycleState.resumed:
        // 앱으로 다시 돌아왔을 때
        if (_lastTimeRecorded != null) {
          var timeDifference = DateTime.now().difference(_lastTimeRecorded!);
          _currentDuration += timeDifference; // 시간 차이만큼 추가

          _remainingsec -= timeDifference.inSeconds; // 남은 시간에서 경과된 시간 빼기
          // 남은 시간이 0 이하로 떨어진 경우 대나무 수 증가
          while (_remainingsec <= 0) {
            incrementItemCount(); // 대나무 수 증가
            _remainingsec += _defaultTime; // 남은 시간 초기화 (다음 타이머로)
          }

          _lastTimeRecorded = null;
          if (_status == Status.paused) {
            resume(); // 일시정지된 상태였다면 다시 시작
          }
          debugPrint("Paused For: ${timeDifference}");
        }
        break;
      case AppLifecycleState.detached:
        stop();
        break;
      default:
        saveRemainingTime(_remainingsec);
        break;
    }
    notifyListeners();
  }

  void run() {
    if (_status != Status.running) {
      _status = Status.running;
      _timer?.cancel(); // 기존 타이머가 있다면 취소
      _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
        _currentDuration = _currentDuration + Duration(seconds: 1);
        _remainingsec = _remainingsec - Duration(seconds: 1).inSeconds;
        if (_remainingsec == 1) {
          incrementItemCount();
          _remainingsec = _defaultTime; // Reset timer
        }
        notifyListeners();
      });
    }
  }

  Future<void> stop() async {
    print("STOP");
    if (_timer != null) {
      _timer!.cancel(); // 타이머를 정지
      _timer = null;
    }
    saveRemainingTime(_remainingsec);
    _status = Status.stopped;
    _currentDuration = Duration.zero;
    notifyListeners();
  }

  void pause() {
    print("PAUSE");
    if (_timer != null) {
      _timer!.cancel(); // 타이머를 일시정지
      _timer = null;
    }
    saveRemainingTime(_remainingsec);
    _status = Status.paused;
    notifyListeners();
  }

  void resume() {
    if (_status == Status.paused) {
      run(); // 일시정지된 상태에서 실행
    }
  }

  void tapStopwatch(Status status) {
    print("tapStopwatch");
    switch (status) {
      case Status.paused:
        resume();
        // fetchTimerData();
        break;
      case Status.running:
        pause();
        // fetchTimerData();
        break;
      case Status.stopped:
        // fetchTimerData();
        run();
        break;
    }
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

  void hideBambooNotification() {
    showBambooNotification = false;
    notifyListeners();
  }

  void decreaseItemCount() {
    if (_itemCnt > 0) {
      _itemCnt -= 1;
      _isfull = false;
      notifyListeners();
      print("[*] 대나무  줍줍 : $_itemCnt");
    }
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
}

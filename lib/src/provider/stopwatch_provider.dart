import 'dart:async';
import 'package:flutter/material.dart';

enum Status { running, paused, stopped }

class StopwatchProvider extends ChangeNotifier with WidgetsBindingObserver {
  int _countdownsec = 15 * 60;
  int _remainingsec = 0;
  int _itemCnt = 0;
  bool _isfull = false;
  bool _addBamboo = false;
  String _elapsedTime = '00:00:00';
  String _remainingTime = '00:00';
  bool showBambooNotification = false;

//   DateTime? _pausedTime;

  int get remainingSec => _remainingsec;
  int get countdownSec => _countdownsec;
  int get itemCnt => _itemCnt;
  bool get isFull => _isfull;
  bool get addBamboo => _addBamboo;
  // String get elapsedTimeString => _elapsedTime;
  String get remainTimeString => _remainingTime;
  String get elapsedPausedTime => elapsedPausedTime;
//   Timer? _timer;
/////TODO: 필요한 변수만 남기고 지우기

  Status _status = Status.stopped;
  Duration _currentDuration = Duration.zero;
  Timer? _timer;
  DateTime? _lastTimeRecorded;

  Status get status => _status;
  String get elapsedTimeString =>
      _currentDuration.toString().split('.').first; // 시간을 HH:MM:SS 형식으로 표시

  StopwatchProvider() {
    print("StopwatchProvider created");
    WidgetsBinding.instance.addObserver(this); // 생명주기 감지자 등록
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // 생명주기 감지자 제거
    _timer?.cancel(); // 타이머 정지
    super.dispose();
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
        print("_currentDuration: ${_currentDuration}");
        break;
      case AppLifecycleState.resumed:
        // 앱으로 다시 돌아왔을 때
        if (_lastTimeRecorded != null) {
          var timeDifference = DateTime.now().difference(_lastTimeRecorded!);
          _currentDuration += timeDifference; // 시간 차이만큼 추가
          _lastTimeRecorded = null;
          if (_status == Status.paused) {
            resume(); // 일시정지된 상태였다면 다시 시작
          }

          debugPrint("Paused For: ${timeDifference}");
        }
        break;
      case AppLifecycleState.detached:
        //pause();
        stop();
        //TODO: 종료할 경우 리셋?
        break;
      default:
        break;
    }
    notifyListeners();
  }

  void run() {
    print("RUN");
    if (_status != Status.running) {
      _status = Status.running;
      _timer?.cancel(); // 기존 타이머가 있다면 취소
      _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
        _currentDuration = _currentDuration + Duration(seconds: 1);
        notifyListeners();
      });
    }
  }

  void stop() {
    print("STOP");
    if (_timer != null) {
      _timer!.cancel(); // 타이머를 정지
      _timer = null;
    }
    _status = Status.stopped;
    reset();
    notifyListeners();
  }

  void pause() {
    print("PAUSE");
    if (_timer != null) {
      _timer!.cancel(); // 타이머를 일시정지
      _timer = null;
    }
    _status = Status.paused;
    notifyListeners();
  }

  void resume() {
    if (_status == Status.paused) {
      run(); // 일시정지된 상태에서 실행
    }
  }

  void reset() {
    print("RESET! ");
    //RESET
    _currentDuration = Duration.zero;

    //TODO:updateRemainingTime();
    notifyListeners();
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
        run();
        // fetchTimerData();
        break;
    }
  }

  void updateRemainingTime() {
    _remainingsec = _countdownsec - _currentDuration.inSeconds % _countdownsec;
    if (_remainingsec == 1) {
      incrementItemCount();
      _remainingsec = _countdownsec;
    }
    _remainingTime = formatTime(_remainingsec, true);
    notifyListeners();
  }

  void updateElapsedTime(Duration duration) {
    _elapsedTime = formatTime(duration.inSeconds, false);
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

// class StopwatchProvider extends ChangeNotifier with WidgetsBindingObserver {
//   late Status _status = Status.stopped;
//   int seconds = 0;
//   String _state = ".";
//   int _countdownsec = 15 * 60;
//   int _remainingsec = 0;
//   int _itemCnt = 0;
//   bool _isfull = false;
//   bool _addBamboo = false;
//   String _elapsedTime = '00:00:00';
//   String _remainingTime = '00:00';
//   bool showBambooNotification = false;
//   DateTime? _pausedTime;

//   Status get status => _status;
//   int get remainingSec => _remainingsec;
//   int get countdownSec => _countdownsec;
//   int get itemCnt => _itemCnt;
//   bool get isFull => _isfull;
//   bool get addBamboo => _addBamboo;
//   String get elapsedTimeString => _elapsedTime;
//   String get remainTimeString => _remainingTime;
//   String get elapsedPausedTime => elapsedPausedTime;
//   String get state => _state;
//   Timer? _timer;

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _timer?.cancel(); // Cancel timer when disposing
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     super.didChangeAppLifecycleState(state);

//     switch (state) {
//       case AppLifecycleState.detached:
//         _state = "detached";
//       //break;
//       case AppLifecycleState.paused:
//         print(state);
//         _state = "paused";
//         _pausedTime = DateTime.now();
//         notifyListeners();
//         print(seconds);
//         break;

//       case AppLifecycleState.resumed:
//         _state = "resumed";
//         _handleAppResumption();
//         break;
//       default:
//     }
//     notifyListeners();
//   }

//   void _handleAppResumption() {
//     print("_handleAppResumption :  ${seconds}");
//     print(state);
//     if (_pausedTime != null) {
//       print(
//         "PAUSED AT :${_pausedTime}",
//       );
//       int elapsedPausedTime = DateTime.now().difference(_pausedTime!).inSeconds;

//       print("_handleAppResumption :  ${seconds}");
//       //print(elapsedPausedTime);
//       seconds = seconds + elapsedPausedTime;

//       _pausedTime = null;

//       _elapsedTime = formatTime(seconds, false);
//       notifyListeners();

//       print(
//           "App resumed: Added $elapsedPausedTime seconds. Total: $_elapsedTime seconds.");
//     }
//   }

// /*
//   void runStopWatch() async {
//     Timer.periodic(Duration(seconds: 1), (Timer t) {
//       switch (_status) {
//         case Status.paused:
//           t.cancel();
//           break;

//         case Status.stopped:
//           t.cancel();
//           break;

//         case Status.running:
//           _seconds++;
//           updateRemainingTime();
//           updateElapsedTime(_seconds);
//           notifyListeners();

//           if (_remainingsec <= 0) {
//             bool added = incrementItemCount();
//             if (added) {
//               //call `regenerateBamboo` from here
//               //incrementItemCount();
//             }
//             notifyListeners();

//             _remainingsec = _countdownsec; // Reset the countdown
//             if (_itemCnt >= 6) {
//               _isfull = true;
//               notifyListeners();
//               //print("[*] 대나무 만땅");
//             }
//           }
//           notifyListeners();

//           break;
//       }
//     });
//   }*/
//   @override
//   void runStopWatch() {
//     _timer = Timer.periodic(Duration(seconds: 1), (Timer t) async {
//       if (_status == Status.running) {
//         seconds++;
//         updateRemainingTime();

//         _elapsedTime = formatTime(seconds, false);
//         if (_remainingsec <= 0) {
//           bool added = incrementItemCount();
//           if (added) {
//             // Handle item count increment
//           }
//           _remainingsec = _countdownsec; // Reset the countdown
//         }
//       } else {
//         t.cancel(); // Stop the timer if not running
//       }

//       notifyListeners();

//       //print("inside runStopWatch : ${_seconds}");
//     });
//   }

// ///// stopped -> running
//   void run() {
//     // stopped -> running
//     _status = Status.running;

//     runStopWatch();
//   }

//   void changeStatus() {
//     switch (_status) {
//       case Status.paused:
//         resume();
//         //stopwatch.resume();
//         //fetchTimerData();
//         break;

//       case Status.running:
//         pause();
//         //stopwatch.pause();
//         //fetchTimerData();
//         break;
//       case Status.stopped:
//         run();
//         //TODO : fetchTimerData();
//         break;
//     }
//     notifyListeners();
//   }

// // running -> paused
//   void pause() {
//     _status = Status.paused;
//     print("PAUSED ! : $seconds");
//     notifyListeners();
//   }

//   // running -> stopped
//   // paused -> stopped
//   void stop() {
//     _status = Status.stopped;
//     print("STOPPED ! : $seconds");
//     //_remainingsec = _countdownsec;
//     seconds = 0;
//     updateRemainingTime();
//     notifyListeners();
//   }

// // paused -> running
//   void resume() {
//     print("RESUMED ! : $seconds");
//     run(); // 상태 변경됨 -> running
//   }

//   String formatTime(int seconds, bool shortversion) {
//     int minutes = (seconds / 60).truncate();
//     int hours = (minutes / 60).truncate();
//     String hoursStr = (hours % 60).toString().padLeft(2, '0');
//     String minutesStr = (minutes % 60).toString().padLeft(2, '0');
//     String secondsStr = (seconds % 60).toString().padLeft(2, '0');

//     return shortversion
//         ? '$minutesStr:$secondsStr'
//         : '$hoursStr:$minutesStr:$secondsStr';
//   }

//   void updateRemainingTime() {
//     _remainingsec = _countdownsec - seconds % _countdownsec;
//     //print("$_remainingsec");
//     if (_remainingsec == 1) {
//       incrementItemCount();
//       _remainingsec = _countdownsec;
//     }
//     _remainingTime = formatTime(_remainingsec, true);
//     notifyListeners();
//   }

//   void updateElapsedTime(int sec) {
//     _elapsedTime = formatTime(sec, false);
//     notifyListeners();
//   }

//   bool incrementItemCount() {
//     if (_itemCnt < 6) {
//       _itemCnt += 1;
//       print("[*] 대나무 생김 : $_itemCnt");
//       showBambooNotification = true;
//       notifyListeners();
//       return true;
//     } else {
//       _isfull = true;
//     }
//     notifyListeners();
//     return false;
//   }

//   void decreaseItemCount() {
//     if (_itemCnt > 0) {
//       _itemCnt -= 1;
//       _isfull = false;
//       notifyListeners();
//       print("[*] 대나무  줍줍 : $_itemCnt");
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:reafy_front/src/repository/statics_repository.dart';

class TimeProvider with ChangeNotifier {
  int _todayTime = 0;
  String _totalTime = '0';

  int get todayTime => _todayTime;
  String get totalTime => _totalTime;

  void setTodayTime(int newTime) {
    _todayTime = newTime;
    notifyListeners();
  }

  void setTotalTime(String newTime) {
    _totalTime = newTime;
    notifyListeners();
  }

  Future<void> getTimes() async {
    try {
      Map<String, dynamic> todayTimeStatistics = await getTodayTimeStatistics();
      int today = todayTimeStatistics['todayReadingTimes'];

      List<Map<String, dynamic>> monthTimeStatistics =
          await getMonthlyTimeStatistics(DateTime.now().year);

      String currentMonth = DateTime.now().month.toString().padLeft(2, '0');

      Map<String, dynamic>? thisMonthData;

      for (var map in monthTimeStatistics) {
        if (map['month'] == '${DateTime.now().year}-$currentMonth') {
          thisMonthData = map;
          break;
        }
      }
      String total = thisMonthData?['totalReadingTimes'];
      setTodayTime(today);
      setTotalTime(total);
    } catch (e) {
      print('time 에러 발생 : $e');
    }
  }
}

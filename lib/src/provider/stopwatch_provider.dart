import 'package:flutter/material.dart';

class StopwatchProvider extends ChangeNotifier {
  bool _isRunning = false;
  String _elapsedTime = '00:00:00';

  bool get isRunning => _isRunning;
  String get elapsedTime => _elapsedTime;

  void updateIsRunning(bool value) {
    _isRunning = value;
    notifyListeners();
  }

  void updateElapsedTime(String value) {
    _elapsedTime = value;
    notifyListeners();
  }
}

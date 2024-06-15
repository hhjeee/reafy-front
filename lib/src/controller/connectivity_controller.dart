import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityController with ChangeNotifier {
  bool _isConnected = false;

  bool get isConnected => _isConnected;

  void init() {
    Connectivity().checkConnectivity().then((ConnectivityResult result) {
      _updateConnectivityStatus(result);
    });

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _updateConnectivityStatus(result);
    });
  }

  void _updateConnectivityStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      _isConnected = false;
    } else if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      _isConnected = true;
    }
    notifyListeners();
  }
}

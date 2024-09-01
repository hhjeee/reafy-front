import 'package:dio/dio.dart';
import 'package:reafy_front/src/utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Dio authdio = authDio().getDio();

Future<Map<String, dynamic>> getRemainingTime() async {
  try {
    final res = await authdio.get(
      '${baseUrl}/user/timer',
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      final Map<String, dynamic> timerData =
          Map<String, dynamic>.from(res.data);
      return timerData;
    } else {
      throw Exception('Failed to load user timer data');
    }
  } catch (e) {
    throw e;
  }
}

Future<void> saveRemainingTime(int remainingtime) async {
  // final prefs = await SharedPreferences.getInstance();
  // final token = prefs.getString('token');
  // print(token);
  try {
    final Map<String, dynamic> reqData = {
      'timer': remainingtime,
    };
    final res = await authdio.put('${baseUrl}/user/timer', data: reqData);
    if (res.statusCode == 200) {
    } else {
      throw Exception('Failed to save user timer data');
    }
  } catch (e) {
    throw e;
  }
}

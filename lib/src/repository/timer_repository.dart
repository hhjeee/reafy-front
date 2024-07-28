import 'package:dio/dio.dart';
import 'package:reafy_front/src/utils/api.dart';

final Dio authdio = authDio().getDio();

Future<Map<String, dynamic>> getRemainingTime() async {
  try {
    final response = await authdio.get(
      '${baseUrl}/user/timer',
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> timerData =
          Map<String, dynamic>.from(response.data);
      return timerData;
    } else {
      throw Exception('Failed to load user timer data');
    }
  } catch (e) {
    throw e;
  }
}

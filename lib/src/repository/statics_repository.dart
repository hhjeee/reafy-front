import 'package:dio/dio.dart';
import 'package:reafy_front/src/utils/api.dart';

final Dio authdio = authDio().getDio();
Future<List<Map<String, dynamic>>> getMonthlyPageStatistics(int year) async {
  //var dio = await authDio();
  try {
    final res = await authdio.get('${baseUrl}/statistics/pages',
        queryParameters: {'year': year});

    if (res.statusCode == 200) {
      final List<dynamic> pageStaticsData = res.data;
      final List<Map<String, dynamic>> pageStatics =
          List<Map<String, dynamic>>.from(pageStaticsData);
      return pageStatics;
    } else {
      throw Exception('Failed to load monthly page statistics');
    }
  } catch (e) {
    throw e;
  }
}

Future<List<Map<String, dynamic>>> getMonthlyTimeStatistics(int year) async {
  //var dio = await authDio();
  try {
    final res = await authdio.get('${baseUrl}/statistics/times',
        queryParameters: {'year': year});

    if (res.statusCode == 200) {
      final List<dynamic> timeStaticsData = res.data;
      final List<Map<String, dynamic>> timeStatics =
          List<Map<String, dynamic>>.from(timeStaticsData);
      return timeStatics;
    } else {
      throw Exception('Failed to load monthly time statistics');
    }
  } catch (e) {
    throw e;
  }
}

Future<Map<String, dynamic>> getTodayTimeStatistics() async {
  //var dio = await authDio();
  try {
    final res = await authdio.get('${baseUrl}/statistics/today');

    if (res.statusCode == 200) {
      final Map<String, dynamic> statistics = res.data as Map<String, dynamic>;
      return statistics;
    } else {
      throw Exception('Failed to load today\'s reading statistics');
    }
  } catch (e) {
    throw e;
  }
}

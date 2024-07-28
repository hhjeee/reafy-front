import 'package:dio/dio.dart';
import 'package:reafy_front/src/utils/api.dart';
import 'package:intl/intl.dart';

final Dio authdio = authDio().getDio();

Future<List<Map<String, dynamic>>> getMonthlyPageStatistics(int year) async {
  try {
    final res = await authdio.get('${baseUrl}/statistics/monthly/pages',
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
  try {
    final res = await authdio.get('${baseUrl}/statistics/monthly/times',
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

Future<int> getWeeklyTimeStatistics() async {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(now);

  try {
    final res = await authdio.get('${baseUrl}/statistics/weekly/times',
        queryParameters: {'date': formattedDate});

    if (res.statusCode == 200) {
      final Map<String, dynamic> statistics = res.data as Map<String, dynamic>;
      return statistics['totalReadingTimes'] as int;
    } else {
      throw Exception('Failed to load today\'s reading statistics');
    }
  } catch (e) {
    throw e;
  }
}

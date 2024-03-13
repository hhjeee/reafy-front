import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

const url = 'https://dev.reafydevkor.xyz';

Future<List<Map<String, dynamic>>> getMonthlyPageStatistics(int year) async {
  final dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userToken = prefs.getString('token');

  try {
    final response = await dio.get(
      '$url/statistics/pages',
      queryParameters: {
        'year': year,
      },
      options: Options(headers: {
        'Authorization': 'Bearer $userToken',
        'Content-Type': 'application/json',
      }),
    );

    if (response.statusCode == 200) {
      final List<dynamic> pageStaticsData = response.data;
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
  final dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userToken = prefs.getString('token');

  try {
    final response = await dio.get(
      '$url/statistics/times',
      queryParameters: {
        'year': year,
      },
      options: Options(headers: {
        'Authorization': 'Bearer $userToken',
        'Content-Type': 'application/json',
      }),
    );

    if (response.statusCode == 200) {
      final List<dynamic> timeStaticsData = response.data;
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
  final Dio dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userToken = prefs.getString('token');

  try {
    final response = await dio.get(
      '$url/statistics/today',
      options: Options(headers: {
        'Authorization': 'Bearer $userToken',
        'Content-Type': "application/json"
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> statistics =
          response.data as Map<String, dynamic>;
      return statistics;
    } else {
      throw Exception('Failed to load today\'s reading statistics');
    }
  } catch (e) {
    throw e;
  }
}

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>> getMonthlyPageStatics(int year) async {
  final dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userToken = prefs.getString('token');

  try {
    final response = await dio.get(
      'https://reafydevkor.xyz/statistics/pages',
      queryParameters: {
        'year': year,
      },
      options: Options(headers: {
        'Authorization': 'Bearer $userToken',
        'Content-Type': 'application/json',
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> pageStatics = response.data;
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
      'https://reafydevkor.xyz/statistics/times',
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
      'https://reafydevkor.xyz/statistics/today',
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

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>> getMonthlyPageStatics(int year) async {
  final dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userToken = prefs.getString('token');

  try {
    final response = await dio.get(
      'https://reafydevkor.xyz/statics/pages',
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

Future<Map<String, dynamic>> getMonthlyTimeStatics(int year) async {
  final dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userToken = prefs.getString('token');

  try {
    final response = await dio.get(
      'https://reafydevkor.xyz/statics/times',
      queryParameters: {
        'year': year,
      },
      options: Options(headers: {
        'Authorization': 'Bearer $userToken',
        'Content-Type': 'application/json',
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> timeStatics = response.data;
      return timeStatics;
    } else {
      throw Exception('Failed to load monthly time statistics');
    }
  } catch (e) {
    throw e;
  }
}

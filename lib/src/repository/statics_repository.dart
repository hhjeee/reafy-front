import 'package:reafy_front/src/utils/url.dart';

Future<List<Map<String, dynamic>>> getMonthlyPageStatistics(int year) async {
  //final ApiClient apiClient = ApiClient();
  try {
    final response = await ApiClient.instance.dio.get(
      'https://reafydevkor.xyz/statistics/pages',
      queryParameters: {'year': year},
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
  //final ApiClient apiClient = ApiClient();
  try {
    final response = await ApiClient.instance.dio.get(
        'https://reafydevkor.xyz/statistics/times',
        queryParameters: {'year': year});

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
  //final ApiClient apiClient = ApiClient();
  try {
    final response = await ApiClient.instance.dio
        .get('https://reafydevkor.xyz/statistics/today');

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

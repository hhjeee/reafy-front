import 'package:dio/dio.dart';
import 'package:reafy_front/src/utils/api.dart';

final Dio authdio = authDio().getDio();
Future<List<String>> postDefaultQuest() async {
  try {
    final response = await authdio.get(
      '${baseUrl}/quest/default',
    );
    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      List<String> questList = List<String>.from(data[0]['questList']);
      return questList;
    } else {
      throw Exception('Failed to post default quest');
    }
  } catch (e) {
    throw e;
  }
}

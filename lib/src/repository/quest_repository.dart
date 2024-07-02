import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:reafy_front/src/utils/api.dart';

final Dio authdio = authDio().getDio();
Future<List<int>> getAchievedQuests() async {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(now);

  try {
    final res = await authdio.get('${baseUrl}/quest/weekly/achieve',
        queryParameters: {'date': formattedDate});

    if (res.statusCode == 200) {
      final Map<String, dynamic> questData = res.data;
      print(res.data);
      List<dynamic> questHistoryList = questData['questHistoryList'];
      List<int> questIds =
          questHistoryList.map((item) => item['questId'] as int).toList();
      return questIds;
    } else {
      throw Exception('Failed to load monthly time statistics');
    }
  } catch (e) {
    throw e;
  }
}

Future<bool> postQuestAchieve(int questId) async {
  try {
    final res = await authdio.post('${baseUrl}/quest/achieve/$questId',
        queryParameters: {'questId': questId});

    return res.statusCode == 200;
  } catch (e) {
    print(e.toString());
    throw e;
  }
}

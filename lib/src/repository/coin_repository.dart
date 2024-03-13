import 'package:dio/dio.dart';
import 'package:reafy_front/src/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

const url = 'https://dev.reafydevkor.xyz';

//coin 조회
Future<int> getUserCoin() async {
  final dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userToken = prefs.getString('token');

  try {
    final response = await dio.get('$url/coin',
        options: Options(headers: {
          'Authorization': 'Bearer ${userToken}',
          'Content-Type': "application/json"
        }));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = response.data;

      final int totalCoin = responseData['totalCoin'];
      return totalCoin;
    } else {
      throw Exception('Failed to load coin');
    }
  } catch (e) {
    throw e;
  }
}

//coin 증가, 차감
Future<void> updateCoin(int coin, bool isPlus) async {
  final dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userToken = prefs.getString('token');

  try {
    final Map<String, dynamic> requestData = {
      'coin': coin,
      'isPlus': isPlus,
    };

    final response = await dio.put(
      '$url/coin',
      data: requestData,
      options: Options(headers: {
        'Authorization': 'Bearer $userToken',
        'Content-Type': 'application/json',
      }),
    );

    if (response.statusCode == 200) {
      print('코인 업데이트 성공');
    } else {
      throw Exception('코인 업데이트 실패');
    }
  } catch (e) {
    throw e;
  }
}

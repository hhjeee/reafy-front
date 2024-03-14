import 'package:dio/dio.dart';
import 'package:reafy_front/src/utils/api.dart';

final Dio authdio = authDio().getDio();
//coin 조회
Future<int> getUserCoin() async {
  //var dio = await authDio();
  try {
    final res = await authdio.get('${baseUrl}/coin');

    if (res.statusCode == 200) {
      final Map<String, dynamic> resData = res.data;

      final int totalCoin = resData['totalCoin'];
      return totalCoin;
    } else {
      print(res.statusCode);
      throw Exception('Failed to load coin');
    }
  } catch (e) {
    throw e;
  }
}

//coin 증가, 차감
Future<void> updateCoin(int coin, bool isPlus) async {
  ////var dio = await authDio();
  ////final ApiClient apiClient = ApiClient();
  try {
    final Map<String, dynamic> reqData = {
      'coin': coin,
      'isPlus': isPlus,
    };

    final res = await authdio.put('${baseUrl}/coin', data: reqData);

    if (res.statusCode == 200) {
      print('코인 업데이트 성공');
    } else {
      print(res.statusCode);
      throw Exception('코인 업데이트 실패');
    }
  } catch (e) {
    throw e;
  }
}

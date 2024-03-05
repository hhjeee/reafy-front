import 'package:reafy_front/src/utils/url.dart';

//coin 조회
Future<int> getUserCoin() async {
  //final ApiClient apiClient = ApiClient();

  try {
    final response =
        await ApiClient.instance.dio.get('https://reafydevkor.xyz/coin');

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = response.data;

      final int totalCoin = responseData['totalCoin'];
      return totalCoin;
    } else {
      print(response.statusCode);
      throw Exception('Failed to load coin');
    }
  } catch (e) {
    throw e;
  }
}

//coin 증가, 차감
Future<void> updateCoin(int coin, bool isPlus) async {
  ////final ApiClient apiClient = ApiClient();
  try {
    final Map<String, dynamic> requestData = {
      'coin': coin,
      'isPlus': isPlus,
    };

    final response = await ApiClient.instance.dio
        .put('https://reafydevkor.xyz/coin', data: requestData);

    if (response.statusCode == 200) {
      print('코인 업데이트 성공');
    } else {
      print(response.statusCode);
      throw Exception('코인 업데이트 실패');
    }
  } catch (e) {
    throw e;
  }
}

/* 
try {
  await updateCoin(10, true);
  print('코인이 성공적으로 증가되었습니다.');
} catch (e) {
  print('에러 발생: $e');
}
*/
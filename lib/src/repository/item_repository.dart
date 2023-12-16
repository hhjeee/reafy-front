import 'package:dio/dio.dart';
import 'package:reafy_front/src/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

final tempUserToken =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvYXV0aElkIjoiMzE1ODUyNjkwMiIsImlhdCI6MTcwMjI5OTU1MiwiZXhwIjoxNzAyMzAzMTUyLCJzdWIiOiJBQ0NFU1MifQ.k5bgxZTxMdff7Q9GxSQnfxPWuJ3KOpe6vPEUcEW_0bc";

class ItemDto {
  final int itemId;
  final bool activation;

  ItemDto({
    required this.itemId,
    required this.activation,
  });

  factory ItemDto.fromJson(Map<String, dynamic> json) {
    return ItemDto(
      itemId: json['itemId'],
      activation: json['activation'],
    );
  }
}

//아이템 구매
Future<bool> postBookInfo(int itemId, bool activation) async {
  final dio = Dio();
  final url = 'http://13.125.145.165:3000/item';
  /*SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userToken = prefs.getString('token');*/

  try {
    final userToken = tempUserToken;
    final response = await dio.post(url,
        data: {'itemId': itemId, 'activation': activation},
        options: Options(headers: {
          'Authorization': 'Bearer ${userToken}',
          'Content-Type': "application/json"
        }));

    print('Response Code: ${response.statusCode}');

    return response.statusCode == 200 || response.statusCode == 201;
  } catch (e) {
    if (e is DioError) {
      print('DioError: ${e.message}');
      if (e.response != null) {
        print('Response Data: ${e.response?.data}');
        print('Response Headers: ${e.response?.headers}');
      }
    } else {
      print('Error: $e');
    }
    return false;
  }
}

//소유 아이템 리스트 반환
Future<List<ItemDto>> getItemList() async {
  //SharedPreferences prefs = await SharedPreferences.getInstance();
  //final String? userToken = prefs.getString('token');

  final Dio dio = Dio();

  try {
    final userToken = tempUserToken;
    final response = await dio.get(
      'http://13.125.145.165:3000/item/userItemList',
      options: Options(headers: {
        'Authorization': 'Bearer $userToken',
        'Content-Type': 'application/json',
      }),
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = response.data['response'];
      final List<ItemDto> items = responseData
          .map<ItemDto>((item) => ItemDto(
                itemId: item['itemId'] as int,
                activation: item['activation'] as bool,
              ))
          .toList();

      return items;
    } else {
      return [];
    }
  } catch (e) {
    throw e;
  }
}

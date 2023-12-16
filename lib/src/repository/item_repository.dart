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
      itemId: json['itemId'] as int,
      activation: json['activation'] as bool,
    );
  }
}

//아이템 구매
Future<bool> postBookInfo(int itemId, bool activation) async {
  final dio = Dio();
  final url = 'http://13.125.145.165:3000/item';
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userToken = prefs.getString('token');

  try {
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

// 소유 아이템 아이디 리스트 반환
Future<List<int>> getOwnedItemIds() async {
  final Dio dio = Dio();
  final url = 'http://13.125.145.165:3000/item/userItemList';
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userToken = prefs.getString('token');

  try {
    final response = await dio.get(
      url,
      options: Options(headers: {
        'Authorization': 'Bearer $userToken',
        'Content-Type': 'application/json',
      }),
    );

    if (response.statusCode == 200) {
      List<int> ownedItemIds = [];
      for (var data in response.data) {
        ownedItemIds.add(data['itemId']);
      }

      return ownedItemIds;
    } else {
      return [];
    }
  } catch (e) {
    print('Error during item id retrieval: $e');

    throw e;
  }
}


/*       /*for (var data in responseData) {
        ownedItemIds.add(data['itemId'] is String
            ? int.tryParse(data['itemId']) ?? 0
            : data['itemId'] as int);
      }*/
      /* final List<int> ownedItemIds = responseData
          .map<int>((item) => int.parse(item['itemId'] as String))
          .toList();*/*/
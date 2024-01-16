import 'package:dio/dio.dart';
import 'package:reafy_front/src/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemDto {
  final int itemId;
  bool activation;

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
Future<bool> postItem(int itemId, bool activation, int price) async {
  final dio = Dio();
  final url = 'https://reafydevkor.xyz/item';
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userToken = prefs.getString('token');

  try {
    final response = await dio.post(url,
        data: {
          'itemId': itemId,
          'activation': activation,
          'price': price,
        },
        options: Options(headers: {
          'Authorization': 'Bearer ${userToken}',
          'Content-Type': "application/json"
        }));

    print(response);
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
  final url = 'https://reafydevkor.xyz/item/userItemList';
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
      print('a ${response.data}');
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

// 배치된 아이템 아이디 리스트 반환
Future<List<int>> getActivatedOwnedItemIds() async {
  final Dio dio = Dio();
  final url = 'https://reafydevkor.xyz/item/userItemList';
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
      print('b ${response.data}');
      List<int> activatedOwnedItemIds = [];

      for (var data in response.data) {
        // activation이 true인 아이템만 추가
        if (data['activation'] == true) {
          activatedOwnedItemIds.add(data['itemId']);
        }
      }
      activatedOwnedItemIds.sort(); //오름차순 정렬

      return activatedOwnedItemIds;
    } else {
      return [];
    }
  } catch (e) {
    print('Error during item id retrieval: $e');

    throw e;
  }
}

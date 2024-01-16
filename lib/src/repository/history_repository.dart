import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 독서 기록 조회
Future<List<dynamic>> getBookshelfBookHistory(int bookshelfbookid) async {
  final dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userToken = prefs.getString('token');

  try {
    final response = await dio.get(
      'https://reafydevkor.xyz/history/bookshelfbook',
      queryParameters: {
        'bookshelfbookid': bookshelfbookid,
      },
      options: Options(headers: {
        'Authorization': 'Bearer $userToken',
        'Content-Type': 'application/json',
      }),
    );

    if (response.statusCode == 200) {
      final List<dynamic> historyList = response.data;
      return historyList;
    } else {
      throw Exception('Failed to load bookshelf book history');
    }
  } catch (e) {
    throw e;
  }
}

// 독서 기록 저장
class CreateUserBookHistoryDto {
  int? bookshelfBookId;
  int? startPage;
  int? endPage;
  int duration;
  int coins;

  CreateUserBookHistoryDto({
    required this.bookshelfBookId,
    required this.startPage,
    required this.endPage,
    required this.duration,
    required this.coins,
  });

  Map<String, dynamic> toJson() {
    return {
      'bookshelfBookId': bookshelfBookId,
      'startPage': startPage,
      'endPage': endPage,
      'duration': duration,
      'coins': coins,
    };
  }
}

Future<void> createUserBookHistory(CreateUserBookHistoryDto historyDto) async {
  final dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userToken = prefs.getString('token');

  try {
    final response = await dio.post(
      'https://reafydevkor.xyz/history/bookshelfbook',
      data: historyDto.toJson(),
      options: Options(headers: {
        'Authorization': 'Bearer $userToken',
        'Content-Type': 'application/json',
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create book history');
    }
  } catch (e) {
    throw e;
  }
}

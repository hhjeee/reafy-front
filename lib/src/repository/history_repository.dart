import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

const url = 'https://dev.reafydevkor.xyz';

// 독서 기록 조회
Future<List<dynamic>> getBookshelfBookHistory(int bookshelfbookid) async {
  final dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userToken = prefs.getString('token');

  try {
    final response = await dio.get(
      '$url/history',
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
    if (e is DioError) {
      //404인 경우 빈 리스트 반환
      if (e.response?.statusCode == 404) {
        return [];
      }
    }
    throw e;
  }
}

// 독서 기록 저장
class CreateUserBookHistoryDto {
  int? bookshelfBookId;
  int? startPage;
  int? endPage;
  int duration;

  CreateUserBookHistoryDto({
    required this.bookshelfBookId,
    required this.startPage,
    required this.endPage,
    required this.duration,
  });

  Map<String, dynamic> toJson() {
    return {
      'bookshelfBookId': bookshelfBookId,
      'startPage': startPage,
      'endPage': endPage,
      'duration': duration,
    };
  }
}

Future<void> createUserBookHistory(CreateUserBookHistoryDto historyDto) async {
  final dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userToken = prefs.getString('token');

  try {
    final response = await dio.post(
      '$url/history',
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
    print('createUserBookHistory 함수에서 에러 발생: $e');
    throw e;
  }
}

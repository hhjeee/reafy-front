import 'package:dio/dio.dart';
import 'package:reafy_front/src/utils/api.dart';

final Dio authdio = authDio().getDio();
// 독서 기록 조회
Future<List<dynamic>> getBookshelfBookHistory(int bookshelfbookid) async {
  //var dio = await authDio();
  try {
    final res = await authdio.get('${baseUrl}/history', queryParameters: {
      'bookshelfbookid': bookshelfbookid,
    });

    if (res.statusCode == 200 || res.statusCode == 201) {
      final List<dynamic> historyList = res.data;
      return historyList;
    } else {
      throw Exception('Failed to load bookshelf book history');
    }
  } catch (e) {
    if (e is DioError) {
      if (e.response?.statusCode == 404) {
        //404인 경우 빈 리스트 반환
        //////// getBookshelfBookDetails 함수에서 에러 발생: type 'Null' is not a subtype of type 'String'
        //flutter: Error fetching book details: type 'Null' is not a subtype of type 'String'
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
  //var dio = await authDio();
  try {
    final res =
        await authdio.post('${baseUrl}/history', data: historyDto.toJson());

    if (res.statusCode != 201) {
      throw Exception('Failed to create book history');
    }
  } catch (e) {
    print('createUserBookHistory 함수에서 에러 발생: $e');
    throw e;
  }
}

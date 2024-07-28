import 'package:dio/dio.dart';
import 'package:reafy_front/src/dto/history_dto.dart';
import 'package:reafy_front/src/utils/api.dart';

final Dio authdio = authDio().getDio();

// 독서 기록 조회
Future<Map<String, dynamic>> getBookshelfBookHistory(int bookshelfbookId,
    {int? cursorId}) async {
  try {
    final res = await authdio.get('${baseUrl}/history', queryParameters: {
      'bookshelfBookId': bookshelfbookId,
      'cursorId': cursorId,
    });

    if (res.statusCode == 200 || res.statusCode == 201) {
      return res.data as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load bookshelf book history');
    }
  } catch (e) {
    if (e is DioError) {
      if (e.response?.statusCode == 404) {
        // 404인 경우 빈 리스트와 기본 메타 데이터 반환
        return {
          'data': [],
          'meta': {
            'cursorId': 0,
            'hasNextData': false,
          },
        };
      }
    }
    throw e;
  }
}

// 가장 최근 독서 기록 조회
Future<dynamic> getBookshelfBookRecentHistory(int bookshelfbookId) async {
  try {
    final res =
        await authdio.get('${baseUrl}/history/recently', queryParameters: {
      'bookshelfBookId': bookshelfbookId,
    });
    if (res.statusCode == 200) {
      final dynamic recentHistory = res.data;
      return recentHistory;
    } else {
      throw Exception('Failed to load bookshelf book history');
    }
  } catch (e) {
    if (e is DioError) {
      if (e.response?.statusCode == 404) {
        return {};
      }
    }
    throw e;
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

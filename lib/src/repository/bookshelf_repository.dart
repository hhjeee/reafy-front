import 'package:dio/dio.dart';
import 'package:reafy_front/src/dto/bookshelf_dto.dart';
import 'package:reafy_front/src/utils/api.dart';

final Dio authdio = authDio().getDio();

//서재 메인에서 받아오는 카테고리별 썸네일 리스트
Future<List<String>> fetchBookshelfThumbnailsByState(int progressState) async {
  try {
    final res = await authdio.get('${baseUrl}/book/bookshelf',
        queryParameters: {'progressState': progressState});
    if (res.statusCode == 200) {
      final List<dynamic> resData = res.data as List<dynamic>;
      final List<String> thumbnails = List<String>.from(
          resData.map<String>((item) => item['thumbnail_url'] as String));

      return thumbnails;
    } else {
      throw Exception('Failed to load bookshelf thumbnails');
    }
  } catch (e) {
    throw e;
  }
}

//myfavorite 책 썸네일 리스트
Future<List<String>> fetchBookshelfThumbnailsByFavorite() async {
  try {
    final res = await authdio.get('${baseUrl}/book/favorite');

    if (res.statusCode == 200) {
      final List<dynamic> resData = res.data as List<dynamic>;
      final List<String> thumbnails = List<String>.from(
          resData.map<String>((item) => item['thumbnail_url'] as String));
      return thumbnails;
    } else {
      throw Exception('Failed to load bookshelf thumbnails');
    }
  } catch (e) {
    throw e;
  }
}

//상태(카테고리)별 책 정보 조회
Future<List<BookshelfBookInfo>> fetchBookshelfBooksInfoByState(
    int progressState) async {
  try {
    final res = await authdio.get('${baseUrl}/book/bookshelf',
        queryParameters: {'progressState': progressState});

    if (res.statusCode == 200) {
      final List<dynamic> resData = res.data as List<dynamic>;
      final List<BookshelfBookInfo> books = resData
          .map<BookshelfBookInfo>((item) => BookshelfBookInfo(
                bookshelfBookId: item['bookshelf_book_id'] as int,
                title: item['title'] as String,
                thumbnailURL: item['thumbnail_url'] as String,
                author: item['author'] as String,
              ))
          .toList();

      return books;
    } else {
      return [];
    }
  } catch (e) {
    print(e.toString());
    throw e;
  }
}

//페이보릿 책 정보 조회
Future<List<BookshelfBookInfo>> fetchBookshelfBooksInfoByFavorite() async {
  try {
    final res = await authdio.get('${baseUrl}/book/favorite');

    if (res.statusCode == 200) {
      final List<dynamic> resData = res.data as List<dynamic>;
      final List<BookshelfBookInfo> books = resData
          .map<BookshelfBookInfo>((item) => BookshelfBookInfo(
                bookshelfBookId: item['bookshelf_book_id'] as int,
                title: item['title'] as String,
                thumbnailURL: item['thumbnail_url'] as String,
                author: item['author'] as String,
              ))
          .toList();

      return books;
    } else {
      return [];
    }
  } catch (e) {
    throw e;
  }
}

//책 등록
Future<bool> postBookInfo(String isbn13, int progressState) async {
  try {
    final res = await authdio.post(
      '${baseUrl}/book/bookshelf',
      data: {'isbn13': isbn13, 'progressState': progressState},
    );

    // 서버 응답 코드 확인
    print('Response Code: ${res.statusCode}');

    return res.statusCode == 200 || res.statusCode == 201;
  } catch (e) {
    // DioError 처리
    if (e is DioError) {
      print('DioError: ${e.message}');
      if (e.response != null) {
        print('Response Data: ${e.response?.data}');
        print('Response Headers: ${e.response?.headers}');
        // 추가로 필요한 정보 출력 가능
      }
    } else {
      print('Error: $e');
    }

    // 실패
    return false;
  }
}

//책 삭제
Future<void> deleteBookshelfBook(int bookshelfBookId) async {
  try {
    await authdio.delete('${baseUrl}/book/bookshelf/$bookshelfBookId');
  } catch (error) {
    throw Exception('Failed to delete book: $error');
  }
}

//책 상세정보 조회
Future<BookshelfBookDetailsDto> getBookshelfBookDetails(
    int bookshelfBookId) async {
  try {
    final res = await authdio.get(
      '${baseUrl}/book/bookshelf/$bookshelfBookId',
    );
    if (res.statusCode == 200) {
      final Map<String, dynamic> data = res.data;
      final BookshelfBookDetailsDto bookshelfBookDetails =
          BookshelfBookDetailsDto.fromJson(data);
      return bookshelfBookDetails;
    } else {
      throw Exception('Failed to load bookshelf book details');
    }
  } catch (e) {
    print('getBookshelfBookDetails 함수에서 에러 발생: $e');
    throw e;
  }
}

//favorite 등록
Future<void> updateBookshelfBookFavorite(
  int bookshelfBookId,
) async {
  try {
    final res = await authdio.get('${baseUrl}/book/bookshelf/$bookshelfBookId');

    if (res.statusCode == 200) {
      final Map<String, dynamic> data = res.data;
      final bool isCurrentlyFavorite = data['isFavorite'] == 1 ? true : false;
      final Map<String, dynamic> reqBody = {
        'isFavorite': isCurrentlyFavorite ? 0 : 1,
      };
      await authdio.put(
        '${baseUrl}/book/favorite/$bookshelfBookId',
        data: reqBody,
      );
    } else {
      throw Exception('Failed to fetch current bookshelf book details');
    }
  } catch (e) {
    print('updateBookshelfBookFavorite 함수에서 에러 발생: $e');
    throw e;
  }
}

// 도서 카테고리 변경
Future<void> updateBookshelfBookCategory(
  int bookshelfBookId,
  int progressState,
) async {
  try {
    final Map<String, dynamic> reqBody = {'progressState': progressState};

    final res = await authdio.put('${baseUrl}/book/bookshelf/$bookshelfBookId',
        data: reqBody);

    if (res.statusCode != 200) {
      throw Exception('Failed to update bookshelf book category');
    }
  } catch (e) {
    print('updateBookshelfBookCategory 함수에서 에러 발생: $e');
    throw e;
  }
}

Future<List<ReadingBookInfoDto>> fetchReadingBooksInfo(
    int progressState) async {
  try {
    final res = await authdio.get('${baseUrl}/book/bookshelf',
        queryParameters: {'progressState': progressState});

    if (res.statusCode == 200 || res.statusCode == 201) {
      final List<dynamic> resData = res.data as List<dynamic>;
      final List<ReadingBookInfoDto> books = resData
          .map<ReadingBookInfoDto>((item) => ReadingBookInfoDto(
                bookshelfBookId: item['bookshelf_book_id'] as int,
                title: item['title'] as String,
              ))
          .toList();
      return books;
    } else {
      return [];
    }
  } catch (e) {
    print(e.toString());
    throw e;
  }
}

Future<BookshelfBookTitleDto> getBookshelfBookTitle(int bookshelfBookId) async {
  try {
    final res = await authdio.get(
      '${baseUrl}/book/bookshelf/$bookshelfBookId',
    );

    if (res.statusCode == 200) {
      final Map<String, dynamic> data = res.data;
      final BookshelfBookTitleDto bookshelfBookTitle =
          BookshelfBookTitleDto.fromJson(data);
      return bookshelfBookTitle;
    } else {
      throw Exception('Failed to load bookshelf book title');
    }
  } catch (e) {
    print('getBookshelfBookTitle 함수에서 에러 발생: $e');
    throw e;
  }
}

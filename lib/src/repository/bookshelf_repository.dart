import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:reafy_front/src/models/user.dart';
import 'package:reafy_front/src/models/book.dart';
import 'package:shared_preferences/shared_preferences.dart';

const url = 'https://dev.reafydevkor.xyz';

//책 검색
class SearchBookDto {
  final String isbn13;
  final String thumbnailURL;
  final String title;
  final String author;

  SearchBookDto({
    required this.isbn13,
    required this.thumbnailURL,
    required this.title,
    required this.author,
  });

  factory SearchBookDto.fromJson(Map<String, dynamic> json) {
    return SearchBookDto(
      isbn13: json['isbn13'],
      thumbnailURL: json['thumbnailURL'],
      title: json['title'],
      author: json['author'],
    );
  }
}

class SearchBookResDto {
  final int totalItems;
  final int currentItems;
  final int totalPages;
  final int currentPage;
  final List<SearchBookDto> items;

  SearchBookResDto({
    required this.totalItems,
    required this.currentItems,
    required this.totalPages,
    required this.currentPage,
    required this.items,
  });

  factory SearchBookResDto.fromJson(Map<String, dynamic> json) {
    return SearchBookResDto(
      totalItems: json['totalItems'],
      currentItems: json['currentItems'],
      totalPages: json['totalPages'],
      currentPage: json['currentPage'],
      items: List<SearchBookDto>.from(
          json['item'].map((item) => SearchBookDto.fromJson(item))),
    );
  }
}

//책 리스트 정보
class BookshelfBookDto {
  final int bookshelfBookId;
  final String title;
  final String thumbnailURL;
  final int progressState;

  BookshelfBookDto({
    required this.bookshelfBookId,
    required this.title,
    required this.thumbnailURL,
    required this.progressState,
  });

  factory BookshelfBookDto.fromJson(Map<String, dynamic> json) {
    return BookshelfBookDto(
      bookshelfBookId: json['bookshelfBookId'],
      title: json['title'],
      thumbnailURL: json['thumbnailURL'],
      progressState: json['progressState'],
    );
  }

  @override
  String toString() {
    return 'BookshelfBookDto{bookshelfBookId: $bookshelfBookId, title: $title, thumbnailURL: $thumbnailURL, progressState: $progressState}';
  }
}

//서재 메인에서 받아오는 카테고리별 썸네일 리스트
Future<List<String>> fetchBookshelfThumbnailsByState(int progressState) async {
  final Dio dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userToken = prefs.getString('token');

  try {
    final response = await dio.get('$url/book/bookshelf',
        queryParameters: {'progressState': progressState},
        options: Options(headers: {
          'Authorization': 'Bearer ${userToken}',
          'Content-Type': "application/json"
        }));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = response.data as List<dynamic>;
      final List<String> thumbnails = List<String>.from(
          responseData.map<String>((item) => item['thumbnail_url'] as String));

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
  final Dio dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userToken = prefs.getString('token');

  try {
    final response = await dio.get('$url/book/favorite',
        options: Options(headers: {
          'Authorization': 'Bearer ${userToken}',
          'Content-Type': "application/json"
        }));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = response.data as List<dynamic>;
      final List<String> thumbnails = List<String>.from(
          responseData.map<String>((item) => item['thumbnail_url'] as String));

      return thumbnails;
    } else {
      throw Exception('Failed to load bookshelf thumbnails');
    }
  } catch (e) {
    throw e;
  }
}

//카테고리별 책 정보
class BookshelfBookInfo {
  final int bookshelfBookId;
  final String title;
  final String thumbnailURL;
  final String author;

  BookshelfBookInfo(
      {required this.bookshelfBookId,
      required this.title,
      required this.thumbnailURL,
      required this.author});

  factory BookshelfBookInfo.fromJson(Map<String, dynamic> json) {
    return BookshelfBookInfo(
      bookshelfBookId: json['bookshelfBookId'] as int? ?? 0,
      title: json['title']?.toString() ?? "",
      thumbnailURL: json['thumbnailURL']?.toString() ?? "",
      author: json['author']?.toString() ?? "",
    );
  }
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookshelfBookInfo &&
          runtimeType == other.runtimeType &&
          bookshelfBookId == other.bookshelfBookId &&
          title == other.title &&
          thumbnailURL == other.thumbnailURL &&
          author == other.author;

  @override
  int get hashCode =>
      bookshelfBookId.hashCode ^
      title.hashCode ^
      thumbnailURL.hashCode ^
      author.hashCode;

  @override
  String toString() {
    return 'BookshelfBookInfo{bookshelfBookId: $bookshelfBookId, title: $title, thumbnailURL: $thumbnailURL, author: $author}';
  }
}

//상태(카테고리)별 책 정보 조회
Future<List<BookshelfBookInfo>> fetchBookshelfBooksInfoByState(
    int progressState) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userToken = prefs.getString('token');

  final Dio dio = Dio();

  try {
    final response = await dio.get(
      '$url/book/bookshelf',
      queryParameters: {'progressState': progressState},
      options: Options(headers: {
        'Authorization': 'Bearer $userToken',
        'Content-Type': 'application/json',
      }),
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = response.data as List<dynamic>;
      final List<BookshelfBookInfo> books = responseData
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
  final Dio dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userToken = prefs.getString('token');

  try {
    //final userToken = tempUserToken;

    final response = await dio.get(
      '$url/book/favorite',
      options: Options(headers: {
        'Authorization': 'Bearer $userToken',
        'Content-Type': 'application/json',
      }),
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = response.data as List<dynamic>;
      final List<BookshelfBookInfo> books = responseData
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
  final dio = Dio();
  final apiUrl = '$url/book/bookshelf';
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userToken = prefs.getString('token');

  try {
    //final userToken = await UserToken();
    //print(userToken.accessToken);
    //final userToken = tempUserToken;

    final response = await dio.post(apiUrl,
        data: {'isbn13': isbn13, 'progressState': progressState},
        options: Options(headers: {
          'Authorization': 'Bearer ${userToken}',
          'Content-Type': "application/json"
        }));

    // 서버 응답 코드 확인
    print('Response Code: ${response.statusCode}');

    // 성공 여부 반환
    return response.statusCode == 200 || response.statusCode == 201;
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
  final dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userToken = prefs.getString('token');

  try {
    //final userToken = await UserToken();
    //print(userToken.accessToken);
    //final userToken = tempUserToken;

    String apiUrl =
        'https://dev.reafydevkor.xyz/book/bookshelf/$bookshelfBookId';

    final response = await dio.delete(
      apiUrl,
      options: Options(headers: {
        'Authorization': 'Bearer ${userToken}',
        'Content-Type': 'application/json',
      }),
    );
  } catch (error) {
    // 오류 처리
    throw Exception('Failed to delete book: $error');
  }
}

//책 상세정보
class BookshelfBookDetailsDto {
  final String isDeleted;
  final int bookshelfBookId;
  final int progressState;
  final int isFavorite;
  final int bookId;
  final String title;
  final String author;
  final String content;
  final String publisher;
  final String thumbnailURL;
  final String link;
  final String category;
  final int pages;
  final int startPage;
  final int endPage;
  final int totalPagesRead;

  BookshelfBookDetailsDto({
    required this.isDeleted,
    required this.bookshelfBookId,
    required this.progressState,
    required this.isFavorite,
    required this.bookId,
    required this.title,
    required this.author,
    required this.content,
    required this.publisher,
    required this.thumbnailURL,
    required this.link,
    required this.category,
    required this.pages,
    required this.startPage,
    required this.endPage,
    required this.totalPagesRead,
  });

  factory BookshelfBookDetailsDto.fromJson(Map<String, dynamic> json) {
    return BookshelfBookDetailsDto(
      isDeleted: json['isDeleted'] as String? ?? '',
      bookshelfBookId: json['bookshelfbookId'] as int? ?? 0,
      progressState: json['progressState'] as int? ?? 0,
      isFavorite: json['isFavorite'] as int? ?? 0,
      bookId: json['bookId'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      author: json['author'] as String? ?? '',
      content: json['content'] as String? ?? '',
      publisher: json['publisher'] as String? ?? '',
      thumbnailURL: json['thumbnailURL'] as String? ?? '',
      link: json['link'] as String? ?? '',
      category: json['category'] as String? ?? '',
      pages: json['pages'] as int? ?? 0,
      startPage: json['startPage'] as int? ?? 0,
      endPage: json['endPage'] as int? ?? 0,
      totalPagesRead: json['totalPagesRead'] as int? ?? 0,
    );
  }

  @override
  String toString() {
    return 'BookshelfBookDetailsDto{isDeleted: $isDeleted, bookshelfBookId: $bookshelfBookId, progressState: $progressState, isFavorite: $isFavorite, bookId: $bookId, title: $title, author: $author, content: $content, publisher: $publisher, thumbnailURL: $thumbnailURL, link: $link, category: $category, pages: $pages, startPage: $startPage, endPage: $endPage, totalPagesRead: $totalPagesRead}';
  }
}

//책 상세정보 조회
Future<BookshelfBookDetailsDto> getBookshelfBookDetails(
    int bookshelfBookId) async {
  final dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userToken = prefs.getString('token');

  try {
    final response = await dio.get('$url/book/bookshelf/$bookshelfBookId',
        options: Options(headers: {
          'Authorization': 'Bearer ${userToken}',
          'Content-Type': "application/json"
        }));

    if (response.statusCode == 200) {
      ;
      final Map<String, dynamic> data = response.data;
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
  final dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userToken = prefs.getString('token');

  try {
    final bookDetails = await getBookshelfBookDetails(bookshelfBookId);
    final bool isCurrentlyFavorite = bookDetails.isFavorite == 1;
    final Map<String, dynamic> requestBody = {
      'isFavorite': isCurrentlyFavorite ? 0 : 1,
    };

    final updateResponse = await dio.put(
      '$url/book/favorite/$bookshelfBookId',
      data: requestBody,
      options: Options(headers: {
        'Authorization': 'Bearer $userToken',
        'Content-Type': 'application/json',
      }),
    );

    if (updateResponse.statusCode != 200) {
      throw Exception('Failed to update favorite status');
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
  final dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userToken = prefs.getString('token');

  try {
    final Map<String, dynamic> requestBody = {
      'progressState': progressState,
    };

    final response = await dio.put(
      '$url/book/bookshelf/$bookshelfBookId',
      data: requestBody,
      options: Options(headers: {
        'Authorization': 'Bearer $userToken',
        'Content-Type': 'application/json',
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update bookshelf book category');
    }
  } catch (e) {
    print('updateBookshelfBookCategory 함수에서 에러 발생: $e');
    throw e;
  }
}

// 독서 기록 저장 다이얼로그(stop dialog) 전용
class ReadingBookInfo {
  final int bookshelfBookId;
  final String title;

  ReadingBookInfo({
    required this.bookshelfBookId,
    required this.title,
  });

  factory ReadingBookInfo.fromJson(Map<String, dynamic> json) {
    return ReadingBookInfo(
      bookshelfBookId: json['bookshelfBookId'] as int? ?? 0,
      title: json['title']?.toString() ?? "",
    );
  }
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookshelfBookInfo &&
          runtimeType == other.runtimeType &&
          bookshelfBookId == other.bookshelfBookId &&
          title == other.title;

  @override
  int get hashCode => bookshelfBookId.hashCode ^ title.hashCode;

  @override
  String toString() {
    return 'BookshelfBookInfo{bookshelfBookId: $bookshelfBookId, title: $title}';
  }
}

Future<List<ReadingBookInfo>> fetchReadingBooksInfo(int progressState) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userToken = prefs.getString('token');

  final Dio dio = Dio();

  try {
    final response = await dio.get(
      '$url/book/bookshelf',
      queryParameters: {'progressState': progressState},
      options: Options(headers: {
        'Authorization': 'Bearer $userToken',
        'Content-Type': 'application/json',
      }),
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = response.data as List<dynamic>;
      final List<ReadingBookInfo> books = responseData
          .map<ReadingBookInfo>((item) => ReadingBookInfo(
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

class BookshelfBookTitleDto {
  final String title;

  BookshelfBookTitleDto({required this.title});

  factory BookshelfBookTitleDto.fromJson(Map<String, dynamic> json) {
    return BookshelfBookTitleDto(
      title: json['title'] as String? ?? '',
    );
  }
}

Future<BookshelfBookTitleDto> getBookshelfBookTitle(int bookshelfBookId) async {
  final dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userToken = prefs.getString('token');

  try {
    final response = await dio.get(
      '$url/book/bookshelf/$bookshelfBookId',
      options: Options(
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': "application/json"
        },
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data;
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

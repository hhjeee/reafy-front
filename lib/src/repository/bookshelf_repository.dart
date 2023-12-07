import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:reafy_front/src/models/book.dart';

//책 검색
class SearchBookResDto {
  final String isbn13;
  final String thumbnailURL;
  final String title;
  final String author;

  SearchBookResDto({
    required this.isbn13,
    required this.thumbnailURL,
    required this.title,
    required this.author,
  });

  factory SearchBookResDto.fromJson(Map<String, dynamic> json) {
    return SearchBookResDto(
      isbn13: json['isbn13'],
      thumbnailURL: json['thumbnailURL'],
      title: json['title'],
      author: json['author'],
    );
  }
}

class SearchBook {
  final Dio dio;
  SearchBook({required this.dio});

  Future<List<SearchBookResDto>> searchBooks(String query, int page) async {
    try {
      final response = await dio.get(
        'http://13.125.145.165:3000/book/search',
        queryParameters: {'query': query, 'page': page},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final List<SearchBookResDto> searchResults =
            data.map((item) => SearchBookResDto.fromJson(item)).toList();
        return searchResults;
      } else {
        throw Exception('Failed to load search results');
      }
    } catch (e) {
      throw e;
    }
  }
}

//상태별 책장 조회
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

Future<List<BookshelfBookDto>> fetchBookshelfBooksByState(
    int progressState) async {
  final Dio dio = Dio();

  try {
    final response = await dio.get(
      'http://13.125.145.165:3000/book/bookshelf',
      queryParameters: {'progressState': progressState},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      final List<BookshelfBookDto> bookshelfBooks =
          data.map((item) => BookshelfBookDto.fromJson(item)).toList();
      return bookshelfBooks;
    } else {
      throw Exception('Failed to load bookshelf books');
    }
  } catch (e) {
    throw e;
  }
}

//책 상세정보 조회
class BookshelfBookDetailsDto {
  final int bookshelfBookId;
  final int progressState;
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

  BookshelfBookDetailsDto({
    required this.bookshelfBookId,
    required this.progressState,
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
  });

  factory BookshelfBookDetailsDto.fromJson(Map<String, dynamic> json) {
    return BookshelfBookDetailsDto(
      bookshelfBookId: json['bookshelfbookId'],
      progressState: json['progressState'],
      bookId: json['bookId'],
      title: json['title'],
      author: json['author'],
      content: json['content'],
      publisher: json['publisher'],
      thumbnailURL: json['thumbnailURL'],
      link: json['link'],
      category: json['category'],
      pages: json['pages'],
      startPage: json['startPage'],
      endPage: json['endPage'],
    );
  }

  @override
  String toString() {
    return 'BookshelfBookDetailsDto{bookshelfBookId: $bookshelfBookId, progressState: $progressState, bookId: $bookId, title: $title, author: $author, content: $content, publisher: $publisher, thumbnailURL: $thumbnailURL, link: $link, category: $category, pages: $pages, startPage: $startPage, endPage: $endPage}';
  }
}

class BookshelfRepository {
  final Dio dio;

  BookshelfRepository(this.dio);

  Future<BookshelfBookDetailsDto> getBookshelfBookDetails(
      int bookshelfBookId) async {
    try {
      final response = await dio.get(
        'http://13.125.145.165:3000/book/bookshelf/$bookshelfBookId',
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final BookshelfBookDetailsDto bookshelfBookDetails =
            BookshelfBookDetailsDto.fromJson(data);
        return bookshelfBookDetails;
      } else {
        throw Exception('Failed to load bookshelf book details');
      }
    } catch (e) {
      throw e;
    }
  }
}


/*Future<List<Map<String, String>>> fetchProfileData() async {
  var dio = Dio();
  var url = 'https://hello-t2pqd7uv4q-uc.a.run.app/group/members';

  try {
    final authHeaders = await getAuthHeader();
    // Response response = await _dio.post('/private-post',
    //     data: data, options: Options(headers: authHeaders));

    var response = await dio.get(url, options: Options(headers: authHeaders));

    if (response.statusCode == 200) {
      print("Response data: ${response.data}");
      List<dynamic> data = response.data;
      return data
          .map((item) => {
                'id': item['id'] as String,
                'nickName': item['name'] as String,
                'statusText': item['introduction'] as String,
                'imagePath': item['profile_image'] as String,
              })
          .toList();
    } else {
      throw Exception('Failed to load profiles');
    }
  } catch (e) {
    print('Request URL: $url');
    if (e is DioError) {
      print('DioError: ${e.response?.statusCode} ${e.response?.data}');
    } else {
      print('Error occurred: $e');
    }
    rethrow;
  }
}

Future<Map<String, dynamic>> updateStatusText(text) async {
  var dio = Dio();
  var url = 'https://hello-t2pqd7uv4q-uc.a.run.app/user';

  try {
    final authHeaders = await getAuthHeader();
    // Response response = await _dio.post('/private-post',
    //     data: data, options: Options(headers: authHeaders));

    var response = await dio.patch(
      url,
      data: {
        'introduction': text,
      },
      options: Options(headers: authHeaders)
    );

    if (response.statusCode == 200) {
      print("Response data: ${response.data}");
      Map<String, dynamic> data = response.data;
      return {
        'nickName': data['name'] as String,
        'statusText': data['introduction'] as String,
        'imagePath': data['profile_image'] as String,
      };
    } else {
      throw Exception('Failed to load profiles');
    }
  } catch (e) {
    print('Request URL: $url');
    if (e is DioError) {
      print('DioError: ${e.response?.statusCode} ${e.response?.data}');
    } else {
      print('Error occurred: $e');
    }
    rethrow;
  }
}

Future<Map<String, dynamic>> fetchMyProfile() async {
  var dio = Dio();
  var url = 'https://hello-t2pqd7uv4q-uc.a.run.app/user';

  try {
    final authHeaders = await getAuthHeader();
    // Response response = await _dio.post('/private-post',
    //     data: data, options: Options(headers: authHeaders));

    var response = await dio.get(
      url,
      options: Options(headers: authHeaders)
    );

    if (response.statusCode == 200) {
      print("Response data: ${response.data}");
      Map<String, dynamic> data = response.data;
      return ({
        'id': data['id'] as String,
        'nickName': data['name'] as String,
        'statusText': data['introduction'] as String,
        'imagePath': data['profile_image'] as String,
      });
    } else {
      throw Exception('Failed to load profiles');
    }
  } catch (e) {
    print('Request URL: $url');
    if (e is DioError) {
      print('DioError: ${e.response?.statusCode} ${e.response?.data}');
    } else {
      print('Error occurred: $e');
    }
    rethrow;
  }
}*/
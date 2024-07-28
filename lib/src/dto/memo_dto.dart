import 'package:reafy_front/src/dto/memo_dto.dart';

class Memo {
  final int memoId;
  final int userId;
  final int bookshelfBookId;
  final String content;
  final int page;
  final String? imageURL;
  final List<String> hashtag;
  final String createdAt;
  final String updatedAt;

  Memo({
    required this.memoId,
    required this.userId,
    required this.bookshelfBookId,
    required this.content,
    required this.page,
    this.imageURL,
    required this.hashtag,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Memo.fromJson(Map<String, dynamic> json) {
    return Memo(
      memoId: json['memoId'],
      userId: json['userId'],
      bookshelfBookId: json['bookshelfBookId'],
      content: json['content'],
      page: json['page'],
      imageURL: json['imageURL'],
      hashtag: List<String>.from(json['hashtag']),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class MemoResDto {
  final int totalItems;
  final int currentItems;
  final int totalPages;
  final int currentPage;
  final List<Memo> items;

  MemoResDto({
    required this.totalItems,
    required this.currentItems,
    required this.totalPages,
    required this.currentPage,
    required this.items,
  });

  factory MemoResDto.fromJson(Map<String, dynamic> json) {
    return MemoResDto(
      totalItems: json['totalItems'],
      currentItems: json['currentItems'],
      totalPages: json['totalPages'],
      currentPage: json['currentPage'],
      items: List<Memo>.from(json['item'].map((item) => Memo.fromJson(item))),
    );
  }
  factory MemoResDto.empty() {
    return MemoResDto(
      totalItems: 0,
      currentItems: 0,
      totalPages: 0,
      currentPage: 0,
      items: [],
    );
  }
}

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

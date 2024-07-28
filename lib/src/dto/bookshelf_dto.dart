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

// 독서 기록 저장 다이얼로그(stop dialog) 전용
class ReadingBookInfoDto {
  final int bookshelfBookId;
  final String title;

  ReadingBookInfoDto({
    required this.bookshelfBookId,
    required this.title,
  });

  factory ReadingBookInfoDto.fromJson(Map<String, dynamic> json) {
    return ReadingBookInfoDto(
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

class BookshelfBookTitleDto {
  final String title;

  BookshelfBookTitleDto({required this.title});

  factory BookshelfBookTitleDto.fromJson(Map<String, dynamic> json) {
    return BookshelfBookTitleDto(
      title: json['title'] as String? ?? '',
    );
  }
}

class Book {
  final String title;
  final String author;
  final String coverImageUrl;
  final String isbn13;

  Book({
    required this.title,
    required this.author,
    required this.coverImageUrl,
    required this.isbn13,
  });
}

Book convertToBook(SearchBookDto searchBook) {
  return Book(
    title: searchBook.title,
    author: searchBook.author,
    coverImageUrl: searchBook.thumbnailURL,
    isbn13: searchBook.isbn13,
  );
}

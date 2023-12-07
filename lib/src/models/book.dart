import 'package:reafy_front/src/repository/bookshelf_repository.dart';

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

Book convertToBook(SearchBookResDto searchBook) {
  return Book(
    title: searchBook.title,
    author: searchBook.author,
    coverImageUrl: searchBook.thumbnailURL,
    isbn13: searchBook.isbn13,
  );
}

List<String> getThumbnailsFromBookshelfBooks(List<BookshelfBookDto> books) {
  return books.map((book) => book.thumbnailURL).toList();
}

/*List<Book> getrecentBooks() {
  return [
    Book(
      title: "더 마인드 - 무의식이 이끄는 부의 해답",
      author: "하와이 대저택",
      coverImageUrl:
          "https://marketplace.canva.com/EAD161UHRIg/1/0/1003w/canva-%ED%8C%8C%EB%9E%80%EC%83%89-%EC%82%AC%EC%A7%84-%EA%B3%BC%ED%95%99-%EC%86%8C%EC%84%A4-%EC%B1%85-%ED%91%9C%EC%A7%80-W-oW2VKWuGo.jpg",
    ),
    Book(
      title: "30분 성경공부 (개정판) - 믿음편 성숙",
      author: "이대희",
      coverImageUrl:
          "https://marketplace.canva.com/EAD14jktTrs/1/0/1003w/canva-%EB%B6%84%ED%99%8D%EC%83%89-%EB%B0%8F-%EB%82%A8%EC%83%89-%EA%B0%84%EC%86%8C%ED%95%9C-%ED%8C%A8%EC%85%98-%EC%B1%85-%ED%91%9C%EC%A7%80-yvGB8zsL-ws.jpg",
    ),
    Book(
      title: "트렌드 코리아 2024 - 청룡을 타고 비상하는 2024를 기원하며",
      author: "김난도,전미영,최지혜,이수진,권정윤,한다혜,이준영,이향은,이혜원,추예린,전다현",
      coverImageUrl:
          "https://help.miricanvas.com/hc/article_attachments/900002729126/_____________14_.png",
    ),
  ];
}

List<Book> getwishlistBooks() {
  return [
    Book(
      title: "방구석 오페라",
      author: "이서희",
      coverImageUrl:
          "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791186151655.jpg",
    ),
    Book(
      title: "더 마인드 - 무의식이 이끄는 부의 해답",
      author: "하와이 대저택",
      coverImageUrl:
          "https://marketplace.canva.com/EAD161UHRIg/1/0/1003w/canva-%ED%8C%8C%EB%9E%80%EC%83%89-%EC%82%AC%EC%A7%84-%EA%B3%BC%ED%95%99-%EC%86%8C%EC%84%A4-%EC%B1%85-%ED%91%9C%EC%A7%80-W-oW2VKWuGo.jpg",
    ),

    Book(
      title: "퓨처 셀프 - 현재와 미래가 달라지는 놀라운 혁명",
      author: "벤저민 하디,최은아",
      coverImageUrl:
          "https://marketplace.canva.com/EAD15aR5d9Q/1/0/1003w/canva-%EB%B9%A8%EA%B0%84%EC%83%89-%EC%84%A0-%ED%83%80%EC%9D%B4%ED%8F%AC%EA%B7%B8%EB%9E%98%ED%94%BC-%EC%B1%85-%ED%91%9C%EC%A7%80-c8x7Zq9gXno.jpg",
    ),
    Book(
      title: "Diary of a Wimpy Kid 18 No Brainer (미국판)",
      author: "제프 키니",
      coverImageUrl:
          "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791188331796.jpg",
    ),
    Book(
      title: "나만 옳다는 착각",
      author: "크리스토퍼 J. 퍼거슨 ",
      coverImageUrl:
          "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791197578038.jpg",
    ),

    Book(
      title: "고통 구경하는 사회",
      author: "김인정 ",
      coverImageUrl:
          "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791192097633.jpg",
    ),
    // Add more mock books as needed
  ];
}*/

List<Book> getfinishedBooks() {
  return [
    Book(
      title: "퓨처 셀프 - 현재와 미래가 달라지는 놀라운 혁명",
      author: "벤저민 하디,최은아",
      coverImageUrl:
          "https://marketplace.canva.com/EAD15aR5d9Q/1/0/1003w/canva-%EB%B9%A8%EA%B0%84%EC%83%89-%EC%84%A0-%ED%83%80%EC%9D%B4%ED%8F%AC%EA%B7%B8%EB%9E%98%ED%94%BC-%EC%B1%85-%ED%91%9C%EC%A7%80-c8x7Zq9gXno.jpg",
      isbn13: "a", //임시설정
    ),
    Book(
      title: "Diary of a Wimpy Kid 18 No Brainer (미국판)",
      author: "제프 키니",
      coverImageUrl:
          "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791188331796.jpg",
      isbn13: "a", //임시설정
    ),
    Book(
      title: "나만 옳다는 착각",
      author: "크리스토퍼 J. 퍼거슨 ",
      coverImageUrl:
          "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791197578038.jpg",
      isbn13: "a", //임시설정
    ),
    Book(
      title: "방구석 오페라",
      author: "이서희",
      coverImageUrl:
          "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791186151655.jpg",
      isbn13: "a", //임시설정
    ),
    Book(
      title: "고통 구경하는 사회",
      author: "김인정 ",
      coverImageUrl:
          "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791192097633.jpg",
      isbn13: "a", //임시설정
    ),
    // Add more mock books as needed
  ];
}

List<Book> getMockBooks() {
  return [
    Book(
      title: "더 마인드 - 무의식이 이끄는 부의 해답",
      author: "하와이 대저택",
      coverImageUrl:
          "https://marketplace.canva.com/EAD161UHRIg/1/0/1003w/canva-%ED%8C%8C%EB%9E%80%EC%83%89-%EC%82%AC%EC%A7%84-%EA%B3%BC%ED%95%99-%EC%86%8C%EC%84%A4-%EC%B1%85-%ED%91%9C%EC%A7%80-W-oW2VKWuGo.jpg",
      isbn13: "a", //임시설정
    ),
    Book(
      title: "30분 성경공부 (개정판) - 믿음편 성숙",
      author: "이대희",
      coverImageUrl:
          "https://marketplace.canva.com/EAD14jktTrs/1/0/1003w/canva-%EB%B6%84%ED%99%8D%EC%83%89-%EB%B0%8F-%EB%82%A8%EC%83%89-%EA%B0%84%EC%86%8C%ED%95%9C-%ED%8C%A8%EC%85%98-%EC%B1%85-%ED%91%9C%EC%A7%80-yvGB8zsL-ws.jpg",
      isbn13: "a", //임시설정
    ),
    Book(
      title: "트렌드 코리아 2024 - 청룡을 타고 비상하는 2024를 기원하며",
      author: "김난도,전미영,최지혜,이수진,권정윤,한다혜,이준영,이향은,이혜원,추예린,전다현",
      coverImageUrl:
          "https://help.miricanvas.com/hc/article_attachments/900002729126/_____________14_.png",
      isbn13: "a", //임시설정
    ),
    Book(
      title: "퓨처 셀프 - 현재와 미래가 달라지는 놀라운 혁명",
      author: "벤저민 하디,최은아",
      coverImageUrl:
          "https://marketplace.canva.com/EAD15aR5d9Q/1/0/1003w/canva-%EB%B9%A8%EA%B0%84%EC%83%89-%EC%84%A0-%ED%83%80%EC%9D%B4%ED%8F%AC%EA%B7%B8%EB%9E%98%ED%94%BC-%EC%B1%85-%ED%91%9C%EC%A7%80-c8x7Zq9gXno.jpg",
      isbn13: "a", //임시설정
    ),
    Book(
      title: "Diary of a Wimpy Kid 18 No Brainer (미국판)",
      author: "제프 키니",
      coverImageUrl:
          "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791188331796.jpg",
      isbn13: "a", //임시설정
    ),
    Book(
      title: "나만 옳다는 착각",
      author: "크리스토퍼 J. 퍼거슨 ",
      coverImageUrl:
          "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791197578038.jpg",
      isbn13: "a", //임시설정
    ),
    Book(
      title: "방구석 오페라",
      author: "이서희",
      coverImageUrl:
          "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791186151655.jpg",
      isbn13: "a", //임시설정
    ),
    Book(
      title: "고통 구경하는 사회",
      author: "김인정 ",
      coverImageUrl:
          "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791192097633.jpg",
      isbn13: "a", //임시설정
    ),
    // Add more mock books as needed
  ];
}

List<Book> mockSearchResults = [
  Book(
    title: "더 마인드 - 무의식이 이끄는 부의 해답",
    author: "하와이 대저택",
    coverImageUrl:
        "https://marketplace.canva.com/EAD161UHRIg/1/0/1003w/canva-%ED%8C%8C%EB%9E%80%EC%83%89-%EC%82%AC%EC%A7%84-%EA%B3%BC%ED%95%99-%EC%86%8C%EC%84%A4-%EC%B1%85-%ED%91%9C%EC%A7%80-W-oW2VKWuGo.jpg",
    isbn13: "a", //임시설정
  ),
  Book(
    title: "30분 성경공부 (개정판) - 믿음편 성숙",
    author: "이대희",
    coverImageUrl:
        "https://marketplace.canva.com/EAD14jktTrs/1/0/1003w/canva-%EB%B6%84%ED%99%8D%EC%83%89-%EB%B0%8F-%EB%82%A8%EC%83%89-%EA%B0%84%EC%86%8C%ED%95%9C-%ED%8C%A8%EC%85%98-%EC%B1%85-%ED%91%9C%EC%A7%80-yvGB8zsL-ws.jpg",
    isbn13: "a", //임시설정
  ),
  Book(
    title: "트렌드 코리아 2024 - 청룡을 타고 비상하는 2024를 기원하며",
    author: "김난도,전미영,최지혜,이수진,권정윤,한다혜,이준영,이향은,이혜원,추예린,전다현",
    coverImageUrl:
        "https://help.miricanvas.com/hc/article_attachments/900002729126/_____________14_.png",
    isbn13: "a", //임시설정
  ),
  Book(
    title: "퓨처 셀프 - 현재와 미래가 달라지는 놀라운 혁명",
    author: "벤저민 하디,최은아",
    coverImageUrl:
        "https://marketplace.canva.com/EAD15aR5d9Q/1/0/1003w/canva-%EB%B9%A8%EA%B0%84%EC%83%89-%EC%84%A0-%ED%83%80%EC%9D%B4%ED%8F%AC%EA%B7%B8%EB%9E%98%ED%94%BC-%EC%B1%85-%ED%91%9C%EC%A7%80-c8x7Zq9gXno.jpg",
    isbn13: "a", //임시설정
  ),
  Book(
    title: "Diary of a Wimpy Kid 18 No Brainer (미국판)",
    author: "제프 키니",
    coverImageUrl:
        "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791188331796.jpg",
    isbn13: "a", //임시설정
  ),
  Book(
    title: "나만 옳다는 착각",
    author: "크리스토퍼 J. 퍼거슨 ",
    coverImageUrl:
        "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791197578038.jpg",
    isbn13: "a", //임시설정
  ),
  Book(
    title: "방구석 오페라",
    author: "이서희",
    coverImageUrl:
        "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791186151655.jpg",
    isbn13: "a", //임시설정
  ),
  Book(
    title: "고통 구경하는 사회",
    author: "김인정 ",
    coverImageUrl:
        "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791192097633.jpg",
    isbn13: "a", //임시설정
  ),
  // Add more mock books as needed
];

List<Book> mockDisplayResults = [
  Book(
    title: "더 마인드 - 무의식이 이끄는 부의 해답",
    author: "하와이 대저택",
    coverImageUrl:
        "https://marketplace.canva.com/EAD161UHRIg/1/0/1003w/canva-%ED%8C%8C%EB%9E%80%EC%83%89-%EC%82%AC%EC%A7%84-%EA%B3%BC%ED%95%99-%EC%86%8C%EC%84%A4-%EC%B1%85-%ED%91%9C%EC%A7%80-W-oW2VKWuGo.jpg",
    isbn13: "a", //임시설정
  ),
  Book(
    title: "30분 성경공부 (개정판) - 믿음편 성숙",
    author: "이대희",
    coverImageUrl:
        "https://marketplace.canva.com/EAD14jktTrs/1/0/1003w/canva-%EB%B6%84%ED%99%8D%EC%83%89-%EB%B0%8F-%EB%82%A8%EC%83%89-%EA%B0%84%EC%86%8C%ED%95%9C-%ED%8C%A8%EC%85%98-%EC%B1%85-%ED%91%9C%EC%A7%80-yvGB8zsL-ws.jpg",
    isbn13: "a", //임시설정
  ),
  Book(
    title: "트렌드 코리아 2024 - 청룡을 타고 비상하는 2024를 기원하며",
    author: "김난도,전미영,최지혜,이수진,권정윤,한다혜,이준영,이향은,이혜원,추예린,전다현",
    coverImageUrl:
        "https://help.miricanvas.com/hc/article_attachments/900002729126/_____________14_.png",
    isbn13: "a", //임시설정
  ),
  Book(
    title: "퓨처 셀프 - 현재와 미래가 달라지는 놀라운 혁명",
    author: "벤저민 하디,최은아",
    coverImageUrl:
        "https://marketplace.canva.com/EAD15aR5d9Q/1/0/1003w/canva-%EB%B9%A8%EA%B0%84%EC%83%89-%EC%84%A0-%ED%83%80%EC%9D%B4%ED%8F%AC%EA%B7%B8%EB%9E%98%ED%94%BC-%EC%B1%85-%ED%91%9C%EC%A7%80-c8x7Zq9gXno.jpg",
    isbn13: "a", //임시설정
  ),
  // Add more mock books as needed
];

Future<List<Book>> fetchSearchResults(String query) async {
  // 여기에서는 백엔드와의 통신을 대신하여 임시 데이터를 반환합니다.
  // 실제로는 백엔드와의 API 호출 또는 데이터베이스 쿼리를 수행하여 검색 결과를 가져올 것입니다.
  // 임시 데이터를 1초 후에 반환하도록 설정 (실제로는 백엔드 응답을 기다릴 필요가 있습니다)

  await Future.delayed(Duration(seconds: 5));
  // 임시 데이터 반환
  return mockSearchResults
      .where((book) =>
          book.title.toLowerCase().contains(query.toLowerCase()) ||
          book.author.toLowerCase().contains(query.toLowerCase()))
      .toList();
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/components/book_card.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/models/book.dart';
import 'package:reafy_front/src/utils/constants.dart';
import 'dart:math';
import 'package:reafy_front/src/repository/bookshelf_repository.dart';
import 'package:dio/dio.dart';

class Quote {
  final String author;
  final String text;

  Quote({
    required this.author,
    required this.text,
  });
}

class SearchBook extends StatefulWidget {
  const SearchBook({super.key});

  @override
  State<SearchBook> createState() => _SearchBookState();
}

class _SearchBookState extends State<SearchBook> {
  List<Book> displayList = List.from(mockSearchResults);
  TextEditingController _searchController = TextEditingController();
  final Random _random = Random();

  /*late SearchBook searchBook;

  @override
  void initState() {
    super.initState();
    searchBook = SearchBook(dio: Dio());
  }*/

  final List<Quote> quotes = [
    Quote(text: "책 없는 방은 영혼 없는 육체와도 같다.", author: "키케로"),
    Quote(text: "좋은 책은 좋은 친구와 같다.", author: "생피에르"),
    Quote(text: "독서는 정신의 음악이다.", author: "소크라테스"),
    Quote(text: "독서는 하나의 창조 과정이다.", author: "에렌부르그"),
    Quote(text: "그저 생각하고, 생활을 위해 독서하라.", author: "베이컨"),
    Quote(text: "좋은 책은 인류에게 불멸의 정신이다.", author: "J.밀턴"),
    Quote(text: "내가 세계를 알게 된 것은 책에 의해서였다.", author: "사르트르"),
  ];

  bool isSearching = true;

  void _performSearch(String query) {
    setState(() {
      isSearching = true;
    });
    fetchSearchResults(query).then((searchResults) {
      setState(() {
        isSearching = false;
        displayList = List.from(searchResults);
      });
    });
  }

  Widget _search() {
    return Container(
      //padding: EdgeInsets.symmetric(horizontal: 25),
      width: 341,
      height: 40,
      child: TextField(
        controller: _searchController,
        onSubmitted: (query) {
          _performSearch(query);
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xffFFF7DA),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Color(0xffFFF7DA)),
          ),
          hintText: "어떤 책을 찾으세요?",
          hintStyle: TextStyle(
              color: Color(0xff666666),
              fontSize: 14,
              fontWeight: FontWeight.w400),
          suffixIcon: Icon(
            Icons.search,
            color: Color(0xffFFCA0E),
          ),
        ),
      ),
    );
  }

  Widget _character() {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: 206,
        height: 233.955, // 적절한 높이 설정
        child: ImageData(IconsPath.character2),
      ),
    ));
  }

  Widget _quotes() {
    final int randomIndex = _random.nextInt(quotes.length);
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 11),
          width: 63,
          height: 14,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
            color: Color(0xffFFF7D9),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 20,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Center(
            child: Text(
              quotes[randomIndex].author,
              style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
        Container(
          width: 245,
          height: 43,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFFFAF9F7),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 20,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Center(
            child: Text(
              quotes[randomIndex].text,
              style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 12,
                  fontWeight: FontWeight.w700),
            ),
          ),
        )
      ],
    ));
  }

  Widget _renderResults() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color(0xFFFAF9F7),
            Color(0xFFEBEBEB),
            Color(0xFFEBEBEB),
            Color(0xFFFAF9F7)
          ],
          stops: [0, 0.1, 0.9, 1],
          transform: GradientRotation(1.5708),
        )),
        child: ListView.builder(
          itemCount: displayList.length,
          itemBuilder: (context, index) => BookCard(book: displayList[index]),
        ),

        /*child: FutureBuilder<List<SearchBookResDto>>(
          // 검색 결과를 가져오는 비동기 함수
          future: searchBook.searchBooks(
              _searchController.text, 1), // 예시로 페이지를 1로 고정
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data!.isEmpty) {
              return Center(child: Text('일치하는 도서가 없어요.'));
            } else if (snapshot.hasData) {
              List<SearchBookResDto> searchResults = snapshot.data!;
              return ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  SearchBookResDto book = searchResults[index];
                  return ListTile(
                    title: Text(book.title),
                    subtitle: Text(book.author),
                    // 기타 책 정보를 표시할 수 있는 위젯 추가
                    // 예: 이미지, 출판사, 출판일 등
                  );
                },
              );
            }
            return Container(); // 아무것도 표시하지 않을 경우 빈 컨테이너 반환
          },
        ),*/
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "책을 추가해주세요!",
            style: TextStyle(
                color: Color(0xff333333),
                fontWeight: FontWeight.w700,
                fontSize: 18),
          ),
          foregroundColor: Color.fromARGB(255, 22, 20, 20),
          backgroundColor: Colors.transparent,
          elevation: 0,
          //leading: IconButton(
          //  icon: Icon(Icons.arrow_back_ios, color: Color(0xff333333)),
          //  onPressed: () {
          //    Get.back(); // Navigator.pop 대신 Get.back()을 사용합니다.
          //  },
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/addbook_background.png'),
                fit: BoxFit.fill,
              ),
            ),
            width: size.width,
            height: size.height,
            child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFFAF9F7),
                      Color.fromRGBO(250, 249, 247, 0.0),
                    ],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        _search(),

                        _searchController.text.isEmpty
                            ? ListView(
                                shrinkWrap: true,
                                children: <Widget>[
                                  SizedBox(
                                    height: 290,
                                  ),
                                  _character(),
                                  _quotes(),
                                  SizedBox(height: 44.73),
                                ],
                              )
                            : _renderResults(),

                        //const Spacer(flex: 1),
                      ]),
                ))));
  }
}

/*
    FutureBuilder<List<Book>>(
        future: fetchSearchResults(query), // 검색 결과를 가져오는 비동기 함수
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); // 로딩 중이면 로딩 이미지를 가운데에 표시
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
                    'Error: ${snapshot.error}')); // 에러가 발생하면 에러 메시지를 가운데에 표시
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return Center(
                child: Text('일치하는 도서가 없어요.')); // 결과가 없으면 해당 메시지를 가운데에 표시
          } else if (snapshot.hasData) {
            List<Book> searchResults = snapshot.data!;
          }
        });*/



/*
  Widget _searchresult(String query) {
    return FutureBuilder<List<Book>>(
      future: fetchSearchResults(query), // 검색 결과를 가져오는 비동기 함수
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator()); // 로딩 중이면 로딩 이미지를 가운데에 표시
        } else if (snapshot.hasError) {
          return Center(
              child:
                  Text('Error: ${snapshot.error}')); // 에러가 발생하면 에러 메시지를 가운데에 표시
        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
          return Center(
              child: Text('일치하는 도서가 없어요.')); // 결과가 없으면 해당 메시지를 가운데에 표시
        } else if (snapshot.hasData) {
          List<Book> searchResults = snapshot.data!;
          return Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                Book book = searchResults[index];
                return ListTile(
                  title: Text(book.title),
                  subtitle: Text(book.author),
                  // 기타 책 정보를 표시할 수 있는 위젯 추가
                  // 예: 이미지, 출판사, 출판일 등
                );
              },
            ),
          );
        }
        return Container(); // 아무것도 표시하지 않을 경우 빈 컨테이너 반환
      },
    );
  }
  */
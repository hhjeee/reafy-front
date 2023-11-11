import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/components/book_card.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/models/book.dart';
import 'package:reafy_front/src/utils/constants.dart';

class SearchBook extends StatefulWidget {
  const SearchBook({super.key});

  @override
  State<SearchBook> createState() => _SearchBookState();
}

class _SearchBookState extends State<SearchBook> {
  List<Book> displayList = List.from(mockSearchResults);
  TextEditingController _searchController = TextEditingController();

  bool isSearching = true;

  void _performSearch(String query) {
    setState(() {
      isSearching = true;
    });

    fetchSearchResults(query).then((searchResults) {
      setState(() {
        isSearching = true;
        displayList = List.from(searchResults);
      });
    });
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
  }

  Widget _search() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
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
          hintText: "도서명를 입력해주세요",
          hintStyle: TextStyle(
              color: Color(0xff6A6A6A),
              fontSize: 14,
              fontWeight: FontWeight.w400),
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xffFFCA0E),
          ),
        ),
      ),
    );
  }

  Widget _character() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: 390,
        height: 392, // 적절한 높이 설정
        decoration: BoxDecoration(
            gradient: RadialGradient(
          radius: 1.1086, // 110.86%의 크기
          colors: [
            Color(0xFFE2EEE0), // 시작 색상
            bgColor // 끝 색상 (투명)
          ],
          stops: [0.2197, 0.5], // 각 색상의 정지점 (0.2197는 21.97%의 위치)
        )),
        child: ImageData(IconsPath.character),
      ),
    );
  }

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
        // 검색 결과의 배경색 설정 (회색: #EBEBEB)
        child: ListView.builder(
          itemCount: displayList.length,
          itemBuilder: (context, index) => BookCard(book: displayList[index]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _search(),
                SizedBox(
                  height: 10,
                ),
                _renderResults(),
                //const Spacer(flex: 1),
              ]),
        )));
  }
}

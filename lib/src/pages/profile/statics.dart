import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/components/page_graph.dart';
import 'package:reafy_front/src/components/time_graph.dart';
import 'package:reafy_front/src/repository/statics_repository.dart';

class Statics extends StatefulWidget {
  const Statics({super.key});

  @override
  State<Statics> createState() => _StaticsState();
}

class _StaticsState extends State<Statics> {
  int currentYear = DateTime.now().year;
  int selectedPageYear = DateTime.now().year;
  int selectedTimeYear = DateTime.now().year;
  List<int> yearList = [];

  @override
  void initState() {
    super.initState();
    _initYearList();
  }

  void _initYearList() {
    final int startYear = 2020; // 시작 연도
    final int endYear = DateTime.now().year; // 현재 연도

    for (int year = startYear; year <= endYear; year++) {
      yearList.add(year);
    }
  }

  void onYearPageChanged(int newYear) {
    setState(() {
      selectedPageYear = newYear;
    });
  }

  void onYearTimeChanged(int newYear) {
    setState(() {
      selectedTimeYear = newYear;
    });
  }

  Future<List<Map<String, dynamic>>> _loadMonthlyPageStatistics() async {
    return await getMonthlyPageStatistics(selectedPageYear);
  }

  Future<List<Map<String, dynamic>>> _loadMonthlyTimeStatistics() async {
    return await getMonthlyTimeStatistics(selectedTimeYear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black54),
            onPressed: () {
              Get.back(); // Navigator.pop 대신 Get.back()을 사용합니다.
            },
          ),
          title: Text(
            "통계",
            style: TextStyle(
                color: Color(0xff333333),
                fontWeight: FontWeight.w800,
                fontSize: 16),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _loadMonthlyPageStatistics(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // 데이터 로딩 중
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // 에러 발생시
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  // 데이터가 있는 경우
                  List<double> monthlyPage = snapshot.data!
                      .map(
                          (data) => double.parse(data['totalPages'].toString()))
                      .toList();
                  return buildPageGraphContainer(
                      context,
                      '월별 읽은 페이지',
                      monthlyPage,
                      yearList,
                      selectedPageYear,
                      onYearPageChanged);
                } else {
                  // 데이터가 없는 경우
                  return Text('No data available');
                }
              },
            ),
            SizedBox(height: 10),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _loadMonthlyTimeStatistics(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // 데이터 로딩 중
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // 에러 발생시
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  // 데이터가 있는 경우
                  List<double> monthlyTime = snapshot.data!
                      .map((data) =>
                          double.parse(data['totalReadingTimes'].toString()) /
                          60) // 분을 시간으로 변환
                      .toList();
                  return buildTimeGraphContainer(
                      context,
                      '월별 독서 시간',
                      monthlyTime,
                      yearList,
                      selectedTimeYear,
                      onYearTimeChanged);
                } else {
                  // 데이터가 없는 경우
                  return Text('No data available');
                }
              },
            ),
          ],
        )));
  }
}

Widget buildPageGraphContainer(
    BuildContext context,
    String title,
    List<double> monthlyPage,
    List<int> yearList,
    int selectedYear,
    Function(int) onYearChanged) {
  return Container(
    width: double.infinity,
    height: 650,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: const Color(0xFFFAF9F7),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          offset: Offset(0, 0),
          blurRadius: 20,
          spreadRadius: 0,
        ),
      ],
    ),
    child: Column(
      children: [
        SizedBox(height: 20),
        Container(
          width: 130,
          height: 35.684,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: const Color(0xFFFAF9F7),
            border: Border.all(color: Colors.transparent, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: Offset(0, 0),
                blurRadius: 4,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Color(0xff63b865), width: 2),
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff63b865),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            DropdownButton<int>(
              value: selectedYear,
              underline: Container(),
              icon: ImageData(
                IconsPath.dropdown,
                isSvg: true,
              ),
              items: yearList.map<DropdownMenuItem<int>>((int year) {
                return DropdownMenuItem<int>(
                  value: year,
                  child: Text(
                    year.toString(),
                    style: TextStyle(
                        color: Color.fromARGB(255, 17, 10, 10),
                        fontWeight: FontWeight.w700,
                        fontSize: 12),
                  ),
                );
              }).toList(),
              onChanged: (int? newValue) {
                if (newValue != null) {
                  onYearChanged(newValue);
                }
              },
            ),
          ]),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: 520,
            child: PageBarGraph(
              monthlyPage: monthlyPage,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildTimeGraphContainer(
    BuildContext context,
    String title,
    List<double> monthlyTime,
    List<int> yearList,
    int selectedYear,
    Function(int) onYearChanged) {
  return Container(
    width: double.infinity,
    height: 650,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: const Color(0xFFFAF9F7),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          offset: Offset(0, 0),
          blurRadius: 20,
          spreadRadius: 0,
        ),
      ],
    ),
    child: Column(
      children: [
        SizedBox(height: 20),
        Container(
          width: 130,
          height: 35.684,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: const Color(0xFFFAF9F7),
            border: Border.all(color: Colors.transparent, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: Offset(0, 0),
                blurRadius: 4,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Color(0xff63b865), width: 2),
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff63b865),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DropdownButton<int>(
                value: selectedYear,
                underline: Container(),
                icon: ImageData(IconsPath.dropdown, isSvg: true, width: 12),
                items: yearList.map<DropdownMenuItem<int>>((int year) {
                  return DropdownMenuItem<int>(
                    value: year,
                    child: Text(
                      year.toString(),
                      style: TextStyle(
                          color: Color.fromARGB(255, 17, 10, 10),
                          fontWeight: FontWeight.w700,
                          fontSize: 12),
                    ),
                  );
                }).toList(),
                onChanged: (int? newValue) {
                  if (newValue != null) {
                    onYearChanged(newValue);
                  }
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: 520,
            child: TimeBarGraph(
              monthlyTime: monthlyTime,
            ),
          ),
        ),
      ],
    ),
  );
}

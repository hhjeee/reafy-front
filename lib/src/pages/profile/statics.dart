import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/repository/statics_repository.dart';
import 'package:reafy_front/src/utils/constants.dart';
import 'package:fl_chart/fl_chart.dart';

class Statics extends StatelessWidget {
  const Statics({super.key});

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
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
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
                      width: 100,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Color(0xff63b865), width: 2),
                      ),
                      child: Center(
                        child: Text(
                          '월별 독서 시간',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Color(0xff63b865),
                          ),
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: getMonthlyTimeStatistics(DateTime.now().year),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          List<BarChartGroupData> barGroups = [];

                          for (int i = 0; i < snapshot.data!.length; i++) {
                            final data = snapshot.data![i];
                            final monthNumString = data['month']?.split("-")[1];
                            final readingTimeString =
                                data['totalReadingTimes'] as String?;

                            if (monthNumString != null &&
                                readingTimeString != null) {
                              final monthNum = int.tryParse(monthNumString);
                              final readingTime =
                                  double.tryParse(readingTimeString);

                              print(
                                  'monthNum: $monthNum, readingTime: $readingTime');

                              if (monthNum != null &&
                                  readingTime != null &&
                                  readingTime.isFinite) {
                                barGroups.add(
                                  BarChartGroupData(
                                    x: monthNum - 1,
                                    barRods: [
                                      BarChartRodData(
                                        fromY: 0,
                                        color: Color(0xff63b865),
                                        borderRadius: BorderRadius.circular(3),
                                        toY: readingTime > 0 ? readingTime : 0,
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          }
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: BarChart(
                              BarChartData(
                                alignment: BarChartAlignment.spaceAround,
                                maxY: 80, // 최대 Y 값
                                titlesData: FlTitlesData(
                                  show: true,
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 30,
                                      getTitlesWidget:
                                          (double value, TitleMeta meta) {
                                        final titles = [
                                          '1월',
                                          '2월',
                                          '3월',
                                          '4월',
                                          '5월',
                                          '6월',
                                          '7월',
                                          '8월',
                                          '9월',
                                          '10월',
                                          '11월',
                                          '12월'
                                        ];
                                        return SideTitleWidget(
                                          axisSide: meta.axisSide,
                                          space: 16, // 타이틀과 축 사이의 공간을 조정하세요.
                                          child: Text(titles[value.toInt()],
                                              style: TextStyle(
                                                  color: Color(0xff7589a2),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14)),
                                        );
                                      },
                                    ),
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                ),
                                /*borderData: FlBorderData(
                                  show: false,
                                ),
                                barGroups: barGroups,*/
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ],
              ),
            ),
          ],
        )));
  }
}

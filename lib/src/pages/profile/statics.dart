// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:reafy_front/src/repository/statics_repository.dart';
// import 'package:reafy_front/src/utils/constants.dart';
// import 'package:fl_chart/fl_chart.dart';

// class Statics extends StatelessWidget {
//   const Statics({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back_ios, color: Colors.black54),
//             onPressed: () {
//               Get.back(); // Navigator.pop 대신 Get.back()을 사용합니다.
//             },
//           ),
//           title: Text(
//             "통계",
//             style: TextStyle(
//                 color: Color(0xff333333),
//                 fontWeight: FontWeight.w800,
//                 fontSize: 16),
//           ),
//         ),
//         body: SingleChildScrollView(
//             child: Column(
//           children: [
//             Container(
//               margin: EdgeInsets.symmetric(vertical: 5),
//               width: double.infinity,
//               height: 650,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: const Color(0xFFFAF9F7),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     offset: Offset(0, 0),
//                     blurRadius: 20,
//                     spreadRadius: 0,
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   SizedBox(height: 20),
//                   Container(
//                     width: 130,
//                     height: 35.684,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(4),
//                       color: const Color(0xFFFAF9F7),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.25),
//                           offset: Offset(0, 0),
//                           blurRadius: 4,
//                           spreadRadius: 0,
//                         ),
//                       ],
//                     ),
//                     child: Container(
//                       width: 100,
//                       height: 20,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(4),
//                         border: Border.all(color: Color(0xff63b865), width: 2),
//                       ),
//                       child: Center(
//                         child: Text(
//                           '월별 독서 시간',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w800,
//                             color: Color(0xff63b865),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   FutureBuilder<List<Map<String, dynamic>>>(
//                     future: getMonthlyTimeStatistics(
//                         DateTime.now().year), // 데이터를 가져오는 함수
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.done) {
//                         if (snapshot.hasData) {
//                           // 데이터가 있으면 막대 그래프를 그립니다.
//                           List<BarChartGroupData> barGroups = [];
//                           for (int i = 0; i < snapshot.data!.length; i++) {
//                             final data = snapshot.data![i];
//                             final monthNum = int.parse(data['month']
//                                 .split("-")[1]); // "2024-01"에서 "01"을 추출합니다.
//                             final readingTime = double.parse(data[
//                                 'totalReadingTimes']); // 문자열을 double로 변환합니다.

//                             barGroups.add(
//                               BarChartGroupData(
//                                 x: monthNum - 1,
//                                 barRods: [
//                                   BarChartRodData(
//                                     fromY: readingTime,
//                                     color: Color(0xff63b865), // 막대의 색상
//                                     borderRadius:
//                                         BorderRadius.circular(3), // 막대의 모서리 둥글기
//                                     toY: 0,
//                                   ),
//                                 ],
//                               ),
//                             );
//                           }
//                           return Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: BarChart(
//                               BarChartData(
//                                 alignment: BarChartAlignment.spaceAround,
//                                 maxY: 20, // 최대 Y 값
//                                 barTouchData: BarTouchData(
//                                   touchTooltipData: BarTouchTooltipData(
//                                     tooltipBgColor: Colors.blueGrey,
//                                     getTooltipItem: (_a, _b, _c, _d) => null,
//                                   ),
//                                 ),
//                                 titlesData: FlTitlesData(
//                                   show: true,
//                                   bottomTitles: AxisTitles(
//                                     sideTitles: SideTitles(
//                                       showTitles: true,
//                                       reservedSize: 30,
//                                       getTitlesWidget:
//                                           (double value, TitleMeta meta) {
//                                         final titles = [
//                                           '1월',
//                                           '2월',
//                                           '3월',
//                                           '4월',
//                                           '5월',
//                                           '6월',
//                                           '7월',
//                                           '8월',
//                                           '9월',
//                                           '10월',
//                                           '11월',
//                                           '12월'
//                                         ];
//                                         return SideTitleWidget(
//                                           axisSide: meta.axisSide,
//                                           space: 16, // 타이틀과 축 사이의 공간을 조정하세요.
//                                           child: Text(titles[value.toInt()],
//                                               style: TextStyle(
//                                                   color: Color(0xff7589a2),
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 14)),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                   leftTitles: AxisTitles(
//                                     sideTitles: SideTitles(showTitles: false),
//                                   ),
//                                 ),
//                                 borderData: FlBorderData(
//                                   show: false,
//                                 ),
//                                 barGroups: barGroups,
//                               ),
//                             ),
//                           );
//                         } else if (snapshot.hasError) {
//                           return Text('Error: ${snapshot.error}');
//                         }
//                       }
//                       return Center(child: CircularProgressIndicator());
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         )));
//   }
// }

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:reafy_front/src/dto/bar_dto.dart';

class TimeBarGraph extends StatefulWidget {
  final List monthlyTime;
  const TimeBarGraph({super.key, required this.monthlyTime});

  @override
  State<TimeBarGraph> createState() => _TimeBarGraphState();
}

class _TimeBarGraphState extends State<TimeBarGraph> {
  int startMonth = 0;
  int endMonth = 5;

  void _nextRange() {
    setState(() {
      startMonth += 6;
      endMonth += 6;
    });
  }

  void _previousRange() {
    setState(() {
      startMonth -= 6;
      endMonth -= 6;
    });
  }

  @override
  Widget build(BuildContext context) {
    BarData timeBarData = BarData(
      janAmount: widget.monthlyTime[0],
      febAmount: widget.monthlyTime[1],
      marAmount: widget.monthlyTime[2],
      aprAmount: widget.monthlyTime[3],
      mayAmount: widget.monthlyTime[4],
      junAmount: widget.monthlyTime[5],
      julAmount: widget.monthlyTime[6],
      augAmount: widget.monthlyTime[7],
      sepAmount: widget.monthlyTime[8],
      octAmount: widget.monthlyTime[9],
      novAmount: widget.monthlyTime[10],
      decAmount: widget.monthlyTime[11],
    );

    timeBarData.initializeBarData();

    List<BarChartGroupData> barGroups = [];

    for (int i = startMonth; i <= endMonth; i++) {
      barGroups.add(BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: widget.monthlyTime[i],
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff63B865),
                Color(0xff86D188),
              ],
              stops: [0.0, 1.0],
            ),
            width: 20,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6), topRight: Radius.circular(6)),
          ),
        ],
      ));
    }

    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (startMonth >= 6)
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color(0xff63B865),
              ),
              onPressed: _previousRange,
            )
          else
            Spacer(),
          if (endMonth <= 5)
            IconButton(
              icon: Icon(
                Icons.arrow_forward,
                color: Color(0xff63B865),
              ),
              onPressed: _nextRange,
            )
          else
            Spacer(),
        ],
      ),
      SizedBox(height: 10),
      Flexible(
          child: BarChart(BarChartData(
        maxY: 80,
        minY: 0,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 5,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: const Color(0xffebebeb),
              strokeWidth: 1,
            );
          },
        ),
        borderData: FlBorderData(show: false),
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.white,
            maxContentWidth: 127,
            tooltipRoundedRadius: 10,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final value = widget.monthlyTime[group.x.toInt()];
              String tooltipMessage;
              if (value < 1) {
                int minutes = (value * 60).toInt();
                tooltipMessage = '$minutes분 읽었어요';
              } else {
                int hours = value.toInt();
                int minutes = ((value - hours) * 60).toInt();
                tooltipMessage = '$hours시간 $minutes분 읽었어요';
              }
              return BarTooltipItem(
                  tooltipMessage,
                  TextStyle(
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w800,
                      fontSize: 14));
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              return Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text('${value.toInt() + 1}월',
                      style: TextStyle(
                          color: Color(0xff333333),
                          fontWeight: FontWeight.w700,
                          fontSize: 14)));
            },
          )),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text('${value.toInt()}시간',
                    style: TextStyle(
                        color: Color(0xff666666),
                        fontWeight: FontWeight.w700,
                        fontSize: 10));
              },
              interval: 10.0,
              reservedSize: 40,
            ),
          ),
        ),
        barGroups: barGroups,
      ))),
    ]);
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/models/barData.dart';

class PageBarGraph extends StatefulWidget {
  final List monthlyPage;
  const PageBarGraph({super.key, required this.monthlyPage});

  @override
  State<PageBarGraph> createState() => _PageBarGraphState();
}

class _PageBarGraphState extends State<PageBarGraph> {
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
      janAmount: widget.monthlyPage[0],
      febAmount: widget.monthlyPage[1],
      marAmount: widget.monthlyPage[2],
      aprAmount: widget.monthlyPage[3],
      mayAmount: widget.monthlyPage[4],
      junAmount: widget.monthlyPage[5],
      julAmount: widget.monthlyPage[6],
      augAmount: widget.monthlyPage[7],
      sepAmount: widget.monthlyPage[8],
      octAmount: widget.monthlyPage[9],
      novAmount: widget.monthlyPage[10],
      decAmount: widget.monthlyPage[11],
    );

    timeBarData.initializeBarData();

    List<BarChartGroupData> barGroups = [];

    for (int i = startMonth; i <= endMonth; i++) {
      barGroups.add(BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: widget.monthlyPage[i],
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
            ),
        ],
      ),
      SizedBox(height: 10),
      Flexible(
          child: BarChart(BarChartData(
        maxY: 4000,
        minY: 0,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 250,
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
              final value = widget.monthlyPage[group.x.toInt()];

              return BarTooltipItem(
                  '${value.toInt()}p 읽었어요',
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
                return Text('${value.toInt()}p',
                    style: TextStyle(
                        color: Color(0xff666666),
                        fontWeight: FontWeight.w700,
                        fontSize: 10));
              },
              interval: 500.0,
              reservedSize: 40,
            ),
          ),
        ),
        barGroups: barGroups,
      ))),
    ]);
  }
}

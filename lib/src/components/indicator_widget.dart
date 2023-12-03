/*import 'package:flutter/material.dart';
import 'package:reafy_front/src/models/indicator_options.dart';

class IndicatorWidget extends StatefulWidget {
  final IndicatorOption indicatorOption;
  final PageController controller;
  const IndicatorWidget(
      {super.key, required this.indicatorOption, required this.controller});

  @override
  State<IndicatorWidget> createState() => _IndicatorWidgetState();
}

class _IndicatorWidgetState extends State<IndicatorWidget> {
  late Size indicatorBoxSize;
  double level = 0;

  @override
  void initState() {
    super.initState();
    _calcBoxSize();
    widget.controller.addListener(changePageEvent);
  }

  void changePageEvent() {
    setState(() {
      level = (widget.controller.page ?? 0.0);
    });
  }

  void _calcBoxSize() {
    var gap = widget.indicatorOption.gap;
    var size = widget.indicatorOption.size;
    var counts = widget.indicatorOption.counts;

    indicatorBoxSize =
        Size(size.width * counts + (gap * (counts - 1)), size.height);
    print(indicatorBoxSize);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: indicatorBoxSize.width,
          height: indicatorBoxSize.height,
          child: CustomPaint(
            painter: IndicatorBoxPainter(
              option: widget.indicatorOption,
              level: level,
            ),
          ),
        ),
      ),
    );
  }
}

class IndicatorBoxPainter extends CustomPainter {
  final IndicatorOption option;
  final double level;
  IndicatorBoxPainter({
    required this.option,
    required this.level,
  });

  void _blankIndicator(Canvas canvas) {
    Paint paint = Paint()..color = option.inActiveColor;
    final height = option.size.height;
    option.points.forEach((point) {
      final bounds = Rect.fromLTRB(
        point.x1,
        0,
        point.x2,
        height,
      );
      var rect = RRect.fromRectAndRadius(bounds, const Radius.circular(20));
      canvas.drawRRect(rect, paint);
    });
  }

  void _activeIndicatorAnimation(Canvas canvas) {
    Paint paint = Paint()..color = option.activeColor;
    var progress = level % 1 * 2;
    var frontProgress = progress.clamp(0, 1);
    var endProgress = (progress - 1).clamp(0, 1);
    var index = level.floor();
    var nextIndex = (index + 1).clamp(0, option.counts - 1);

    final xPos = option.points[index];
    final txPos = option.points[nextIndex];
    final nextPoint = frontProgress == 0 ? xPos.x2 : txPos.x2;

    var bounds = Rect.fromLTRB(
      xPos.x1 + (nextPoint - xPos.x2) * endProgress,
      0.0,
      xPos.x2 + (nextPoint - xPos.x2) * frontProgress,
      option.size.height,
    );
    var rect = RRect.fromRectAndRadius(bounds, const Radius.circular(20));
    canvas.drawRRect(rect, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    _blankIndicator(canvas);
    _activeIndicatorAnimation(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
*/
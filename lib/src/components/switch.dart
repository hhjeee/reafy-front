import 'package:flutter/material.dart';

class SwitchButton extends StatefulWidget {
  const SwitchButton({Key? key}) : super(key: key);

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation _circleAnimation;
  bool value = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 60),
      vsync: this,
    );
    _circleAnimation =
        AlignmentTween(begin: Alignment.centerLeft, end: Alignment.centerRight)
            .animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );

    if (value) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void didUpdateWidget(covariant SwitchButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (value) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, __) {
        return GestureDetector(
          onTap: () {
            if (value) {
              value = false;
              _animationController.reverse();
            } else {
              value = true;
              _animationController.forward();
            }
          },
          child: Container(
            width: 65.0,
            height: 40.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: _circleAnimation.value == Alignment.centerLeft
                  ? Colors.black
                  : Colors.greenAccent,
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _circleAnimation.value == Alignment.centerRight
                      ? const Padding(
                          padding: EdgeInsets.only(left: 22.0, right: 4.0),
                        )
                      : Container(),
                  Align(
                    child: Container(
                      width: 28.8,
                      height: 28.8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                            color: Colors.black.withOpacity(0.04), width: 0.6),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black.withOpacity(0.16),
                            offset: const Offset(0, 1),
                            blurRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  _circleAnimation.value == Alignment.centerLeft
                      ? const Padding(
                          padding: EdgeInsets.only(left: 4.0, right: 22.0),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

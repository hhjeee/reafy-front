import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:reafy_front/src/app.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/controller/intro_controller.dart';
import 'package:reafy_front/src/utils/constants.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      controlsPosition: const Position(left: 0, right: 0, bottom: 80),
      pages: [
        PageViewModel(
            title: '',
            bodyWidget: Column(
              children: [
                Text(
                  "나만의 책장을\n만들어봐요",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w800, height: 1.5),
                ),
                SizedBox(height: 40.0),
                Image.asset("assets/images/onboarding_1.png", height: 415),
              ],
            ),
            decoration: getPageDecoration()),
        PageViewModel(
            title: '',
            bodyWidget: Column(
              children: [
                Text(
                  "독서 타이머로\n책에 몰입해요",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w800, height: 1.5),
                ),
                SizedBox(height: 40.0),
                Image.asset("assets/images/onboarding_2.png", height: 415),
              ],
            ),
            decoration: getPageDecoration()),
        PageViewModel(
            title: '',
            bodyWidget: Column(
              children: [
                Text(
                  "나만의 서재를\n 꾸며봐요",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w800, height: 1.5),
                ),
                SizedBox(height: 40.0),
                Image.asset("assets/images/onboarding_3.png", height: 415),
              ],
            ),
            decoration: getPageDecoration()),
        PageViewModel(
            title: '',
            bodyWidget: Column(
              children: [
                Text(
                  "반가워요! \n당신의 독서생활에\nReafy가 함께할게요",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w800, height: 1.5),
                ),
                SizedBox(height: 20.0),
                Image.asset(
                  "assets/images/onboarding_4.png",
                  height: 415,
                ),
              ],
            ),
            decoration: getPageDecoration()),
      ],
      showBackButton: true,
      showDoneButton: true,
      showNextButton: true,
      //showSkipButton: true,

      done: ImageData(
        IconsPath.nextarrow,
        isSvg: true,
        width: 15,
      ),
      onDone: () {
        Get.off(() => App());
      },

      next: ImageData(
        IconsPath.nextarrow,
        isSvg: true,
      ),
      back: ImageData(IconsPath.backarrow, isSvg: true),
      dotsDecorator: DotsDecorator(
          color: Color(0xFFD9D9D9),
          activeColor: yellow,
          size: const Size(12, 12),
          activeSize: const Size(24, 12),
          activeShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
      curve: Curves.bounceOut,
    );
  }

  PageDecoration getPageDecoration() {
    return const PageDecoration(
        bodyTextStyle:
            TextStyle(fontSize: 30, fontWeight: FontWeight.w800, height: 1.5),
        pageColor: Color(0xffFAF9F7),
        bodyAlignment: Alignment.center);
  }
}

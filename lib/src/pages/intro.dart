import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:reafy_front/src/app.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/controller/bottom_nav_controller.dart';
import 'package:reafy_front/src/utils/constants.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Color(0xffFAF9F7),
      controlsPosition: const Position(left: 0, right: 0, bottom: 80),
      pages: [
        PageViewModel(
            title: '',
            bodyWidget: Column(
              children: [
                Text(
                  "내 취향대로\n책장을 채워요",
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
          bodyWidget: Stack(
            children: [
              Column(
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
            ],
          ),
          decoration: getPageDecoration(),
        ),
      ],
      showBackButton: true,
      showDoneButton: true,
      showNextButton: true,
      //showSkipButton: true,

      done: Container(
          child: Row(children: [
        Spacer(),
        ImageData(
          IconsPath.nextarrow,
          isSvg: true,
        )
      ])),
      onDone: () {
        Get.off(() => TutorialScreen()); //
      },

      next: Container(
          child: Row(children: [
        Spacer(),
        ImageData(
          IconsPath.nextarrow,
          isSvg: true,
        )
      ])),
      back: Container(
          child: Row(children: [
        ImageData(
          IconsPath.backarrow,
          isSvg: true,
        ),
        Spacer()
      ])),
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

// TutorialScreen 위젯 예시
class TutorialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("튜토리얼 작업 중!"),
            ElevatedButton(
              onPressed: () {
                final BottomNavController bottomNavController =
                    Get.find<BottomNavController>();
                bottomNavController.pageIndex.value = 1;
                Get.off(() => App());
              },
              child: Text("홈 화면으로"),
            ),
          ],
        ),
      ),
    );
  }
}

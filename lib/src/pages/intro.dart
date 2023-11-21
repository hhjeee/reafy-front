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
      pages: [
        PageViewModel(
            title: '나만의 책장을 \n만들어봐요',
            body: '',
            image: Image.asset("assets/images/onboarding_1.png"),
            decoration: getPageDecoration()),
        PageViewModel(
            title: '독서 시간을\n측정할 수 있어요',
            body: '',
            image: Image.asset("assets/images/onboarding_2.png"),
            decoration: getPageDecoration()),
        PageViewModel(
            title: '내 서재를\n마음대로 꾸며봐요',
            body: '',
            image: Image.asset("assets/images/onboarding_3.png"),
            decoration: getPageDecoration()),
        PageViewModel(
            title: '만나서 반가워요! \n지금부터 Reafy를 \n시작해볼까요?',
            body: '',
            image: Image.asset("assets/images/onboarding_4.png"),
            decoration: getPageDecoration())
      ],
      done: ImageData(
        IconsPath.nextarrow,
        isSvg: true,
        width: 15,
      ),
      onDone: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const App()),
        );
      },
      //showBackButton: true,
      showDoneButton: true,
      showNextButton: true,
      // showSkipButton: true,
      next: ImageData(
        IconsPath.nextarrow,
        isSvg: true,
        width: 15,
      ),
      //back: const Icon(Icons.arrow_back),
      dotsDecorator: DotsDecorator(
          color: Color(0xFFD9D9D9),
          activeColor: yellow,
          size: const Size(12, 12),
          activeSize: const Size(25, 15),
          activeShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
      curve: Curves.bounceOut,
    );
  }

  PageDecoration getPageDecoration() {
    return const PageDecoration(
        titleTextStyle:
            TextStyle(fontSize: 30, fontWeight: FontWeight.w800, height: 1.5),
        //imagePadding: EdgeInsets.only(top: 100),
        imageFlex: 3,
        bodyFlex: 1,
        pageColor: Color(0xffFAF9F7),
        //pageMargin: EdgeInsets.symmetric(vertical: .0),
        ///bodyAlignment: Alignment.topCenter,
        //imageAlignment: Alignment.bottomCenter,
        imagePadding: EdgeInsets.only(bottom: 30.0),
        contentMargin: const EdgeInsets.only(bottom: 20.0),
        safeArea: 70);
  }
}

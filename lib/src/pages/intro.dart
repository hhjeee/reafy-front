import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/app.dart';
import 'package:reafy_front/src/controller/intro_controller.dart';
import 'package:reafy_front/src/utils/constants.dart';

class IntroPage extends StatelessWidget {
  final IntroController introController = Get.put(IntroController());

  List<Map<String, String>> introData = [
    {"text": '나만의 책장을 \n만들어봐요', "image": "assets/images/intro.png"},
    {"text": '독서 시간을\n측정할 수 있어요', "image": "assets/images/intro.png"},
    {"text": '내 서재를\n마음대로 꾸며봐요', "image": "assets/images/intro.png"},
    {
      "text": '만나서 반가워요! \n지금부터 Reafy를 \n시작해볼까요?',
      "image": "assets/images/intro.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: PageView.builder(
                onPageChanged: (index) {
                  introController.changePage(index);
                  index++;
                },
                itemCount: 4,
                itemBuilder: (context, index) => IntroContent(
                  image: introData[introController.currentPage.value]["image"],
                  text: introData[introController.currentPage.value]['text'],
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            4,
                            (index) => AnimatedContainer(
                              duration: Duration(milliseconds: 100),
                              margin: EdgeInsets.only(right: 10),
                              height: 12,
                              width: introController.currentPage.value == index
                                  ? 27
                                  : 12,
                              decoration: BoxDecoration(
                                color:
                                    introController.currentPage.value == index
                                        ? primaryColor
                                        : Color(0xFFD9D9D9),
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    DefaultButton(
                      text: introController.currentPage.value == 3
                          ? "START!"
                          : "NEXT",
                      press: () {
                        if (introController.currentPage.value == 3) {
                          Get.off(() => App());
                        } else {
                          introController.nextPage();
                          //introController.currentPage.value++;
                          //introController
                          //    .changePage(introController.currentPage.value);
                        }
                      },
                    ),
                    Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58, //getProportionateScreenHeight(56),
      child: TextButton(
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          primary: Colors.white,
          backgroundColor: primaryColor,
        ),
        onPressed: press as void Function()?,
        child: Text(
          text!,
          style: TextStyle(
              fontSize: 18, //getProportionateScreenWidth(18),
              color: Colors.white,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class IntroContent extends StatelessWidget {
  const IntroContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(flex: 3),
        Text(
          text!,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              height: 1.3,
              fontFamily: 'NanumSquareRound',
              color: Colors.black,
              decoration: TextDecoration.none),
        ),
        Spacer(flex: 1),
        Image.asset(
          image!,
          height: getProportionateScreenHeight(265),
          width: getProportionateScreenWidth(235),
        ),
      ],
    );
  }
}

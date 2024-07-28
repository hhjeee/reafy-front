import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/components/dialog/stop_dialog.dart';
import 'package:reafy_front/src/components/stopwatch.dart';
import 'package:reafy_front/src/pages/home.dart';
import 'package:reafy_front/src/app.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/components/tool_tips.dart';
import 'package:reafy_front/src/provider/coin_provider.dart';
import 'package:reafy_front/src/provider/stopwatch_provider.dart';
import 'package:reafy_front/src/provider/time_provider.dart';
import 'package:reafy_front/src/repository/quest_repository.dart';
import 'package:reafy_front/src/repository/statics_repository.dart';
import 'package:reafy_front/src/utils/constants.dart';
import 'package:reafy_front/src/repository/coin_repository.dart';
import 'package:toastification/toastification.dart';

class BambooState {
  bool isVisible;
  //bool isActive;
  Offset position;
  BambooState(this.isVisible, this.position);
}

class BambooMap extends StatefulWidget {
  const BambooMap({super.key});
  @override
  State<BambooMap> createState() => _BambooMapState();
}

enum QuestStatus { defaultStatus, achievable, completed }

class _BambooMapState extends State<BambooMap>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late List<AnimationController> _bambooController;
  late List<Animation<double>> _bambooAnimation;
  //StopwatchProvider stopwatch;

  int? userCoin;

  List<BambooState> bambooStates =
      List.generate(6, (index) => BambooState(false, Offset(0, 0)));

  List<Offset> bambooPositions = [
    Offset(135, 192),
    Offset(68, 256),
    Offset(266, 269),
    Offset(292, 162),
    Offset(206, 126),
    Offset(15, 138),
  ];

  //final GlobalKey<CustomTooltipButtonState> _customTooltipKey =
  //    GlobalKey<CustomTooltipButtonState>();
  final GlobalKey<TooltipButtonState> _tooltipKey =
      GlobalKey<TooltipButtonState>();

  void _hideTooltip() {
    //_customTooltipKey.currentState?.hideOverlay();
    _tooltipKey.currentState?.hideOverlay();
  }

  bool showTopBar = false;

  @override
  void initState() {
    super.initState();
    //stopwatch = StopwatchProvider();
    //WidgetsBinding.instance.addObserver(stopwatch);

    _bambooController = List.generate(
        6,
        (index) => AnimationController(
              vsync: this,
              duration: Duration(milliseconds: 1600),
            )..repeat(reverse: true));

    _bambooAnimation = _bambooController
        .map((controller) => Tween<double>(begin: 0.95, end: 1.08).animate(
              CurvedAnimation(
                parent: controller,
                curve: Curves.easeInOut,
              ),
            ))
        .toList();
    loadUserCoin();
    Future.microtask(
        () => Provider.of<CoinProvider>(context, listen: false).updateCoins());
    Future.microtask(() {
      final timeProvider = Provider.of<TimeProvider>(context, listen: false);
      timeProvider.getTimes();
    });

    getQuestsStatus();
  }

  List<int> hours = [5, 10, 15, 20];
  Set<int> achievedQuests = Set<int>();
  Map<int, QuestStatus> questStatus = {};

  void getQuestsStatus() async {
    int totalTimes = await getWeeklyTimeStatistics();
    List<int> achievedQuestsIds = await getAchievedQuests();
    setState(() {
      achievedQuests = Set<int>.from(achievedQuestsIds);
      questStatus = {
        5: determineStatus(5, totalTimes, achievedQuests),
        10: determineStatus(10, totalTimes, achievedQuests),
        15: determineStatus(15, totalTimes, achievedQuests),
        20: determineStatus(20, totalTimes, achievedQuests),
      };
    });
  }

  QuestStatus determineStatus(
      int hours, int totalTimes, Set<int> achievedQuests) {
    int questId = hours ~/ 5; // 각 시간에 대한 퀘스트 id 매핑
    if (achievedQuests.contains(questId)) {
      return QuestStatus.completed;
    } else if (totalTimes >= hours * 3600) {
      return QuestStatus.achievable;
    } else {
      return QuestStatus.defaultStatus;
    }
  }

  @override
  void dispose() {
    for (var controller in _bambooController) {
      controller.dispose();
    }
    //WidgetsBinding.instance.removeObserver(stopwatch);
    //stopwatch.dispose();
    super.dispose();
  }

  Future<void> loadUserCoin() async {
    try {
      int? coin = await getUserCoin();
      setState(() {
        userCoin = coin ?? 0;
      });
    } catch (e) {
      print('에러 발생: $e');
    }
  }

  Widget bamboo_collect(BuildContext context) {
    //StopwatchProvider stopwatch = Provider.of<StopwatchProvider>(context);
    for (int i = 0; i < bambooStates.length; i++) {
      bambooStates[i] = BambooState(
          i < context.watch<StopwatchProvider>().itemCnt, bambooPositions[i]);
    } //stopwatch.itemCnt

    return Stack(
      children: List.generate(6, (index) {
        BambooState state = bambooStates[index];

        return AnimatedPositioned(
            duration: Duration(milliseconds: 1600),
            curve: Curves.elasticIn,
            left: state.position.dx,
            bottom: state.position.dy,
            child: AnimatedBuilder(
              animation: _bambooAnimation[index],
              builder: (context, child) {
                return Transform.scale(
                  scale: _bambooAnimation[index].value,
                  child: child,
                );
              },
              child: AnimatedScale(
                scale: state.isVisible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 2000),
                curve: Curves.elasticOut,
                child: GestureDetector(
                  onTap: () async {
                    try {
                      await updateCoin(1, true);
                      int currentCoin =
                          Provider.of<CoinProvider>(context, listen: false)
                              .coins;
                      Provider.of<CoinProvider>(context, listen: false)
                          .setCoins(currentCoin + 1);
                    } catch (e) {
                      print('에러 발생: $e');
                    }

                    await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return BambooDialog(userCoin: userCoin);
                        });

                    setState(() {
                      state.isVisible = false;
                    });

                    context.read<StopwatchProvider>().decreaseItemCount(); //
                  },
                  child: ImageData(IconsPath.bambooicon, width: 90, height: 90),
                ),
              ),
            ));
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Widget stopbutton() {
      return Center(
          child: GestureDetector(
              onTap: () {
                context.read<StopwatchProvider>().pause();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StopDialog();
                  },
                );
              },
              child: Container(
                  width: size.width * 0.87,
                  height: size.height * 0.06,
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: yellow,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 10.0,
                        color: Color.fromRGBO(0, 0, 0, 0.10),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "이제 그만 읽을래요!", //"독서 마치기"
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: black,
                      ),
                    ),
                  ))));
    }

    Widget TitleByStatus() {
      var status = 1;
      String content = "책을 읽는 동안\n15분마다 대나무 한 그루가 자라요.";

      return Consumer<StopwatchProvider>(builder: (context, stopwatch, child) {
        return Text(
          stopwatch.status == Status.running
              ? "책을 읽는 동안\n15분마다 대나무 한 그루가 자라요."
              : stopwatch.isFull
                  ? "대나무가 다 자랐어요!\n주워볼까요?"
                  : "잠시 쉬는중이에요 :)",
          textAlign: TextAlign.center,
          style: TextStyle(
              height: 1.5,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: white),
        );
      });
    }

    StopwatchProvider stopwatch = Provider.of<StopwatchProvider>(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: TitleByStatus(),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: white),
            onPressed: () {
              Get.to(() => App(), transition: Transition.leftToRight);
            },
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 16),
              child: IconButton(
                  iconSize: 44,
                  padding: EdgeInsets.only(right: 0),
                  icon: ImageData(IconsPath.bamboo_white, isSvg: true),
                  onPressed: () {
                    debugPrint("Pressed");
                    setState(() {
                      showTopBar = !showTopBar;
                    });
                  }),
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(IconsPath.bamboomap), fit: BoxFit.cover),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                  width: size.width,
                  height: 500,
                  child: bamboo_collect(context)),
            ),
            Visibility(
              visible: showTopBar,
              child: TopBarWidget(
                tooltipKey: _tooltipKey,
                questStatus: questStatus,
                context: context,
              ),
            ),
            Positioned(
              bottom: 51,
              left: 34,
              child: Column(
                children: [
                  if (stopwatch.status == Status.running ||
                      stopwatch.status == Status.paused)
                    stopbutton(),
                  const SizedBox(height: 15),
                  Center(child: StopwatchWidget()),
                ],
              ),
            ),
          ],
        ));
  }
}

class InfoWidget extends StatelessWidget {
  final String title;
  final String content;

  InfoWidget({required this.title, required this.content});

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
        width: 166,
        height: 62,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Color.fromRGBO(250, 249, 247, 0.6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, 0),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title, //"다음 대나무까지",
                style: TextStyle(
                  color: black,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 5),
              Text(
                content, //stopwatch.remainTimeString,
                style: TextStyle(
                  color: black,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                ),
              ),
            ]));
  }
}

class BambooDialog extends StatelessWidget {
  final int? userCoin;

  BambooDialog({Key? key, required this.userCoin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: 228,
          height: 223,
          padding: EdgeInsets.fromLTRB(17, 30, 17, 17),
          child: Column(children: [
            //SizedBox(height: 30.0),
            Text(
              "대나무를 성공적으로 주웠어요!",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 18.0),
            Text(
              "현재 대나무 수",
              //poobaoHome.selectedItemName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xff333333),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageData(
                  IconsPath.bamboo,
                  isSvg: true,
                  width: 44,
                ),
                Text(
                  Provider.of<CoinProvider>(context).coins.toString(),
                  style: TextStyle(
                    color: Color(0xff808080),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffffd747),
                minimumSize: Size(140, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: Text(
                '확인',
                style: const TextStyle(
                  color: Color(0xff333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ]),
        ));
  }
}

class TopBarWidget extends StatefulWidget {
  final GlobalKey<TooltipButtonState> tooltipKey;
  final Map<int, QuestStatus> questStatus;
  final BuildContext context;

  TopBarWidget({
    required this.tooltipKey,
    required this.questStatus,
    required this.context,
  });

  @override
  _TopBarWidgetState createState() => _TopBarWidgetState();
}

class _TopBarWidgetState extends State<TopBarWidget> {
  void _onQuestTap(int hours, QuestStatus status) async {
    if (status == QuestStatus.achievable) {
      int questId = hours ~/ 5;

      try {
        await postQuestAchieve(questId);
        toastification.show(
          context: context,
          type: ToastificationType.success,
          style: ToastificationStyle.fillColored,
          title: Text('퀘스트를 달성하여 대나무를 획득했어요!'),
          autoCloseDuration: const Duration(seconds: 3),
          showProgressBar: false,
        );

        //코인 업데이트
        int currentCoin =
            Provider.of<CoinProvider>(context, listen: false).coins;
        Provider.of<CoinProvider>(context, listen: false)
            .setCoins(currentCoin + hours);

        setState(() {
          widget.questStatus[hours] = QuestStatus.completed;
          // var newQuestStatus = Map<int, QuestStatus>.from(widget.questStatus);
          // newQuestStatus[hours] = QuestStatus.completed;
          // widget.questStatus = newQuestStatus;
        });
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 120,
        child: Container(
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<StopwatchProvider>(
                    builder: (context, stopwatch, child) {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InfoWidget(
                            title: "내가 가진 대나무",
                            content: Provider.of<CoinProvider>(context)
                                    .coins
                                    .toString() +
                                "개"),
                        SizedBox(width: 8),
                        InfoWidget(
                            title: "다음 대나무까지",
                            content: stopwatch.remainTimeString),
                      ]);
                }),
                SizedBox(height: 8),
                Container(
                  //width: size.width - 40,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Color.fromRGBO(250, 249, 247, 0.6),
                  ),
                  padding: EdgeInsets.fromLTRB(19, 6, 3, 6),
                  child: Row(
                    children: [
                      Text(
                        "주간 대나무",
                        style: TextStyle(
                            color: black,
                            fontSize: 12,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(width: 4),
                      TooltipButton(
                        key: widget.tooltipKey,
                      ),
                      ...widget.questStatus.entries.map((quest) {
                        int hours = quest.key;
                        QuestStatus status = quest.value;
                        return Expanded(
                            child: GestureDetector(
                                onTap: () => _onQuestTap(hours, status),
                                child: Container(
                                  margin: EdgeInsets.only(right: 8),
                                  alignment: Alignment.center,
                                  width: 50,
                                  height: 44,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(11),
                                      color: _getColorForStatus(status)),
                                  child: Text('${hours}시간\n(${hours}개)',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.1,
                                          color:
                                              _getTextColorForStatus(status))),
                                )));
                      })
                    ],
                  ),
                ),
              ],
            )));
  }

  Color _getColorForStatus(QuestStatus status) {
    switch (status) {
      case QuestStatus.completed:
        return Color(0xff808080);
      case QuestStatus.achievable:
        return Colors.green;
      default:
        return Colors.transparent;
    }
  }

  Color _getTextColorForStatus(QuestStatus status) {
    switch (status) {
      case QuestStatus.completed:
        return Color(0xff666666);
      case QuestStatus.achievable:
        return Colors.white;
      default:
        return Color(0xff333333).withOpacity(0.4);
    }
  }
}

/*
class BubbleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 221,
        left: 176,
        child: Stack(
          children: [
            ImageData(
              IconsPath.map_bubble,
              width: 112,
              height: 77,
              isSvg: true,
            ),
            Container(
              width: 112,
              height: 63,
              child: Consumer<StopwatchProvider>(
                builder: (context, stopwatch, child) {
                  return BambooBubbleRunningContent(stopwatch);
                },
              ),
            ),
          ],
        ));
  }
}*/
/*
class BambooBubbleContent extends StatelessWidget {
  final StopwatchProvider stopwatch;

  BambooBubbleContent(this.stopwatch);

  @override
  Widget build(BuildContext context) {
    return BambooBubbleRunningContent(stopwatch);
    /*

    if (stopwatch.itemCnt >= 6) {
      return Center(
        child: Text(
          "꼬르륵~",
          style: TextStyle(
            color: black,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    } else if (stopwatch.status == Status.running && !stopwatch.isFull) {
      return BambooBubbleRunningContent(stopwatch);
    } else {
      return Center(
        child: Text(
          "쉬고 있어요 :)",
          style: TextStyle(
            color: black,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }*/
  }
}*/

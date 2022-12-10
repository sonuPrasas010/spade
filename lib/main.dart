import 'dart:developer';
import 'dart:math' as math;

import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spade/animatedtext.dart';
import 'package:spade/files/enums.dart';
import 'package:spade/playable_card.dart';
import 'package:spade/templates/card.dart';

import 'templates/GetFlipCard.dart';
import 'controllers/animations/card_controllers.dart';
import 'templates/jack_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  bool isTapped = false;
  bool isShown = true;
  bool distributed = false;
  int turn = 1;
  late double height;
  late double width;
  Duration animationDuration = const Duration(milliseconds: 300);
  List<AnimationController> animationControllers = [];

  FlipCardController flipCardController = FlipCardController();
  CardController _cardController = Get.put(CardController());

  List<Animation<Offset>> animations = [];
  // DraggableScrollableController c = Draga

  @override
  void initState() {
    super.initState();
  }

  flipCard() {
    flipCardController.toggleCard();
  }

  // animationController.repeat(reverse: true);

  List<StatefulBuilder>? images;
  List<Function> setStates = [];
  // List<AnimationController> animationControllers = [];
  // List<Animation> animations = [];

  @override
  void didChangeDependencies() {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    log("$width");
    log("${width / 2}");
    log("$height");
    log("${height / 2}");
    log("${double.maxFinite}");
    log("${double.maxFinite / 2}");
    generateCard();
    super.didChangeDependencies();
  }

  void generateCard() {
    images = List.generate(
      12,
      (index) {
        print(index);
        return StatefulBuilder(builder: (context, fun) {
          if (index == 0 || index == 4 || index == 8) {
            var animationController =
                AnimationController(vsync: this, duration: animationDuration);

            var animation = Tween<Offset>(
              begin: Offset(0, 0),
              end: Offset(0, -2),
            ).animate(
              CurvedAnimation(
                  parent: animationController, curve: Curves.easeInCubic),
            );

            animationControllers.add(animationController);
            animations.add(animation);
            return PlayableCard(animation, animationController);
          } else if (index == 1 || index == 5 || index == 9) {
            var animationController =
                AnimationController(vsync: this, duration: animationDuration);

            var animation = Tween<Offset>(
              begin: Offset(0, 0),
              end: Offset(3.2, 1),
            ).animate(
              CurvedAnimation(
                  parent: animationController, curve: Curves.easeInCubic),
            );

            animationControllers.add(animationController);
            animations.add(animation);
            return PlayableCard(animation, animationController);
          } else if (index == 2 || index == 6 || index == 10) {
            var animationController =
                AnimationController(vsync: this, duration: animationDuration);

            var animation = Tween<Offset>(
              begin: Offset(0, 0),
              end: Offset(0, 2),
            ).animate(
              CurvedAnimation(
                  parent: animationController, curve: Curves.easeInCubic),
            );

            animationControllers.add(animationController);
            animations.add(animation);
            return PlayableCard(animation, animationController);
          }

          var animationController =
              AnimationController(vsync: this, duration: animationDuration);

          var animation = Tween<Offset>(
            begin: Offset(0, 0),
            end: Offset(-3.2, 1),
          ).animate(
            CurvedAnimation(
                parent: animationController, curve: Curves.easeInCubic),
          );

          animationControllers.add(animationController);
          animations.add(animation);

          return PlayableCard(animation, animationController);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.black45,
        elevation: 0,
        toolbarHeight: 80,
        title: AppBarContent(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ScoreBoard(),
              JackPlayer(
                isMyTurn: turn == 0,
              ),
              Container(
                width: 100,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.5),
                    width: 2,
                  ),
                ),
              ),
            ],
          ),

          Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                children: [
                  JackPlayer(
                    isMyTurn: turn == 1,
                  ),
                  Stack(
                    children: [
                      // for (var index = 0; index < images!.length; index++)
                      //   if (index == 1 || index == 5 || index == 9)
                      //     images![index]
                    ],
                  ),
                ],
              ),
              Center(
                child: Stack(children: [
                  for (int i = 0; i < images!.length; i++) images![i]
                ]),
              ),
              JackPlayer(
                isMyTurn: turn == 3,
              ),
            ],
          ),
          Spacer(),
          Stack(
            children: [
              // for (var index = 0; index < images!.length; index++)
              //   if (index == 2 || index == 6 || index == 10) images![index]
            ],
          ),

          Spacer(),

          // if (isShown)
          //   for (int index = 0; index <= images!.length - 1; index++)
          //     images![index],
          // Positioned(
          //   left: 0,
          //   right: 0,
          //   child: Container(
          //       color: Colors.red, child: Center(child: Text("hello"))),
          // ),
          // Positioned(
          //   right: width / 2,
          //   left: width / 2,
          //   child: Container(
          //       color: Colors.green,
          //       child: Center(
          //           child: SizedBox(
          //               width: 30,
          //               child: Text(
          //                 "hello",
          //               )))),
          // ),
        ],
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.topCenter,
        height: 130,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Color(0xff014F9E),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(50),
          ),
        ),
        child: Column(
          children: [
            // AnimatedText(animations[0], animationControllers[0]),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardDeck(
                  cardType: CardType.spade,
                  number: 1,
                ),
                CardDeck(
                  cardType: CardType.diamond,
                  number: 11,
                ),
                CardDeck(
                  cardType: CardType.club,
                  number: 12,
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _cardController.flipCard();
                    },
                    child: Text("Flip Cards"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      isShown = !isShown;
                      setState(() {});
                    },
                    child: Text(
                      "show hide distributed card",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // images!.clear();
                      // setStates.clear();
                      // print(images!.length);
                      // print(setStates.length);
                      // generateCard();

                      // print("regenerate card");
                      setState(() {
                        turn = math.Random().nextInt(4);
                        print(turn);
                      });
                    },
                    child: Text(
                      "Change Turn",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // images!.clear();
                      // setStates.clear();
                      // print(images!.length);
                      // print(setStates.length);
                      // generateCard();

                      // print("regenerate card");

                      for (var i = 0; i < images!.length; i++) {
                        if (animationControllers[i].isDismissed) {
                          await animationControllers[i].forward();
                          distributed = true;
                        } else {
                          distributed = false;
                          await animationControllers[i].reverse();
                        }
                        setState(() {});
                        await Future.delayed(Duration(milliseconds: 100));
                      }
                    },
                    child: Text(
                      "Pull and Distribute",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppBarContent extends StatelessWidget {
  const AppBarContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              "Mode",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            Text(
              "3 card",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            )
          ],
        ),
        Column(
          children: [
            Text(
              "Mode",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            Text(
              "3 card",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            )
          ],
        )
      ],
    );
  }
}

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white.withOpacity(0.5),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "You",
                style: TextStyle(
                  color: Colors.white.withOpacity(.7),
                  fontSize: 10,
                ),
              ),
              Spacer(),
              Text(
                "Opponent",
                style: TextStyle(
                  color: Colors.white.withOpacity(.7),
                  fontSize: 10,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Text(
                "You",
                style: TextStyle(
                  color: Colors.white.withOpacity(.7),
                  fontSize: 10,
                ),
              ),
              Spacer(),
              Text(
                "Opponent",
                style: TextStyle(
                  color: Colors.white.withOpacity(.7),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

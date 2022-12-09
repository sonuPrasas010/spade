import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spade/animatedtext.dart';
import 'package:spade/files/enums.dart';
import 'package:spade/templates/card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  bool hasAlreadyDistributed = false;
  int turn = 1;
  late double height;
  late double width;
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    this.animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    this.animation = Tween<double>(
      begin: 0.0,
      end: -200,
    ).animate(
      CurvedAnimation(
          parent: this.animationController, curve: Curves.easeInCubic),
    );
    this.animationController.forward();
    this.animationController.repeat(reverse: true);
    this.animationController.addListener(() {
      setState(() {});
      for (var element in setStates) {
        element(() {});
      }
    });
    super.initState();
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

  void distributeCard() async {
    for (var i = 0; i < images!.length; i++) {
      setStates[i](() {});
      await Future.delayed(Duration(milliseconds: 1000));
    }
  }

  void generateCard() {
    images = List.generate(
      12,
      (index) {
        print(index);
        return StatefulBuilder(builder: (context, fun) {
          // setStates.add(fun);
          // AnimationController animationController;
          // Animation<double> animation;

          // animationController =
          //     AnimationController(vsync: this, duration: Duration(seconds: 3));

          // animation = Tween<double>(
          //   begin: 0.0,
          //   end: -200,
          // ).animate(
          //   CurvedAnimation(
          //       parent: animationController, curve: Curves.easeInCubic),
          // );
          // animationController.forward();
          // animationController.repeat(reverse: true);
          // animationController.addListener(() {
          //   setState(() {});
          //   fun(() {});
          // });

          if (index == 0 || index == 4 || index == 8)
            return Transform.translate(
              offset: Offset(0, this.animation.value),
              child: SvgPicture.asset(
                "assets/image/card_back.svg",
                height: 40,
                width: 20,
              ),
            );
          else if (index == 1 || index == 5 || index == 9) {
            return Transform.translate(
              offset: Offset(0, 0),
              child: SvgPicture.asset(
                "assets/image/card_back.svg",
                height: 40,
                width: 20,
              ),
            );
          } else if (index == 2 || index == 6 || index == 10) {
            return Transform.translate(
              offset: Offset(0, 0),
              child: SvgPicture.asset(
                "assets/image/card_back.svg",
                height: 40,
                width: 20,
              ),
            );
          }

          return Transform.translate(
            offset: Offset(0, 0),
            child: SvgPicture.asset(
              "assets/image/card_back.svg",
              height: 40,
              width: 20,
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    ); // to hide only bottom bar

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.black45,
        elevation: 0,
        toolbarHeight: 80,
        title: AppBarContent(),
      ),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ScoreBoard(),
              Container(
                color: Colors.red,
                child: Column(
                  children: [
                    JackPlayer(
                      isMyTurn: turn == 0,
                    ),
                    Stack(
                      children: [
                        for (var index = 0; index < images!.length; index++)
                          if (index == 0 || index == 4 || index == 8)
                            images![index]
                      ],
                    ),
                  ],
                ),
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

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  JackPlayer(
                    isMyTurn: turn == 1,
                  ),
                  Stack(
                    children: [
                      Transform.translate(
                        offset: Offset(width / 2 - 50, -20),
                        child: SvgPicture.asset(
                          "assets/image/card_back.svg",
                          height: 40,
                          width: 20,
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, -0),
                        child: SvgPicture.asset(
                          "assets/image/card_back.svg",
                          height: 40,
                          width: 20,
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, 0),
                        child: SvgPicture.asset(
                          "assets/image/card_back.svg",
                          height: 40,
                          width: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  JackPlayer(
                    isMyTurn: turn == 3,
                  ),
                  Stack(
                    children: [
                      Transform.translate(
                        offset: Offset(width / 2 - 50, -20),
                        child: SvgPicture.asset(
                          "assets/image/card_back.svg",
                          height: 40,
                          width: 20,
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, -0),
                        child: SvgPicture.asset(
                          "assets/image/card_back.svg",
                          height: 40,
                          width: 20,
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, -0),
                        child: SvgPicture.asset(
                          "assets/image/card_back.svg",
                          height: 40,
                          width: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

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
            AnimatedText(this.animationController),
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
                      isTapped = true;
                      distributeCard();
                    },
                    child: Text("Distribute Card"),
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
                    onPressed: () {
                      // images!.clear();
                      // setStates.clear();
                      // print(images!.length);
                      // print(setStates.length);
                      // generateCard();

                      // print("regenerate card");
                      isTapped = false;
                      distributeCard();
                      print("pll and distribute");
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

class JackPlayer extends StatefulWidget {
  final bool isMyTurn;

  JackPlayer({required this.isMyTurn});
  @override
  State<JackPlayer> createState() => _JackPlayerState();
}

class _JackPlayerState extends State<JackPlayer> with TickerProviderStateMixin {
  late AnimationController animatedContainer;
  late Animation<double> animation;
  late AnimationController fadeInAnimationController;
  late Animation<double> fadeInAnimation;

  @override
  void initState() {
    animatedContainer =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animation =
        CurvedAnimation(parent: animatedContainer, curve: Curves.easeInOut);
    // animatedContainer.repeat(reverse: true, period: Duration(seconds: 3));

    fadeInAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    fadeInAnimation = Tween<double>(
      begin: 0.0,
      end: 1,
    ).animate(CurvedAnimation(
        parent: fadeInAnimationController, curve: Curves.easeInSine));

    // fadeInAnimationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant JackPlayer oldWidget) {
    changeTurn();
    super.didUpdateWidget(oldWidget);
  }

  void changeTurn() {
    if (widget.isMyTurn) {
      fadeInAnimationController.forward();
    } else {
      fadeInAnimationController.animateBack(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    changeTurn();
    return Column(
      children: [
        Column(
          children: [
            ScaleTransition(
                scale: animation,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Hello! I am sonu",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    maxLines: 1,
                  ),
                )),
            FadeTransition(
              opacity: fadeInAnimation,
              child: CupertinoActivityIndicator(
                color: Color.fromARGB(255, 170, 255, 0),
                radius: 10,
              ),
            ),
            Image.asset(
              "assets/image/images.png",
              height: 130,
              fit: BoxFit.contain,
            ),
          ],
        ),

        // Container(
        //   width: 100,
        //   // padding: EdgeInsets.all(3),
        //   decoration: BoxDecoration(
        //     color: Color(0xff1082CB),
        //     borderRadius: BorderRadius.circular(5),
        //     border: Border.all(
        //       color: Colors.white.withOpacity(0.7),
        //       width: 2,
        //     ),
        //   ),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.only(bottom: 8, top: 3),
        //         child: Text(
        //           "Sonu",
        //           style: TextStyle(
        //             color: Colors.white,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //       ),
        //       Divider(
        //         height: 0,
        //         color: Colors.white,
        //         thickness: 2,

        //         // height: 1,
        //       ),
        //       IntrinsicHeight(
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //           children: [
        //             Padding(
        //               padding: const EdgeInsets.symmetric(vertical: 4.0),
        //               child: Text(
        //                 "Pts. 0",
        //                 style: TextStyle(
        //                   color: Colors.white,
        //                   fontSize: 12,
        //                 ),
        //               ),
        //             ),
        //             VerticalDivider(
        //               thickness: 1,
        //               color: Colors.white,
        //               // height: 100,
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.symmetric(vertical: 4.0),
        //               child: Center(
        //                 child: Text(
        //                   "0/4",
        //                   style: TextStyle(
        //                     color: Colors.amber,
        //                     fontSize: 18,
        //                   ),
        //                   textAlign: TextAlign.center,
        //                 ),
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

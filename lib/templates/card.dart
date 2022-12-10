import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/simple/get_widget_cache.dart';
import 'package:playing_cards/playing_cards.dart';
import 'package:spade/files/enums.dart';

class CardDeck extends StatelessWidget {
  final CardType cardType;
  final int number;
  late final String image;
  final double width, height;
  final FlipCardController? controller;

  CardDeck({
    required this.cardType,
    required this.number,
    this.width = 45,
    this.height = 60,
    this.controller,
  }) {
    if (cardType == CardType.spade) image = "assets/image/spade.svg";
    if (cardType == CardType.club) image = "assets/image/club.svg";
    if (cardType == CardType.diamond) image = "assets/image/diamond.svg";
    if (cardType == CardType.heart) image = "assets/image/heart.svg";
  }
  @override
  Widget build(BuildContext context) {
    return FlipCard(
      controller: controller,
      // alignment: Alignment.bottomLeft,
      fill: Fill.fillFront,
      front: Padding(
        padding: const EdgeInsets.only(
          right: 5,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            5,
          ),
          child: SvgPicture.asset(
            "assets/image/card_back.svg",
            height: height,
            width: width,
            fit: BoxFit.cover,
          ),
        ),
      ),
      back: Container(
        margin: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        height: height,
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (number == 1)
              Text(
                "A",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color:
                      cardType == CardType.heart || cardType == CardType.diamond
                          ? Colors.red
                          : null,
                ),
                textAlign: TextAlign.start,
              )
            else if (number == 11)
              Text(
                "J",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color:
                      cardType == CardType.heart || cardType == CardType.diamond
                          ? Colors.red
                          : null,
                ),
                textAlign: TextAlign.start,
              )
            else if (number == 12)
              Text(
                "Q",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color:
                      cardType == CardType.heart || cardType == CardType.diamond
                          ? Colors.red
                          : null,
                ),
                textAlign: TextAlign.start,
              )
            else if (number == 13)
              Text(
                "K",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color:
                      cardType == CardType.heart || cardType == CardType.diamond
                          ? Colors.red
                          : null,
                ),
                textAlign: TextAlign.start,
              )
            else
              Text(
                number.toString(),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color:
                      cardType == CardType.heart || cardType == CardType.diamond
                          ? Colors.red
                          : null,
                ),
                textAlign: TextAlign.start,
              ),

            // SvgPicture.asset("assets/image/spade.svg"),
            SvgPicture.asset(
              image,
              height: 10,
            ),
            Center(
              child: SvgPicture.asset(
                image,
                height: 30,
                alignment: Alignment.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildBack({double height = 60, double width = 45}) {
  return Padding(
    padding: const EdgeInsets.only(
      right: 5,
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(
        5,
      ),
      child: SvgPicture.asset(
        "assets/image/card_back.svg",
        height: height,
        width: width,
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget buildFront({
  required CardType cardType,
  required int number,
  double width = 45,
  double height = 60,
}) {
  late String image;
  if (cardType == CardType.spade) image = "assets/image/spade.svg";
  if (cardType == CardType.club) image = "assets/image/club.svg";
  if (cardType == CardType.diamond) image = "assets/image/diamond.svg";
  if (cardType == CardType.heart) image = "assets/image/heart.svg";
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        border: Border.all(
          color: Colors.black45,
        )),
    height: height,
    width: width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (number == 1)
          Text(
            "A",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              color: cardType == CardType.heart || cardType == CardType.diamond
                  ? Colors.red
                  : null,
            ),
            textAlign: TextAlign.start,
          )
        else if (number == 11)
          Text(
            "J",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              color: cardType == CardType.heart || cardType == CardType.diamond
                  ? Colors.red
                  : null,
            ),
            textAlign: TextAlign.start,
          )
        else if (number == 12)
          Text(
            "Q",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              color: cardType == CardType.heart || cardType == CardType.diamond
                  ? Colors.red
                  : null,
            ),
            textAlign: TextAlign.start,
          )
        else if (number == 13)
          Text(
            "K",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              color: cardType == CardType.heart || cardType == CardType.diamond
                  ? Colors.red
                  : null,
            ),
            textAlign: TextAlign.start,
          )
        else
          Text(
            number.toString(),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              color: cardType == CardType.heart || cardType == CardType.diamond
                  ? Colors.red
                  : null,
            ),
            textAlign: TextAlign.start,
          ),

        // SvgPicture.asset("assets/image/spade.svg"),
        SvgPicture.asset(
          image,
          height: 10,
        ),
        Center(
          child: SvgPicture.asset(
            image,
            height: 30,
            alignment: Alignment.center,
          ),
        ),
      ],
    ),
  );
}

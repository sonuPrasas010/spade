import 'package:flutter/cupertino.dart';

class AnimatedText extends StatefulWidget {
  final AnimationController animationController;
  const AnimatedText(this.animationController, {super.key});

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
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
      print("hello");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
        offset: Offset(0, animationController.value), child: Text("Hello"));
  }
}

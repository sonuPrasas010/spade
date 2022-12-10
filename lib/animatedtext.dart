import 'package:flutter/cupertino.dart';

class AnimatedText extends StatefulWidget {
  final Animation<Offset> animation;
  final AnimationController animationController;
  const AnimatedText(this.animation, this.animationController, {super.key});

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    widget.animationController.forward();
    // widget.animationController.repeat(reverse: true);
    widget.animationController.addListener(() {
      setState(() {});
      print("hello");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: widget.animation,
      child: Text("Hello"),
    );
  }
}

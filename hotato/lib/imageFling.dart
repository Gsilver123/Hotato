import 'package:flutter/material.dart';

class ImageFling extends StatefulWidget {
  @override
  _ImageFlingState createState() => _ImageFlingState();
}

class _ImageFlingState extends State<ImageFling> with SingleTickerProviderStateMixin {

  AnimationController animationController;
  Alignment _dragAlignment = Alignment.center;

  @override
  void initState() {
    animationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    animationController.forward();
    animationController.repeat();
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onPanDown: (details) {},
      onPanUpdate: (details) {
        setState(() {
          _dragAlignment += Alignment(
            details.delta.dx / (size.width / 4),
            details.delta.dy / (size.height / 4),
          );
        });
      },
      onPanEnd: (details) {},
      child: Align(
        alignment: _dragAlignment,
        child: RotationTransition(
          turns: Tween(begin: 0.0, end: 1.0).animate(animationController),
          child: Image.asset('assets/images/potato_sleep_deprived.png'),
        )
      )
    );
  }
}
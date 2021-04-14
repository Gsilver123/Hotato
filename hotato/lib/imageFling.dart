import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class ImageFling extends StatefulWidget {
  final Function onComplete;
  ImageFling({this.onComplete});

  @override
  _ImageFlingState createState() => _ImageFlingState();
}

class _ImageFlingState extends State<ImageFling> with TickerProviderStateMixin {

  AnimationController animationController;
  AnimationController physicsController;
  Animation<Alignment> animation;

  Alignment _dragAlignment = Alignment.center;

  @override
  void initState() {
    animationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    physicsController = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    physicsController.addListener(() {
      setState(() {
        _dragAlignment = animation.value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    physicsController.dispose();
    super.dispose();
  }

  /// Calculates and runs a [SpringSimulation].
  void _runAnimation(Offset pixelsPerSecond, Size size) {
    animation = physicsController.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: Alignment.center,
      ),
    );
    physicsController.reset();
    physicsController.forward();
    // Calculate the velocity relative to the unit interval, [0,1],
    // used by the animation controller.
    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 30,
      stiffness: .5,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    physicsController.animateWith(simulation);
  }

  @override
  Widget build(BuildContext context) {

    animationController.forward();
    animationController.repeat();
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onPanDown: (details) {
        physicsController.stop();
      },
      onPanUpdate: (details) {
        setState(() {
          _dragAlignment += Alignment(
            details.delta.dx / (size.width / 8),
            details.delta.dy / (size.height / 8),
          );
        });
      },
      onPanEnd: (details) {
        _runAnimation(details.velocity.pixelsPerSecond, size);

        if (_dragAlignment.y < -.5) {
          print("Yayyyy");
          animationController.stop();
          physicsController.stop();
          widget.onComplete();
        } else {
          print(_dragAlignment.y);
          print(Alignment.topCenter.y);
        }
      },
      child: Align(
        alignment: _dragAlignment,
        child: RotationTransition(
          turns: Tween(begin: 0.0, end: 1.0).animate(animationController),
          child: Image.asset('assets/images/potato_sleep_deprived.png', height: size.height * .3,),
        )
      )
    );
  }
}
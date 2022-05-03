import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimationPage extends StatefulWidget {
  const AnimationPage({Key? key}) : super(key: key);

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  double angle = 0;

  @override
  void initState() {
    controller = AnimationController(duration: const Duration(seconds: 5), vsync: this);

    // add ease and bound effect
    final curvedAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.bounceIn,
      reverseCurve: Curves.easeOut
    );
    animation = Tween<double>(
      begin: 0,
      end: 2 * math.pi
    ).animate(curvedAnimation)
      ..addListener(() {
        setState(() {
          // to cause the rebuilding of the UI after tween is end
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Transform.rotate(
        angle: animation.value,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(30),
          child: Image.asset(
            'assets/images/resocoder.png'
          ),
        ),
      ),
    );
  }
}

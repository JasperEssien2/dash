import 'package:dash/dash_bird.dart';
import 'package:flutter/material.dart';

const designSize = Size(350, 200);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation animation;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 7500));

    animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn)
          ..addListener(() {
            setState(() {});
          });

    _animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dash',
      theme: ThemeData.light(),
      home: Center(
        child: AspectRatio(
          aspectRatio: 3,
          child: Align(
            alignment: Alignment.center,
            child: AspectRatio(
              aspectRatio: 1.95,
              child: CustomPaint(
                painter: DashBirdPainter(
                  animationValue: animation.value,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

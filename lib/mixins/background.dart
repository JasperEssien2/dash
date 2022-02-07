import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:dash/util.dart';

import '../colors.dart';

mixin BackgroundMixin {
  late double _height;
  late double _width;
  bool heartPointsInitialised = false;
  List<Offset> points = [];
  final random = math.Random();

  void initSize(Size size) {
    _height = size.height;
    _width = size.width;
  }

  void drawLove(Canvas canvas, Offset center, double t) {
    if (true) {
      final controlPoints = [
        center,
        center.translate(5.w(_width), -10.h(_height)),
        center.translate(20.w(_width), -15.h(_height)),
        center.translate(30.w(_width), -10.h(_height)),
        center.translate(35.w(_width), 0),
        center.translate(0, 40.h(_height)),
        center.translate(-35.w(_width), 0),
        center.translate(-30.w(_width), -10.h(_height)),
        center.translate(-20.w(_width), -15.h(_height)),
        center.translate(-5.w(_width), -10.h(_height)),
        center,
      ];

      points = CatmullRomSpline(controlPoints)
          .generateSamples()
          .map((e) =>
              Offset.lerp(_generateOffset, e.value, math.min(t, 0.9995))!)
          .toList();
      heartPointsInitialised = true;
    }
    var color = Color.lerp(const Color(0xffC0C0C0), dashBlue, t)!;

    canvas.drawPoints(
      PointMode.points,
      points,
      Paint()
        ..color = color
        ..strokeWidth = 3.w(_width),
    );
  }

  Offset get _generateOffset => Offset(
        _generate(_width * 2, -_width * 2),
        _generate(-_height * 2, _height * 2),
      );

  double _generate(double min, double max) {
    double range = max - min;
    double scaled = random.nextDouble() * range;
    return scaled + min;
  }
}

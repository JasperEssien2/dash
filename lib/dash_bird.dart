import 'package:dash/colors.dart';
import 'package:dash/mixins/vikings_entities.dart';
import 'package:flutter/material.dart';

import 'mixins/background.dart';
import 'util.dart';

class DashBirdPainter extends CustomPainter
    with VikingsEntitiesMixin, BackgroundMixin {
  late double width;
  late double height;

  DashBirdPainter({this.animationValue = 0});

  final double animationValue;

  Paint get filledDashPaint => Paint()
    ..color = dashBlue
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPaint(Paint()..color = const Color(0xff273240).withOpacity(.8));
    initSize(size);

    width = size.width;
    height = size.height;

    canvas.translate(size.width / 1.5, size.height / 2);

    drawLove(
        canvas, Offset((-size.width / 1.4), size.height / 2), animationValue);

    drawLove(canvas, Offset(size.width / 2 * 0.8, -size.height / 1.5),
        animationValue);

    _drawMaleDash(canvas, size);

    _drawFemaleDash(canvas, size);
  }

  void _drawMaleDash(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(-size.width * 0.35, 0);

    _drawDash(canvas, isFemaleDash: false);
    canvas.restore();
  }

  void _drawFemaleDash(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(size.width * 0.1, 0);

    _drawDash(canvas);
    canvas.restore();
  }

  void _drawDash(Canvas canvas, {bool isFemaleDash = true}) {
    final eyesDistance = 30.w(width);

    _drawLeg(canvas, eyesDistance);

    _drawLeg(canvas, eyesDistance, position: -1);

    if (!isFemaleDash) {
      _drawLeftFeather(canvas, eyesDistance);
    }

    _drawDashBody(canvas);

    _drawEye(canvas, eyesDistance);

    _drawEye(canvas, eyesDistance, position: -1);

    _drawNose(canvas);

    _drawRightFeather(canvas, eyesDistance);

    if (isFemaleDash) {
      drawVikingsTrumpet(
        canvas,
        Offset(eyesDistance + 45.w(width), 55.h(height)),
      );

      drawVikingsFemaleHat(canvas);
    } else {
      drawVikingsTrumpet(
        canvas,
        Offset(-eyesDistance - 50.w(width), 55.h(height)),
        position: -1,
        isFemaleDash: isFemaleDash,
      );

      drawVikingsMaleHat(canvas);
    }
  }

  /// [position] an integer that can only be -1 or 1, it determines if the
  /// entity drawn should be positioned on the down right (positive) or
  /// down left (negative)
  void _drawLeg(Canvas canvas, double eyesDistance, {int position = 1}) {
    assert(position.abs() == 1);

    final path = Path()
      ..moveTo(eyesDistance * position, 85.h(height))
      ..lineTo(eyesDistance * position, 105.h(height))
      ..cubicTo(
        (eyesDistance * position) + 30.w(width),
        115.h(height),
        (eyesDistance * position) + 10.w(width),
        115.h(height),
        (eyesDistance * position),
        110.h(height),
      )
      ..cubicTo(
        (eyesDistance * position) + 4.w(width),
        130.h(height),
        (eyesDistance * position) - 2.w(width),
        130.h(height),
        (eyesDistance * position) - 5.w(width),
        110.h(height),
      )
      ..cubicTo(
        (eyesDistance * position) - 23.w(width),
        115.h(height),
        (eyesDistance * position) - 23.w(width),
        110.h(height),
        (eyesDistance * position) - 3.w(width),
        105.h(height),
      )
      ..lineTo((eyesDistance * position) - 4.w(width), 85.h(height));

    canvas.drawPath(
      path,
      Paint()..color = legColor,
    );
  }

  void _drawDashBody(Canvas canvas) {
    final path = Path()
      ..moveTo(10.w(width), -70.h(height))
      ..conicTo(-0, -75.h(height), -10.w(width), -70.h(height), 1)
      ..conicTo(-120.w(width), 10.h(height), -40.w(width), 80.h(height), 1)
      ..moveTo(10.w(width), -70.h(height))
      ..conicTo(120.w(width), 10.h(height), 40.w(width), 80.h(height), 1)
      ..conicTo(0, 120.h(height), -40.w(width), 80.h(height), 0.5);

    canvas.drawShadow(path, Colors.lightBlue, 12.w(width), true);

    canvas.drawPath(
      path,
      Paint()
        ..color = dashLightBlue
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.fill,
    );

    canvas.drawPath(
      Path()
        ..moveTo(50.w(width), 70.h(height))
        ..conicTo(60.w(width), 60.h(height), 50.w(width), 40.h(height), 0.4)
        ..conicTo(0, 80.h(height), -50.w(width), 40.h(height), 0.6)
        ..conicTo(-60.w(width), 60.h(height), -50.w(width), 70.h(height), 0.4)
        ..moveTo(50.w(width), 70.h(height))
        ..conicTo(0, 120.h(height), -50.w(width), 70.h(height), 1),
      Paint()
        ..color = Colors.white
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.fill,
    );
  }

  /// [position] an integer that can only be -1 or 1, it determines if the
  /// entity drawn should be positioned on the down right (positive) or
  /// down left (negative)
  void _drawEye(Canvas canvas, double eyesDistance, {int position = 1}) {
    assert(position.abs() == 1);

    canvas.drawCircle(
      Offset(eyesDistance * position, 0),
      30.w(width),
      Paint()..color = dashBlue,
    );

    canvas.drawOval(
      Rect.fromPoints(
        Offset((eyesDistance * position) - 13.w(width), -14.h(height)),
        Offset((eyesDistance * position) + 13.w(width), 14.h(height)),
      ),
      Paint()
        ..color = Colors.lightGreenAccent[400]!
        ..style = PaintingStyle.fill,
    );

    canvas.drawOval(
      Rect.fromPoints(
        Offset((eyesDistance * position) - 12.w(width), -13.h(height)),
        Offset((eyesDistance * position) + 12.w(width), 13.h(height)),
      ),
      Paint()
        ..color = Colors.black
        ..style = PaintingStyle.fill,
    );

    canvas.drawCircle(
      Offset((eyesDistance * position) + 2.5.w(width) * position, 0),
      3.w(width),
      Paint()..color = Colors.white,
    );

    canvas.drawCircle(
      Offset(
          (eyesDistance * position) - 0.6.w(width) * position, -5.5.h(height)),
      1.6.w(width),
      Paint()..color = Colors.white,
    );
  }

  void _drawNose(Canvas canvas) {
    canvas.drawPath(
      Path()
        ..moveTo(-10.w(width), 15.h(height))
        ..arcToPoint(
          Offset(10.w(width), 15.h(height)),
          radius: Radius.elliptical(
            5.w(width),
            5.h(height),
          ),
        )
        ..lineTo(0, 70.h(height))
        ..lineTo(-10.w(width), 15.h(height)),
      Paint()
        ..color = noseColor
        ..style = PaintingStyle.fill,
    );
  }

  void _drawRightFeather(Canvas canvas, double eyesDistance) {
    final path = Path()
      ..moveTo(
        eyesDistance + 33.w(width),
        15.h(height),
      )
      ..conicTo(
        eyesDistance + 10.w(width),
        40.h(height),
        eyesDistance + 33.w(width),
        65.h(height),
        0.3,
      )
      ..conicTo(
        eyesDistance + 35.w(width),
        85.h(height),
        eyesDistance + 50.w(width),
        75.h(height),
        0.5,
      )
      ..conicTo(
        eyesDistance + 65.w(width),
        90.h(height),
        eyesDistance + 60.w(width),
        65.h(height),
        0.9,
      )
      ..conicTo(
        eyesDistance + 75.w(width),
        80.h(height),
        eyesDistance + 70.w(width),
        60.h(height),
        0.6,
      )
      ..lineTo(eyesDistance + 35.w(width), 15.h(height));

    canvas.drawShadow(path, Colors.lightBlue, 2.w(width), true);

    canvas.drawPath(
      path,
      filledDashPaint,
    );
  }

  void _drawLeftFeather(Canvas canvas, double eyesDistance) {
    final path = Path()
      ..moveTo(
        -eyesDistance - 33.w(width),
        10.h(height),
      )
      ..lineTo(-eyesDistance - 50.w(width), -20.h(height))
      ..cubicTo(
        -eyesDistance - 50.w(width),
        -55.h(height),
        -eyesDistance - 90.w(width),
        -35.h(height),
        -eyesDistance - 60.w(width),
        -15.h(height),
      )
      ..cubicTo(
        -eyesDistance - 95.w(width),
        -35.h(height),
        -eyesDistance - 80.w(width),
        5.h(height),
        -eyesDistance - 70.w(width),
        -5.h(height),
      )
      ..cubicTo(
        -eyesDistance - 90.w(width),
        -5,
        -eyesDistance - 100.w(width),
        10,
        -eyesDistance - 90.w(width),
        15,
      )
      ..conicTo(
        -eyesDistance - 100.w(width),
        50.h(height),
        -eyesDistance - 23.w(width),
        60.h(height),
        0.6,
      );

    canvas.drawShadow(path, Colors.lightBlue, 5.w(width), true);

    canvas.drawPath(path, filledDashPaint);
  }

  @override
  bool shouldRepaint(DashBirdPainter oldDelegate) => true;
}

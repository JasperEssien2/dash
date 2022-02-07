import 'dart:math' as math;
import 'dart:ui';

import 'package:dash/util.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

mixin VikingsEntitiesMixin {
  late double _height;
  late double _width;

  void initSize(Size size) {
    _height = size.height;
    _width = size.width;
  }

  /// [position] an integer that can only be -1 or 1, it determines if the
  /// entity drawn should be positioned on the down right (positive) or
  /// down left (negative)
  void drawVikingsTrumpet(Canvas canvas, Offset center,
      {int position = 1, bool isFemaleDash = true}) {
    assert(position.abs() == 1);
    final trumpetColor = position.isNegative ? dashDarkBlueColor : dashBlue2;

    final startX = center.dx;
    final startY = center.dy;

    canvas.save();
    if (!isFemaleDash) {
      canvas.translate(0, -40.h(_height));
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(
            startX + 15.w(_width) * position,
            startY - 2.5.h(_height),
          ),
          width: 20.w(_width),
          height: 25.h(_height),
        ),
        Paint()..color = dashLightBlue,
      );
    }

    var path = Path()
      ..moveTo(startX, startY)
      ..conicTo(
        startX + 70.w(_width) * position,
        30.h(_height),
        startX + 80.w(_width) * position,
        -60.h(_height),
        0.8,
      )
      ..conicTo(
        startX + 95.w(_width) * position,
        startY - 80.h(_height),
        startX + 90.w(_width) * position,
        startY - 50.h(_height),
        0.9,
      )
      ..conicTo(
        startX + 75.w(_width) * position,
        startY + 10.h(_height),
        startX + 5.w(_width * position),
        startY,
        0.5,
      );

    canvas.drawShadow(path, Colors.blue, 7.w(_width), true);

    canvas.drawPath(
      path,
      Paint()
        ..color = trumpetColor
        ..strokeWidth = 5
        ..style = PaintingStyle.fill,
    );

    var path2 = Path()
      ..moveTo(
        startX + 80.w(_width) * position,
        -65.h(_height),
      )
      ..conicTo(
        startX + 100.w(_width) * position,
        startY - 85.h(_height),
        startX + 91.w(_width) * position,
        startY - 40.h(_height),
        0.9,
      )
      ..conicTo(
        startX + 109.w(_width) * position,
        -20.h(_height),
        startX + 84.w(_width) * position,
        -65.h(_height),
        0.7,
      );

    canvas.drawShadow(path2, Colors.blue, 7.w(_width), true);

    canvas.drawPath(path2, Paint()..color = trumpetColor);

    if (isFemaleDash) {
      _drawFemaleTrumpetStrap(canvas, startX, position, startY);
    } else {
      _drawMaleTrumpetStrap(canvas, startX, position, startY);
    }
    canvas.restore();
  }

  void _drawFemaleTrumpetStrap(
      Canvas canvas, double startX, int position, double startY) {
    final paint = Paint()
      ..color = dashDarkBlueColor
      ..strokeWidth = 1.4.w(_width)
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromCenter(
        center:
            Offset(startX + 10.w(_width) * position, startY - 2.5.h(_height)),
        width: 5.w(_width),
        height: 10.h(_height),
      ),
      math.pi / 2.5,
      -math.pi / 1.2,
      false,
      paint,
    );

    canvas.drawArc(
      Rect.fromCenter(
        center:
            Offset(startX + 7.w(_width) * position, startY - 2.5.h(_height)),
        width: 5.w(_width),
        height: 10.h(_height),
      ),
      math.pi / 2.5,
      -math.pi / 1.2,
      false,
      paint,
    );
  }

  void _drawMaleTrumpetStrap(
      Canvas canvas, double startX, int position, double startY) {
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(
          startX + 18.w(_width) * position,
          startY - 5.h(_height),
        ),
        width: 10.w(_width),
        height: 15.h(_height),
      ),
      math.pi / 2,
      -math.pi / 1.2,
      false,
      Paint()
        ..color = dashLightBlue
        ..strokeWidth = 4.4.w(_width)
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke,
    );
  }

  void drawVikingsFemaleHat(Canvas canvas) {
    _drawFemaleHairBraid(canvas);

    _drawFemaleHairBraid(canvas, position: -1);

    final liningPaint = Paint()
      ..color = vikingHatLiningColor
      ..style = PaintingStyle.fill;

    final hatPaint = Paint()
      ..color = Colors.brown[200]!
      ..style = PaintingStyle.fill;

    var outerPath = Path()
      ..moveTo(-70.w(_width), -30.h(_height))
      ..cubicTo(
        -70.w(_width),
        -100.h(_height),
        70.w(_width),
        -100.h(_height),
        70.w(_width),
        -30.h(_height),
      );

    canvas.drawShadow(outerPath, noseColor, 10.w(_width), false);

    canvas.drawPath(outerPath, liningPaint);

    canvas.drawPath(
        Path()
          ..moveTo(-60.w(_width), -30.h(_height))
          ..cubicTo(
            -60.w(_width),
            -90.h(_height),
            60.w(_width),
            -90.h(_height),
            60.w(_width),
            -30.h(_height),
          ),
        hatPaint);

    canvas.drawPath(
      Path()
        ..moveTo(0, -80.h(_height))
        ..conicTo(-10.w(_width), -50.h(_height), 0, -29.h(_height), 0.3),
      liningPaint
        ..strokeWidth = 10.w(_width)
        ..style = PaintingStyle.stroke,
    );

    var hatBottomPath = Path()
      ..moveTo(-70.w(_width), -35.h(_height))
      ..conicTo(0, 0, 70.w(_width), -35.h(_height), 0.5);

    canvas.drawShadow(hatBottomPath, noseColor, 10.w(_width), false);

    canvas.drawPath(
      hatBottomPath,
      liningPaint
        ..strokeWidth = 13.w(_width)
        ..style = PaintingStyle.stroke,
    );

    _drawFemaleHorn(canvas);

    _drawFemaleHorn(canvas, position: -1);
  }

  /// [position] an integer that can only be -1 or 1, it determines if the
  /// entity drawn should be positioned on the down right (positive) or
  /// down left (negative)
  void _drawFemaleHorn(Canvas canvas, {double position = 1}) {
    assert(position.abs() == 1);

    final hornPaint = Paint()
      ..color = creamColor
      ..strokeWidth = 5.w(_width)
      ..style = PaintingStyle.fill;

    var hornPath = Path()
      ..moveTo(40.w(_width) * position, -65.h(_height))
      ..conicTo(
        80.w(_width) * position,
        -55.h(_height),
        75.w(_width) * position,
        -85.h(_height),
        0.1,
      )
      ..conicTo(
        80.w(_width) * position,
        -70.h(_height),
        50.w(_width) * position,
        -50.h(_height),
        0.9,
      )
      ..conicTo(
        10.w(_width) * position,
        -30.h(_height),
        35.w(_width) * position,
        -65.h(_height),
        0.1,
      );

    canvas.drawShadow(hornPath, noseColor, 4.w(_width), true);

    canvas.drawPath(hornPath, hornPaint);

    canvas.drawPath(
      Path()
        ..moveTo(50.w(_width) * position, -50.h(_height))
        ..conicTo(
          5.w(_width) * position,
          -30.h(_height),
          35.w(_width) * position,
          -65.h(_height),
          0.1,
        ),
      Paint()
        ..color = vikingHatLiningColor
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 3.w(_width),
    );
  }

  /// [position] an integer that can only be -1 or 1, it determines if the
  /// entity drawn should be positioned on the down right (positive) or
  /// down left (negative)
  void _drawFemaleHairBraid(Canvas canvas, {double position = 1}) {
    assert(position.abs() == 1);

    canvas.save();
    final paint = Paint()..color = braidLightColor;

    canvas.rotate(-0.4 * position);
    canvas.translate(
        (position.isNegative ? 10.w(_width) : 5.w(_width)) * position,
        15.h(_height));

    double moveX = 60.w(_width) * position, moveY = -30.h(_height);
    double firstConicX1 = 75.w(_width) * position,
        firstConicY1 = -20.h(_height),
        firstConicX2 = 60.w(_width) * position,
        firstConicY2 = -10.h(_height);
    double secondConicX1 = 45.w(_width) * position,
        secondConicY1 = -20.h(_height),
        secondConicX2 = 60.w(_width) * position,
        secondConicY2 = -30.h(_height);

    canvas.drawPath(
      Path()
        ..moveTo(moveX, moveY)
        ..conicTo(firstConicX1, firstConicY1, firstConicX2, firstConicY2, 0.5)
        ..conicTo(
            secondConicX1, secondConicY1, secondConicX2, secondConicY2, 0.5),
      paint,
    );
    final ySpacing = 9.h(_height);
    final xMoveSpacing = 8.w(_width);
    final xConicSpace = 5.w(_width);

    for (int i = 0; i <= 7; i++) {
      moveY = moveY + ySpacing;
      firstConicY1 = firstConicY1 + ySpacing;
      firstConicY2 = firstConicY2 + ySpacing;
      secondConicY1 = secondConicY1 + ySpacing;
      secondConicY2 = secondConicY2 + ySpacing;

      if (i % 2 == 0) {
        moveX = moveX + xMoveSpacing;
        firstConicX1 = firstConicX1 + xConicSpace;
        firstConicX2 = firstConicX2 + xConicSpace;
        secondConicX1 = secondConicX1 + xConicSpace;
        secondConicX2 = secondConicX2 + xConicSpace;
        paint.color = braidDarkColor;
      } else {
        moveX = moveX - xMoveSpacing;
        firstConicX1 = firstConicX1 - xConicSpace;
        firstConicX2 = firstConicX2 - xConicSpace;
        secondConicX1 = secondConicX1 - xConicSpace;
        secondConicX2 = secondConicX2 - xConicSpace;
        paint.color = braidLightColor;
      }

      if (i % 4 == 0) {
        paint.color = const Color(0xffE66E0C);
      }
      canvas.drawPath(
        Path()
          ..moveTo(moveX, moveY)
          ..conicTo(firstConicX1, firstConicY1, firstConicX2, firstConicY2, 0.5)
          ..conicTo(
              secondConicX1, secondConicY1, secondConicX2, secondConicY2, 0.5),
        paint,
      );
    }
    canvas.restore();
  }

  void drawVikingsMaleHat(Canvas canvas) {
    final paint = Paint()
      ..color = darkGreyColor
      ..strokeWidth = 5.w(_width)
      ..style = PaintingStyle.fill;

    final liningPaint = Paint()
      ..color = vikingHatLiningColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.w(_width);

    var outerPath = Path()
      ..moveTo(-60.w(_width), -30.h(_height))
      ..conicTo(
        0.w(_width),
        -160.h(_height),
        60.w(_width),
        -30.h(_height),
        0.6,
      );

    canvas.drawShadow(outerPath, noseColor, 10.w(_width), false);

    canvas.drawPath(outerPath, paint);

    _drawMaleVikingHatHorn(canvas, liningPaint);

    _drawMaleVikingHatHorn(canvas, liningPaint, position: -1);

    canvas.drawPath(
      Path()
        ..moveTo(65.w(_width), -25.h(_height))
        ..conicTo(
          0.w(_width),
          -60.h(_height),
          -65.w(_width),
          -25.h(_height),
          0.6,
        ),
      liningPaint..strokeWidth = 10.w(_width),
    );

    canvas.drawPath(
      Path()
        ..moveTo(63.w(_width), -20.h(_height))
        ..conicTo(
          0.w(_width),
          -50.h(_height),
          -63.w(_width),
          -20.h(_height),
          0.6,
        ),
      paint
        ..strokeWidth = 15.w(_width)
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke,
    );

    canvas.drawPath(
      Path()
        ..moveTo(-14.w(_width), -75.h(_height))
        ..cubicTo(
          -14.w(_width),
          -90.h(_height),
          14.w(_width),
          -90.h(_height),
          14.w(_width),
          -75.h(_height),
        )
        ..conicTo(
          7.w(_width),
          -40.h(_height),
          18.w(_width),
          10.h(_height),
          0.4,
        )
        ..conicTo(
          0,
          25.h(_height),
          -18.w(_width),
          10.h(_height),
          0.9,
        )
        ..conicTo(
          -7.w(_width),
          10.h(_height),
          -14.w(_width),
          -75.h(_height),
          0.4,
        ),
      paint..style = PaintingStyle.fill,
    );
  }

  /// [position] an integer that can only be -1 or 1, it determines if the
  /// entity drawn should be positioned on the down right (positive) or
  /// down left (negative)
  void _drawMaleVikingHatHorn(Canvas canvas, Paint liningPaint,
      {double position = 1}) {
    assert(position.abs() == 1);

    final paint = Paint()
      ..color = darkGreyColor
      ..strokeWidth = 5.w(_width)
      ..style = PaintingStyle.fill;

    canvas.drawLine(
      Offset(15.w(_width) * position, -75.h(_height)),
      Offset(15.w(_width) * position, -30.h(_height)),
      liningPaint..strokeWidth = 5.w(_width),
    );

    canvas.drawPath(
      Path()
        ..moveTo(35.w(_width) * position, -65.h(_height))
        ..conicTo(
          60.w(_width) * position,
          -60.h(_height),
          55.w(_width) * position,
          -40.h(_height),
          0.1,
        ),
      liningPaint..strokeWidth = 3.w(_width),
    );

    canvas.drawPath(
      Path()
        ..moveTo(38.w(_width) * position, -65.h(_height))
        ..cubicTo(
          40.w(_width) * position,
          -80.h(_height),
          80.w(_width) * position,
          -48.h(_height),
          58.w(_width) * position,
          -40.h(_height),
        ),
      paint
        ..strokeWidth = 5.w(_width)
        ..style = PaintingStyle.fill,
    );

    var hornPath = Path()
      ..moveTo(46.w(_width) * position, -69.h(_height))
      ..conicTo(
        70.w(_width) * position,
        -80.h(_height),
        50.w(_width) * position,
        -110.h(_height),
        1,
      )
      ..conicTo(
        90.w(_width) * position,
        -80.h(_height),
        65.w(_width) * position,
        -50.h(_height),
        1,
      );

    canvas.drawShadow(hornPath, noseColor, 4.w(_width), true);

    canvas.drawPath(
      hornPath,
      Paint()
        ..shader = const LinearGradient(
            colors: [noseColor, cartonCreamColor],
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            stops: [0.4, 1]).createShader(
          Rect.fromPoints(
            Offset(46.w(_width) * position, -69.h(_height)),
            Offset(
              65.w(_width) * position,
              -110.h(_height),
            ),
          ),
        ),
    );
  }
}

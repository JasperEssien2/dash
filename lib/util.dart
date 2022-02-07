import 'package:flutter/material.dart';

const designSize = Size(350, 200);

extension SizeHelper on num {
  w(double width) => (width * this) / designSize.width;

  h(double height) => (height * this) / designSize.height;
}

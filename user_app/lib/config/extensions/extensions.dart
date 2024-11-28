import 'package:flutter/material.dart';

extension CustomSizedBox on int {
  SizedBox get ah => SizedBox(height: toDouble());
  SizedBox get aw => SizedBox(width: toDouble());
}

extension Size on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  void get pop => Navigator.pop(this);

  void pushReplacement(Widget screen) {
    Navigator.pushReplacement(this, MaterialPageRoute(builder: (_) => screen));
    return;
  }

  void push(Widget screen) {
    Navigator.push(this, MaterialPageRoute(builder: (_) => screen));
    return;
  }
}

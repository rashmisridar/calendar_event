import 'package:atem_interview/utils/coonst_color.dart';
import 'package:flutter/material.dart';

class Indicator {
  Widget progressIndicator() {
    return Center(
        child: Container(
            height: 15,
            width: 15,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: new AlwaysStoppedAnimation<Color>(CoonstColor.blue),
            )));
  }
}

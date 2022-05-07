import 'package:atem_interview/utils/coonst_color.dart';
import 'package:flutter/material.dart';

import '../../utils/coonst_string.dart';
import '../../utils/custom_style/custom_text_style.dart';

class CalendarEvent extends StatelessWidget {
  const CalendarEvent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: CoonstColor.blue,
          title: Text(
            CoonstString.calendarEvents,
            style: CustomTextStyle()
                .fontSizeNormal(CoonstColor.white, FontWeight.w500, 20),
          ),
        ),
        body: Container());
  }
}

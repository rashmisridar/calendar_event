import 'package:atem_interview/utils/coonst_string.dart';
import 'package:atem_interview/utils/custom_style/custom_text_style.dart';
import 'package:flutter/material.dart';

import '../utils/coonst_color.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MaterialButton(
            height: 50,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: CoonstColor.blue)),
            minWidth: double.infinity,
            color: CoonstColor.blue,
            textColor: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/calendarevent');
            },
            child: Text(
              CoonstString.question1,
              style: CustomTextStyle()
                  .fontSizeNormal(CoonstColor.white, FontWeight.w400, 14.0),
            ),
          ),
          const SizedBox(height: 20),
          MaterialButton(
            height: 50,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: CoonstColor.blue)),
            minWidth: double.infinity,
            color: CoonstColor.blue,
            textColor: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/products');
            },
            child: Text(
              CoonstString.question2,
              style: CustomTextStyle()
                  .fontSizeNormal(CoonstColor.white, FontWeight.w400, 14.0),
            ),
          ),
        ],
      ),
    ));
  }
}

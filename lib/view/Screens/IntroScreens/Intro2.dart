import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant/utils/intro_button.dart';
import 'package:resturant/utils/intro_images.dart';

import '../../../utils/lorem.dart';

class Intro2 extends StatefulWidget {
  const Intro2({super.key});

  @override
  State<Intro2> createState() => _Intro2State();
}

class _Intro2State extends State<Intro2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        introImage('assets/images/plate.jpg'),
        Text(
          'Order for Food',
          style: TextStyle(
              color: Colors.green[700],
              fontSize: 160.sp,
              wordSpacing: 5,
              fontWeight: FontWeight.bold),
        ),
        loremText(Colors.black),
        Container(
          margin: EdgeInsets.only(bottom: 100.h),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              width: 140.w,
              height: 34.h,
              decoration: BoxDecoration(
                  color: Colors.green[700],
                  borderRadius: BorderRadius.circular(21.r)),
            ),
            Container(
              width: 40.w,
              height: 34.h,
              decoration:
                  BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
            ),
            Container(
              width: 10,
              height: 34.h,
              decoration:
                  BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
            ),
          ]),
        ),
        introButton()
      ]),
    );
  }
}

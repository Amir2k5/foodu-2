import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant/utils/intro_button.dart';
import 'package:resturant/utils/intro_images.dart';
import 'package:resturant/utils/lorem.dart';

class Intro3 extends StatefulWidget {
  const Intro3({super.key});

  @override
  State<Intro3> createState() => _Intro3State();
}

class _Intro3State extends State<Intro3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        introImage('assets/images/transaction.jpg'),
        Text(
          'Easy Payment',
          style: TextStyle(
              color: Colors.green[700],
              fontSize: 160.sp,
              wordSpacing: 5,
              fontWeight: FontWeight.bold),
        ),
        loremText(Colors.black),
        Container(
          margin: EdgeInsets.only(bottom: 106.h),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              width: 40.w,
              height: 33.h,
              decoration:
                  BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
            ),
            Container(
              width: 140.w,
              height: 33.h,
              decoration: BoxDecoration(
                  color: Colors.green[700],
                  borderRadius: BorderRadius.circular(21.r)),
            ),
            Container(
              width: 40.w,
              height: 33.h,
              decoration:
                  BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
            ),
          ]),
        ),
        introButton()
      ]),
    );
    ;
  }
}

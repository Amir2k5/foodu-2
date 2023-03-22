import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//
//
// not used in this project
//
//
Widget Edit(String label) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Container(
        padding: EdgeInsets.all(40.sp),
        margin: EdgeInsets.all(20.sp),
        width: 520.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(42.r),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.green, blurRadius: 10)]),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Container(
            margin: EdgeInsets.only(bottom: 21.h),
            height: 640.h,
            width: 600.w,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/pizza.jpg'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(63.r)),
          ),
          Text(
            'New $label',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 68.sp),
          ),
        ]),
      ),
      Text(
        'Add A New $label',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 76.sp,
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline,
          decorationStyle: TextDecorationStyle.solid,
          shadows: [
            Shadow(color: Colors.green, blurRadius: 25, offset: Offset(2, 6))
          ],
        ),
      ),
    ],
  );
}

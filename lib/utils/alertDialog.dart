import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant/utils/spinkit.dart';

Widget alertDialog() {
  return AlertDialog(
    shape: OutlineInputBorder(borderRadius: BorderRadius.circular(125.r)),
    contentPadding: EdgeInsets.all(40.sp),
    content: Container(
      height: 1700.h,
      child: Column(children: [
        Container(
          height: 800.h,
          child: Image(image: AssetImage('assets/images/personicon.jpg')),
        ),
        Text(
          'Congratulation',
          style: TextStyle(
              color: Colors.green[700],
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        SizedBox(
          height: 42.h,
        ),
        Text(
            "Your account is ready to use. You will be redirected to the Home Page in a few seconds."),
        SizedBox(
          height: 84.h,
        ),
        loadingSpinkit()
      ]),
    ),
  );
}

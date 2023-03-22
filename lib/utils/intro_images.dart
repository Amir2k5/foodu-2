import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget introImage(String image) {
  return Container(
    margin: EdgeInsets.only(top: 84.h, bottom: 84.h),
    width: double.infinity,
    height: 1570.h,
    child: Image(
      image: AssetImage(image),
      fit: BoxFit.cover,
    ),
  );
}

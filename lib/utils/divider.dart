import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget divider() {
  return Row(
    children: [
      Expanded(
        child: Divider(
          thickness: 4.sp,
          color: Color.fromARGB(255, 128, 128, 128),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 48.w),
        child: Text(
          'or continue with',
          style: TextStyle(color: Color.fromARGB(255, 128, 128, 128)),
        ),
      ),
      Expanded(
        child: Divider(
          thickness: 4.sp,
          color: Color.fromARGB(255, 128, 128, 128),
        ),
      ),
    ],
  );
}

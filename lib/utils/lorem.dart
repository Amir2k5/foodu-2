import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget loremText(Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 140.w, vertical: 126.h),
    child: Text(
      lorem(paragraphs: 1, words: 20),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
      ),
    ),
  );
}

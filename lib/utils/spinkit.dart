import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget loadingSpinkit() {
  return Container(
    child: Center(
      child: SpinKitCircle(
        color: Colors.green[700],
        size: 200.sp,
      ),
    ),
  );
}

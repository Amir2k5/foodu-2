import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../Provider/increment.dart';

Widget introButton() {
  return Consumer<IncrementProvider>(
    builder: (context, value, child) => ElevatedButton(
      onPressed: () {
        value.increment();
      },
      child: Text('Next'),
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green[700],
          fixedSize: Size(1200.w, 168.h),
          shape: StadiumBorder()),
    ),
  );
}

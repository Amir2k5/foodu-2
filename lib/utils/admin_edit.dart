import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget EditImage(
    String image, String label, BuildContext context, Widget page) {
  return InkWell(
    onTap: () => Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => page,
    )),
    child: Container(
      margin: EdgeInsets.all(28.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(42.r),
        color: Color.fromARGB(255, 238, 238, 238),
        boxShadow: [BoxShadow(color: Colors.black, blurRadius: 3)],
      ),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Container(
          margin: EdgeInsets.only(bottom: 21.h),
          height: 555.h,
          width: 560.w,
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(63.r)),
        ),
        Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 60.sp,
              overflow: TextOverflow.ellipsis),
        ),
      ]),
    ),
  );
}

Widget EditText(String label) {
  return Text(
    label,
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 19,
      fontStyle: FontStyle.italic,
      decoration: TextDecoration.underline,
      decorationStyle: TextDecorationStyle.solid,
      shadows: [
        Shadow(color: Colors.green, blurRadius: 25, offset: Offset(2, 6))
      ],
    ),
  );
}

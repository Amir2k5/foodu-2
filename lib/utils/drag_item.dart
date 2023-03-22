import 'dart:io';

import 'package:badges/badges.dart' as badge;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget dragItem(String image, String name, String price, [int dishes = 1]) {
  return badge.Badge(
    badgeContent: Text(
      'x$dishes',
      style: TextStyle(color: Colors.white, fontSize: 68.sp),
    ),
    badgeStyle: badge.BadgeStyle(
        padding: const EdgeInsets.all(7), badgeColor: Colors.green.shade700),
    position: badge.BadgePosition.topEnd(top: 0, end: 5),
    child: Container(
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(color: Colors.black, blurRadius: 5, offset: Offset(1, 1))
      ], color: Colors.white, borderRadius: BorderRadius.circular(63.r)),
      margin: EdgeInsets.only(top: 42.h, right: 40.w, left: 30.w),
      padding: EdgeInsets.all(20.sp),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20.w, right: 80.w),
              height: 555.h,
              width: 520.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(image),
                      fit: BoxFit.cover),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(63.r)),
            ),
            Container(
              height: 555.h,
              width: 600.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 68.sp,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 80.sp,
                      ),
                      const Text('4.6 (1.4k)')
                    ],
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$$price',
                        style: TextStyle(
                            color: Colors.green[700],
                            fontSize: 80.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 60.w,
                      ),
                      Text(
                        '|   2.2km',
                        style: TextStyle(
                          fontSize: 60.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Text('    x$dishes')
          ]),
    ),
  );
}

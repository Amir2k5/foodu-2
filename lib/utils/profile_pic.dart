import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/user.dart';

Widget profilePicture(Users user) {
  return Container(
    margin: EdgeInsets.only(left: 40.w, top: 42.h),
    height: 298.h,
    width: 280.w,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      image: DecorationImage(
          image: CachedNetworkImageProvider(user.userImage!),
          fit: BoxFit.cover),
    ),
  );
}

import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant/utils/drag_item.dart';
import 'package:resturant/model/discounts.dart';
import 'package:resturant/model/dish.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';

class DiscountsScreen extends StatefulWidget {
  List<DiscountModel> discounts;
  DiscountsScreen({super.key, required this.discounts});

  @override
  State<DiscountsScreen> createState() => _DiscountsScreenState();
}

class _DiscountsScreenState extends State<DiscountsScreen> {
  bool acceptedData = false;
  bool press = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discounts"),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: widget.discounts.length,
          itemBuilder: (context, index) {
            return FadeInUp(
              duration: Duration(milliseconds: 1000),
              child: Container(
                foregroundDecoration: RotatedCornerDecoration.withColor(
                  textSpan: TextSpan(
                      text:
                          '30% Discount\n ${widget.discounts[index].discountDuration}hr left!',
                      style: TextStyle(
                          fontSize: 40.sp, fontWeight: FontWeight.bold)),
                  color: Colors.green.shade700,
                  badgeSize: Size(300.w, 320.h),
                  badgeCornerRadius: Radius.circular(42.r),
                ),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 21.r,
                          // spreadRadius: 5,
                          offset: Offset(1, 1))
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(63.r)),
                margin: EdgeInsets.only(top: 42.h, right: 40.w),
                padding: EdgeInsets.all(21.r),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                    margin: EdgeInsets.only(left: 21.w, right: 80.w),
                    height: 555.h,
                    width: 520.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                widget.discounts[index].discountImage),
                            fit: BoxFit.cover),
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  Container(
                    height: 555.h,
                    width: 600.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.discounts[index].discountName,
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
                            Text('4.6 (1.4k)')
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                '\$${widget.discounts[index].discountDuration}'),
                            Icon(Icons.favorite_outline)
                          ],
                        )
                      ],
                    ),
                  )
                ]),
              ),
            );
          },
        ),
      ),
    );
  }
}

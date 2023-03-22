import 'dart:io';

// import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:resturant/Provider/orderProvider.dart';
import 'package:resturant/model/dish.dart';
import 'package:resturant/model/order.dart';
import 'package:badges/badges.dart' as badge;
import '../../../Database/db.dart';
import '../../../Provider/dishProvider.dart';

class CanncelledOrders extends StatelessWidget {
    String orderUserId;
  CanncelledOrders({required this.orderUserId});
  List<OrdersModel> cancelled_orders = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService().getCancelledCartOrders(orderUserId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              children: [
                Image(image: AssetImage('assets/images/emptycart.jpg')),
                Text(
                  'Empty',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 60.sp),
                ),
                Text("You don't have any cancelled order at this time.")
              ],
            ),
          );
        } else {
          var all_orders = snapshot.data;
          cancelled_orders.clear();
          cancelled_orders = all_orders!;
          // .where((element) =>
          //     !element.orderAccepted &&
          //     !element.orderCompleted &&
          //     element.orderCancelled)
          // .toList();
          if (cancelled_orders.isEmpty) {
            return Center(
              child: Column(
                children: [
                  Image(image: AssetImage('assets/images/emptycart.jpg')),
                  Text(
                    'Empty',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 60.sp),
                  ),
                  Text("You don't have any completed order at this time.")
                ],
              ),
            );
          } else {
            return ListView.builder(
                itemCount: cancelled_orders.length,
                itemBuilder: (context, index) {
                  return badge.Badge(
                    badgeContent: Text(
                      'x${cancelled_orders[index].orderQuantity}',
                      style: TextStyle(color: Colors.white, fontSize: 68.sp),
                    ),
                    badgeStyle: badge.BadgeStyle(
                        padding: const EdgeInsets.all(7),
                        badgeColor: Colors.green.shade700),
                    position: badge.BadgePosition.topEnd(top: 0, end: 5),
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black,
                                blurRadius: 5,
                                // spreadRadius: 5,
                                offset: Offset(1, 1))
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(63.r)),
                      margin: EdgeInsets.only(top: 42.h, right: 40.w),
                      padding: EdgeInsets.all(20.sp),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20.w, right: 80.w),
                              height: 555.h,
                              width: 520.w,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          cancelled_orders[index]
                                              .orderDishImage),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(106.r)),
                            ),
                            Container(
                              height: 555.h,
                              width: 600.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    cancelled_orders[index].orderDishName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 68.sp,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${cancelled_orders[index].orderDishPrice} per item',
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '\$${(int.parse(cancelled_orders[index].orderDishPrice) * cancelled_orders[index].orderQuantity)}',
                                        style: TextStyle(
                                            color: Colors.green[700],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 72.sp),
                                      ),
                                      Container(
                                        height: 128.h,
                                        width: 360.w,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 52.w, vertical: 21.h),
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            border:
                                                Border.all(color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(28.r)),
                                        child: Text(
                                          'Cancelled',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ]),
                    ),
                  );
                });
          }
        }
      },
    );
  }
}

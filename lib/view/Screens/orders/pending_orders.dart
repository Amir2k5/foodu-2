import 'dart:io';

// import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:resturant/Database/db.dart';
import 'package:resturant/Provider/dishProvider.dart';
import 'package:resturant/Provider/orderProvider.dart';
import 'package:resturant/model/dish.dart';
import 'package:resturant/model/order.dart';
import 'package:badges/badges.dart' as badge;
import '../../../Provider/offerProvider.dart';

class PendingOrders extends StatelessWidget {
  String orderUserId;
  PendingOrders({required this.orderUserId});
  List<OrdersModel> pendingOrders = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: StreamBuilder(
        stream: DatabaseService().getCartOrders(orderUserId),
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
                  Text("You don't have any pending order at this time.")
                ],
              ),
            );
          } else {
            var all_orders = snapshot.data;
            pendingOrders.clear();
            pendingOrders = all_orders!
                .where((element) =>
                    !element.orderAccepted &&
                    !element.orderCancelled &&
                    !element.orderCompleted)
                .toList();
            if (pendingOrders.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    Image(image: AssetImage('assets/images/emptycart.jpg')),
                    Text(
                      'Empty',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 60.sp),
                    ),
                    Text("You don't have any completed order at this time.")
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: pendingOrders.length,
                itemBuilder: (context, index) => badge.Badge(
                  badgeContent: Text(
                    'x${pendingOrders[index].orderQuantity}',
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
                              offset: Offset(1, 1))
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(63.r)),
                    margin: EdgeInsets.only(top: 42.h, right: 40.w),
                    padding: EdgeInsets.all(21.r),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin:
                                    EdgeInsets.only(left: 20.w, right: 80.w),
                                height: 555.h,
                                width: 520.w,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            pendingOrders[index]
                                                .orderDishImage),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(100.r)),
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
                                      pendingOrders[index].orderDishName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 68.sp,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '${pendingOrders[index].orderDishPrice} per item',
                                          style: TextStyle(color: Colors.grey),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          '\$${(int.parse(pendingOrders[index].orderDishPrice) * pendingOrders[index].orderQuantity)}',
                                          style: TextStyle(
                                              color: Colors.green[700],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 72.sp),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 80.w),
                                          height: 123.h,
                                          width: 220.w,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 52.w, vertical: 21.h),
                                          decoration: BoxDecoration(
                                              color: Colors.green[700],
                                              borderRadius:
                                                  BorderRadius.circular(28.r)),
                                          child: Text(
                                            'Paid',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ]),
                        Divider(
                          thickness: 8.sp,
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OutlinedButton(
                                onPressed: () async {
                                  var order = OrdersModel(
                                      orderId: pendingOrders[index].orderId,
                                      orderUserId: orderUserId,
                                      orderDishId:
                                          pendingOrders[index].orderDishId,
                                      orderDishName:
                                          pendingOrders[index].orderDishName,
                                      orderDishCategory: pendingOrders[index]
                                          .orderDishCategory,
                                      orderDishImage:
                                          pendingOrders[index].orderDishImage,
                                      orderDishPrice:
                                          pendingOrders[index].orderDishPrice,
                                      // orderDishIsFav:
                                      //     pendingOrders[index].orderDishIsFav,
                                      orderQuantity:
                                          pendingOrders[index].orderQuantity,
                                      orderCancelled: true,
                                      orderAccepted: false,
                                      orderCompleted: false);
                                  await FirebaseFirestore.instance
                                      .collection('orders')
                                      .doc(pendingOrders[index].orderId)
                                      .update(order.toMap());
                                  Fluttertoast.showToast(
                                      msg: 'Order Cancelled');
                                },
                                style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.red,
                                    fixedSize: Size(720.w, 63.h),
                                    shape: StadiumBorder(),
                                    side: BorderSide(
                                        color: Colors.red, width: 8.w)),
                                child: Text('❌\t\t\t\t\t\tCancel Order ')),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}

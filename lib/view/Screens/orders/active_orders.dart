// import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:resturant/Database/db.dart';
import 'package:resturant/model/order.dart';
import 'package:badges/badges.dart' as badge;

class Activeorders extends StatelessWidget {
    String orderUserId;
  Activeorders({required this.orderUserId});
  List<OrdersModel> active_orders = [];
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
                  Text("You don't have any active order at this time.")
                ],
              ),
            );
          } else {
            var all_orders = snapshot.data;
            active_orders.clear();
            active_orders = all_orders!
                .where((element) =>
                    element.orderAccepted &&
                    !element.orderCancelled &&
                    !element.orderCompleted)
                .toList();
            if (active_orders.isEmpty) {
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
                itemCount: active_orders.length,
                itemBuilder: (context, index) => badge.Badge(
                  badgeContent: Text(
                    'x${active_orders[index].orderQuantity}',
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
                                            active_orders[index]
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
                                      active_orders[index].orderDishName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 68.sp,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '${active_orders[index].orderDishPrice} per item',
                                          style: TextStyle(color: Colors.grey),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          '\$${(int.parse(active_orders[index].orderDishPrice) * active_orders[index].orderQuantity)}',
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
                                      orderId: active_orders[index].orderId,
                                      orderUserId: orderUserId,
                                      orderDishId:
                                          active_orders[index].orderDishId,
                                      orderDishName:
                                          active_orders[index].orderDishName,
                                      orderDishCategory: active_orders[index]
                                          .orderDishCategory,
                                      orderDishImage:
                                          active_orders[index].orderDishImage,
                                      orderDishPrice:
                                          active_orders[index].orderDishPrice,
                                      // orderDishIsFav:
                                      //     active_orders[index].orderDishIsFav,
                                      orderQuantity:
                                          active_orders[index].orderQuantity,
                                      orderCancelled:
                                          active_orders[index].orderCancelled,
                                      orderAccepted: false,
                                      orderCompleted: false);
                                  await FirebaseFirestore.instance
                                      .collection('orders')
                                      .doc(active_orders[index].orderId)
                                      .update(order.toMap());
                                  Fluttertoast.showToast(
                                      msg: 'Order Cancelled');
                                },
                                style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.green[700],
                                    fixedSize: Size(620.w, 63.h),
                                    shape: StadiumBorder(),
                                    side: BorderSide(
                                        color: Colors.green.shade700,
                                        width: 8.w)),
                                child: Text('Cancel Order')),
                            ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size(620.w, 63.h),
                                    backgroundColor: Colors.green[700],
                                    foregroundColor: Colors.white,
                                    shape: StadiumBorder()),
                                child: Text('Track Driver'))
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

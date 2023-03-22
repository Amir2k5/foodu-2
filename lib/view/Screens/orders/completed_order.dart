// import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant/model/order.dart';
import 'package:badges/badges.dart' as badge;
import '../../../Database/db.dart';

class CompletedOrders extends StatelessWidget {
    String orderUserId;
  CompletedOrders({required this.orderUserId});
  List<OrdersModel> completed_orders = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: StreamBuilder(
        stream: DatabaseService().getCompleteCartOrders(orderUserId),
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
                  Text("You don't have any completed order at this time.")
                ],
              ),
            );
          } else {
            var all_orders = snapshot.data;
            completed_orders.clear();

            completed_orders = all_orders!
                .where((element) =>
                    element.orderAccepted &&
                    element.orderCompleted &&
                    !element.orderCancelled)
                .toList();
            if (completed_orders.isEmpty) {
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
                itemCount: completed_orders.length,
                itemBuilder: (context, index) => badge.Badge(
                  badgeContent: Text(
                    'x${completed_orders[index].orderQuantity}',
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
                              blurRadius: 20.r,
                              offset: Offset(1, 1))
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(60.r)),
                    margin: EdgeInsets.only(top: 42.h, right: 40.w),
                    padding: EdgeInsets.all(20.sp),
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
                                            completed_orders[index]
                                                .orderDishImage),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(100.r)),
                              ),
                              Container(
                                height: 555.h,
                                width: 730.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      completed_orders[index].orderDishName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 68.sp,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '${completed_orders[index].orderDishPrice} per item',
                                          style: TextStyle(color: Colors.grey),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          '\$${(completed_orders[index].orderDishPrice * completed_orders[index].orderQuantity)}',
                                          style: TextStyle(
                                              color: Colors.green[700],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 72.sp),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 80.w),
                                          height: 126.h,
                                          width: 370.w,
                                          decoration: BoxDecoration(
                                              color: Colors.green[700],
                                              borderRadius:
                                                  BorderRadius.circular(28.r)),
                                          child: Center(
                                            child: Text(
                                              'Completed',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ]),
                        Divider(
                          thickness: 2,
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.green[700],
                                    fixedSize: Size(155, 30),
                                    shape: StadiumBorder(),
                                    side: BorderSide(
                                        color: Colors.green.shade700,
                                        width: 2)),
                                child: Text('Leave a Review')),
                            ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size(155, 30),
                                    backgroundColor: Colors.green[700],
                                    foregroundColor: Colors.white,
                                    shape: StadiumBorder()),
                                child: Text('Order Again'))
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

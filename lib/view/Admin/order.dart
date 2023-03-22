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
import 'package:resturant/Provider/userProvider.dart';
import 'package:resturant/model/dish.dart';
import 'package:resturant/model/offers.dart';
import 'package:badges/badges.dart' as badge;

import '../../model/order.dart';

class Orders extends StatefulWidget {
  Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<DishModel> allDishes = [];

  List<DishModel> orderDishes = [];

  List<OrdersModel> orders = [];
  String? orderUserId;
  @override
  void initState() {
    orderUserId = Provider.of<UserProvider>(context,listen: false).user!.uid;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: Text('Manage Orders')),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder<List<OrdersModel>>(
            stream: DatabaseService().getCartOrders(orderUserId!),
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 60.sp),
                      ),
                      Text("You don't have any order at this time.")
                    ],
                  ),
                );
              } else {
                var orders = snapshot.data;
                return ListView.builder(
                  itemCount: orders!.length,
                  itemBuilder: (context, index) => badge.Badge(
                    badgeContent: Text(
                      'x${orders[index].orderQuantity}',
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
                          borderRadius: BorderRadius.circular(15)),
                      margin: EdgeInsets.only(top: 10, right: 10),
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 5, right: 20),
                                  height: 130,
                                  width: 130,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              orders[index].orderDishImage),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(25)),
                                ),
                                Container(
                                  height: 130,
                                  width: 150,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        orders[index].orderDishName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${orders[index].orderDishPrice} per item',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            '\$${(int.parse(orders[index].orderDishPrice) * orders[index].orderQuantity).toStringAsFixed(2)}',
                                            style: TextStyle(
                                                color: Colors.green[700],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 20),
                                            height: 30,
                                            width: 55,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 13, vertical: 5),
                                            decoration: BoxDecoration(
                                                color: Colors.green[700],
                                                borderRadius:
                                                    BorderRadius.circular(7)),
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
                            thickness: 2,
                            color: Colors.grey,
                          ),
                          !orders[index].orderCompleted
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    OutlinedButton(
                                        onPressed: () async {
                                          var order = OrdersModel(
                                              orderId: orders[index].orderId,
                                              orderUserId:
                                                  orders[index].orderUserId,
                                              orderDishId:
                                                  orders[index].orderDishId,
                                              orderDishName:
                                                  orders[index].orderDishName,
                                              orderDishCategory: orders[index]
                                                  .orderDishCategory,
                                              orderDishPrice:
                                                  orders[index].orderDishPrice,
                                              orderDishImage:
                                                  orders[index].orderDishImage,
                                              // orderDishIsFav:
                                              //     orders[index].orderDishIsFav,
                                              orderQuantity:
                                                  orders[index].orderQuantity,
                                              orderCancelled: true,
                                              orderAccepted: false,
                                              orderCompleted: false);
                                          await FirebaseFirestore.instance
                                              .collection('orders')
                                              .doc(orders[index].orderId)
                                              .update(order.toMap());
                                          Fluttertoast.showToast(
                                              msg: 'Order Cancelled');
                                        },
                                        style: OutlinedButton.styleFrom(
                                            foregroundColor: Colors.green[700],
                                            fixedSize: Size(150, 40),
                                            shape: StadiumBorder(),
                                            side: BorderSide(
                                                color: Colors.green.shade700,
                                                width: 2)),
                                        child: Text('Cancel Order')),
                                    !orders[index].orderAccepted
                                        ? ElevatedButton(
                                            onPressed: () async {
                                              var order = OrdersModel(
                                                  orderId:
                                                      orders[index].orderId,
                                                  orderUserId:
                                                      orders[index].orderUserId,
                                                  orderDishId:
                                                      orders[index].orderDishId,
                                                  orderDishName: orders[index]
                                                      .orderDishName,
                                                  orderDishCategory:
                                                      orders[index]
                                                          .orderDishCategory,
                                                  orderDishPrice: orders[index]
                                                      .orderDishPrice,
                                                  orderDishImage: orders[index]
                                                      .orderDishImage,
                                                  // orderDishIsFav: orders[index]
                                                  //     .orderDishIsFav,
                                                  orderQuantity: orders[index]
                                                      .orderQuantity,
                                                  orderCancelled: false,
                                                  orderAccepted: true,
                                                  orderCompleted: false);
                                              await FirebaseFirestore.instance
                                                  .collection('orders')
                                                  .doc(orders[index].orderId)
                                                  .update(order.toMap());
                                              Fluttertoast.showToast(
                                                  msg: 'Order Accepted');
                                            },
                                            style: ElevatedButton.styleFrom(
                                                fixedSize: Size(150, 40),
                                                backgroundColor:
                                                    Colors.green[700],
                                                foregroundColor: Colors.white,
                                                shape: StadiumBorder()),
                                            child: Text('Accept Order'))
                                        : ElevatedButton(
                                            onPressed: () async {
                                              var order = OrdersModel(
                                                  orderId:
                                                      orders[index].orderId,
                                                  orderUserId:
                                                      orders[index].orderUserId,
                                                  orderDishId:
                                                      orders[index].orderDishId,
                                                  orderDishName: orders[index]
                                                      .orderDishName,
                                                  orderDishCategory:
                                                      orders[index]
                                                          .orderDishCategory,
                                                  orderDishPrice: orders[index]
                                                      .orderDishPrice,
                                                  orderDishImage: orders[index]
                                                      .orderDishImage,
                                                  // orderDishIsFav: orders[index]
                                                  //     .orderDishIsFav,
                                                  orderQuantity: orders[index]
                                                      .orderQuantity,
                                                  orderCancelled: false,
                                                  orderAccepted: true,
                                                  orderCompleted: true);
                                              await FirebaseFirestore.instance
                                                  .collection('orders')
                                                  .doc(orders[index].orderId)
                                                  .update(order.toMap());

                                              Fluttertoast.showToast(
                                                  msg: 'Order Completed');
                                            },
                                            style: ElevatedButton.styleFrom(
                                                fixedSize: Size(150, 40),
                                                backgroundColor:
                                                    Colors.green[700],
                                                foregroundColor: Colors.white,
                                                shape: StadiumBorder()),
                                            child: Text('Order Completed'))
                                  ],
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 250,
                                  decoration: BoxDecoration(
                                      color: Colors.green[700],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text(
                                    'Order is Completed  ✓',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                )
                        ],
                      ),
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}

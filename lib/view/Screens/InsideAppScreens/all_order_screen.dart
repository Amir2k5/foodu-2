import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:remove_background/crop_widget.dart';
import 'package:resturant/Database/db.dart';
import 'package:resturant/view/Screens/orders/active_orders.dart';
import 'package:resturant/view/Screens/orders/cancelled_orders.dart';
import 'package:resturant/view/Screens/orders/completed_order.dart';
import 'package:resturant/view/Screens/orders/pending_orders.dart';
import 'package:resturant/model/dish.dart';
import 'package:resturant/model/order.dart';
import 'package:resturant/model/user.dart';

import '../../../Provider/orderProvider.dart';

class AllOrderScreen extends StatefulWidget {
  Users user;
   AllOrderScreen({super.key,required this.user});

  @override
  State<AllOrderScreen> createState() => _AllOrderScreenState();
}

class _AllOrderScreenState extends State<AllOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: Text('Orders'),
          leading: Container(
            padding: EdgeInsets.only(left: 13, top: 13, bottom: 13, right: 13),
            child: Image(
              image: AssetImage(
                'assets/images/logo.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
          bottom: TabBar(
              labelPadding: EdgeInsets.only(bottom: 34.h),
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.green[700],
              indicatorColor: Colors.green,
              labelStyle:
                  TextStyle(fontSize: 61.sp, fontWeight: FontWeight.bold),
              tabs: [
                Text('Pending'),
                Text('Active'),
                Text('Completed'),
                Text('Cancelled')
              ]),
        ),
        body: TabBarView(children: [
          PendingOrders(orderUserId: widget.user.uid),
          Activeorders(orderUserId: widget.user.uid),
          CompletedOrders(orderUserId: widget.user.uid),
          CanncelledOrders(orderUserId: widget.user.uid)
        ]),
      ),
    );
  }
}

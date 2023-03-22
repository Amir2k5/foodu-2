import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:resturant/Database/db.dart';
import 'package:resturant/Provider/userProvider.dart';
import 'package:resturant/utils/drag_item.dart';
import 'package:resturant/model/order.dart';

import '../../../utils/drag_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool acceptedData = false;
  bool press = false;
  String? orderUserId;
  @override
  void initState() {
    orderUserId = Provider.of<UserProvider>(context,listen: false).user!.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final key = UniqueKey();
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: StreamBuilder(
        stream: DatabaseService().getCartOrders(orderUserId!),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                children: [
                  const Image(image: AssetImage('assets/images/emptycart.jpg')),
                  Text(
                    'Empty',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 60.sp),
                  ),
                  const Text("You don't have any food in cart at this time.")
                ],
              ),
            );
          } else {
            List<OrdersModel>? order = snapshot.data;
            return ListView.builder(
              itemCount: order!.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(order[index].orderId),
                  onDismissed: (direction) async {
                    var doc = FirebaseFirestore.instance
                        .collection('orders')
                        .doc(order[index].orderId);

                    await doc.delete().then((value) {
                      setState(() {});
                    });

                    Fluttertoast.showToast(
                      msg: '${order[index].orderDishName} removed',
                      backgroundColor: Colors.green[700],
                      gravity: ToastGravity.SNACKBAR,
                    );
                  },
                  background: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 40,
                        ),
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 40,
                        ),
                      ],
                    ),
                  ),
                  child: dragItem(
                      order[index].orderDishImage,
                      order[index].orderDishName,
                      order[index].orderDishPrice.toString(),
                      order[index].orderQuantity),
                );
              },
            );
          }
        },
      ),
    );
  }
}

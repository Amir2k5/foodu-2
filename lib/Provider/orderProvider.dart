// import 'dart:math';

// import 'package:flutter/cupertino.dart';
// import 'package:resturant/Database/db.dart';
// import 'package:resturant/model/discounts.dart';
// import 'package:resturant/model/order.dart';
// import 'package:resturant/model/order.dart';

// class OrderProvider with ChangeNotifier {
//   int result = 0;
//   List<OrdersModel> _all_orders = [];
//   List<OrdersModel> get all_orders => _all_orders;
//   DatabaseHelper db = DatabaseHelper.constructor();
//   Future<int> insertOrder(OrdersModel order) async {
//     result = await db.insertOrder(order);
//     notifyListeners();
//     return result;
//   }

//   Future updateOrder(OrdersModel order) async {
//     result = await db.updateOrder(order);
//     notifyListeners();
//     return result;
//   }

//   Future<int> removeOrder(OrdersModel order) async {
//     result = await db.removeOrder(order);
//     notifyListeners();
//     return result;
//   }

//   Future<List<OrdersModel>> getAllOrders() async {
//     _all_orders = await db.getAllOrders();
//     notifyListeners();

//     return _all_orders;
//   }
// }

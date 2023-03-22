// import 'dart:math';

// import 'package:flutter/cupertino.dart';
// import 'package:resturant/Database/db.dart';
// import 'package:resturant/model/discounts.dart';

// class DiscountProvider with ChangeNotifier {
//   int result = 0;
//   List<DiscountModel> _all_discounts = [];
//   List<DiscountModel> get all_discounts => _all_discounts;
//   DatabaseHelper db = DatabaseHelper.constructor();
//   Future<int> insertDiscount(DiscountModel discount) async {
//     result = await db.insertDiscount(discount);
//     notifyListeners();
//     return result;
//   }

//   Future updateDiscount(DiscountModel discount) async {
//     result = await db.updateDiscount(discount);
//     notifyListeners();
//     return result;
//   }

//   Future<int> removeDiscount(DiscountModel discount) async {
//     result = await db.removeDiscount(discount);
//     notifyListeners();
//     return result;
//   }

//   Future<List<DiscountModel>> getAllDiscounts() async {
//     _all_discounts = await db.getAllDiscounts();
//     notifyListeners();

//     return _all_discounts;
//   }
// }

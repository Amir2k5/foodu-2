// import 'dart:math';

// import 'package:flutter/cupertino.dart';
// import 'package:resturant/Database/db.dart';
// import 'package:resturant/model/dish.dart';

// class DishProvider with ChangeNotifier {
//   int result = 0;
//   List<DishModel> _all_dishes = [];
//   List<DishModel> get all_dishes => _all_dishes;
//   List<DishModel>? category_dishes;
//   DishModel? single_dish;
//   DatabaseHelper db = DatabaseHelper.constructor();
//   Future<int> insertDish(DishModel dish) async {
//     result = await db.insertDish(dish);
//     notifyListeners();
//     return result;
//     // notifyListeners();
//     // await Future.delayed(Duration(milliseconds: 300));
//     // return db.insertDish(dish);
//   }

//   Future updateDish(DishModel dish) async {
//     result = await db.updateDish(dish);
//     notifyListeners();
//     return result;
//   }

//   Future<int> removeDish(DishModel dish) async {
//     result = await db.removeDish(dish);
//     notifyListeners();
//     return result;
//     // notifyListeners();
//     // await Future.delayed(Duration(milliseconds: 300));

//     // return db.removeDish(dish);
//   }

//   Future<List<DishModel>> getAllDishes() async {
//     _all_dishes = await db.getAllDishes();
//     notifyListeners();
//     // await Future.delayed(Duration(milliseconds: 300));

//     return _all_dishes;
//   }

//   Future<List<DishModel>?> getAllCategoryDishes(String category) async {
//     category_dishes = await db.getAllCategoryDishes(category);
//     notifyListeners();
//     // await Future.delayed(Duration(milliseconds: 300));

//     return category_dishes;
//   }

//   Future<DishModel?> getSingleDish(String dish_name) async {
//     single_dish = await db.getSingleDish(dish_name);

//     return single_dish;
//   }
// }

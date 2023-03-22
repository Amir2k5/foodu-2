import 'dart:io';

import 'package:flutter/foundation.dart';

class DishModel {
  late String dishId;
  late String dishName;
  late String dishCategory;
  late int dishPrice;
  late String dishImage;
  DishModel(
      {required this.dishId,
      required this.dishName,
      required this.dishCategory,
      required this.dishPrice,
      required this.dishImage,});
  Map<String, dynamic> toMap() {
    return {
      'dishId': dishId,
      'dishName': dishName,
      'dishCategory': dishCategory,
      'dishPrice': dishPrice,
      'dishImage': dishImage,
    };
  }

  DishModel.fromMap(Map<String, dynamic> map) {
    dishId = map['dishId'];
    dishName = map['dishName'];
    dishCategory = map['dishCategory'];
    dishPrice = map['dishPrice'];
    dishImage = map['dishImage'];
  }
}

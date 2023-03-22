import 'dart:io';

class OrdersModel {
  late String orderId;
  late String orderUserId;

  late String orderDishId;
  late String orderDishName;
  late String orderDishCategory; 
  late String orderDishPrice;
  late String orderDishImage;
  // late bool orderDishIsFav;
  late int orderQuantity;
  late bool orderAccepted;
  late bool orderCompleted;
  late bool orderCancelled;

  OrdersModel(
      {required this.orderId,

      required this.orderUserId,
      required this.orderDishId,
      required this.orderDishName,
      required this.orderDishCategory,
      required this.orderDishPrice,
      required this.orderDishImage,
      // required this.orderDishIsFav,
      required this.orderQuantity,
      required this.orderAccepted,
      required this.orderCompleted,
      required this.orderCancelled});
  Map<String, dynamic> toMap() {
    {
      return {
        'orderId': orderId,
        'orderUserId': orderUserId,
        'orderDishId': orderDishId,
        'orderDishName': orderDishName,
        'orderDishCategory': orderDishCategory,
        'orderDishPrice': orderDishPrice,
        'orderDishImage': orderDishImage,
        // 'orderDishIsFav': orderDishIsFav,
        'orderQuantity': orderQuantity,
        'orderAccepted': orderAccepted,
        'orderCompleted': orderCompleted,
        'orderCancelled': orderCancelled
      };
    }
  }

  OrdersModel.fromMap(Map<String, dynamic> map) {
    orderId = map['orderId'];
    orderUserId = map['orderUserId'];
    orderDishId = map['orderDishId'];
    orderDishName = map['orderDishName'];
    orderDishCategory = map['orderDishCategory'];
    orderDishPrice = map['orderDishPrice'];
    orderDishImage = map['orderDishImage'];
    // orderDishIsFav = map['orderDishIsFav'];
    orderQuantity = map['orderQuantity'];
    orderAccepted = map['orderAccepted'];
    orderCompleted = map['orderCompleted'];
    orderCancelled = map['orderCancelled'];
  }
}

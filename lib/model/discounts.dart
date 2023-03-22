import 'dart:io';

class DiscountModel {
  late String discountId;
  late String discountName;
  late String discountImage;
  late String discountDescription;
  late int discountDuration;
  late bool discountUsed;

  DiscountModel({
    required this.discountId,
    required this.discountName,
    required this.discountImage,
    required this.discountDescription,
    required this.discountDuration,
    required this.discountUsed
  });
  Map<String, dynamic> toMap() {
    {
      return {
        'discountId': discountId,
        'discountName': discountName,
        'discountImage': discountImage,
        'discountDescription': discountDescription,
        'discountDuration': discountDuration,
        'discountUsed': discountUsed,
      };
    }
  }

  DiscountModel.fromMap(Map<String, dynamic> map) {
    discountId = map['discountId'];
    discountName = map['discountName'];
    discountImage = map['discountImage'];
    discountDescription = map['discountDescription'];
    discountDuration = map['discountDuration'];
    discountUsed = map['discountUsed'];
  }
}

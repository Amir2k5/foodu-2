import 'dart:io';

class OffersModel {
  late String offerId;
  late String offerName;
  late String offerDescription;
  late int offerDuration;
  late String offerImage;

  OffersModel({
    required this.offerId,
    required this.offerName,
    required this.offerDescription,
    required this.offerDuration,
    required this.offerImage,
  });
  Map<String, dynamic> toMap() {
    {
      return {
        'offerId': offerId,
        'offerName': offerName,
        'offerDescription': offerDescription,
        'offerDuration': offerDuration,
        'offerImage': offerImage,
      };
    }
  }

  OffersModel.fromMap(Map<String, dynamic> map) {
    offerId = map['offerId'];
    offerName = map['offerName'];
    offerDescription = map['offerDescription'];
    offerDuration = map['offerDuration'];
    offerImage = map['offerImage'];
  }
}

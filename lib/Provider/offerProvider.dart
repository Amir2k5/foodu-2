// import 'dart:math';

// import 'package:flutter/cupertino.dart';
// import 'package:resturant/Database/db.dart';
// import 'package:resturant/model/discounts.dart';
// import 'package:resturant/model/offers.dart';

// class OfferProvider with ChangeNotifier {
//   int result = 0;
//   List<OffersModel> _all_offers = [];
//   List<OffersModel> get all_offers => _all_offers;
//   DatabaseHelper db = DatabaseHelper.constructor();
//   Future<int> insertOffer(OffersModel offer) async {
//     result = await db.insertOffer(offer);
//     notifyListeners();
//     return result;
//   }

//   Future updateOffer(OffersModel offer) async {
//     result = await db.updateOffer(offer);
//     notifyListeners();
//     return result;
//   }

//   Future<int> removeOffer(OffersModel offer) async {
//     result = await db.removeOffer(offer);
//     notifyListeners();
//     return result;
//   }

//   Future<List<OffersModel>> getAllOffers() async {
//     _all_offers = await db.getAlloffers();
//     notifyListeners();

//     return _all_offers;
//   }
// }

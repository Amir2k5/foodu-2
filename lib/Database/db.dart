import 'dart:io';

import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:resturant/model/discounts.dart';
import 'package:resturant/model/dish.dart';
import 'package:resturant/model/offers.dart';
import 'package:resturant/model/order.dart';
import 'package:resturant/model/user.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  // creating a new user
  Future<Users> creatUser(
      String uid,
      String username,
      String nickname,
      String dob,
      String email,
      String password,
      String gender,
      String image) async {
    var data = FirebaseFirestore.instance.collection('users').doc(uid);
    final user = Users(
        uid: uid,
        userName: username,
        userNickname: nickname,
        userBirthday: dob,
        userEmail: email,
        userPassword: password,
        userGender: gender,
        userImage: image,
        userData: {'favoriteDishes': [], 'favoriteRestaurants': []});
    final json = user.toMap();
    await data.set(json);
    return user;
  }

  Future<Users?> singleUser(String? email) async {
    try {
      Users user = await FirebaseFirestore.instance
          .collection('users')
          .where('userEmail', isEqualTo: email)
          .snapshots()
          .map((event) {
        return event.docs.map((e) {
          return Users.fromMap(e.data());
        }).singleWhere(
          (element) => element.userEmail == email,
        );
      }).first;
      // var snapshot = await FirebaseFirestore.instance
      //     .collection('users')
      //     .snapshots()
      //     .first;
      // Users user = snapshot.docs
      //     .map((e) => Users.fromMap(e.data()))
      //     .singleWhere((element) => element.userEmail == email);
      return user;
    } catch (e) {
      print("Error: ${e.toString()}");
    }
  }

  Future<List<Users>> getUsers() async => await FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshots) =>
          snapshots.docs.map((doc) => Users.fromMap(doc.data())).toList())
      .firstWhere((element) => true);

////////////////////////////////////////////////////////////////////////////
  // adding a discount

  Future<int> newDiscount(
      String id,
      String discountName,
      File discountImage,
      String discountDescription,
      int discountDuration,
      bool discountUsed) async {
    try {
      Reference reference =
          FirebaseStorage.instance.ref('files/discounts/$discountName');
      final TaskSnapshot snapshot = await reference.putFile(discountImage);
      final downloadURL = await snapshot.ref.getDownloadURL();
      final discount = DiscountModel(
          discountId: id,
          discountName: discountName,
          discountImage: downloadURL,
          discountDescription: discountDescription,
          discountDuration: discountDuration,
          discountUsed: discountUsed);
      final upload = FirebaseFirestore.instance
          .collection('discounts')
          .doc(id)
          .set(discount.toMap());
      return 1;
    } catch (e) {
      return 0;
    }
  }

  //updating discount

  Stream<List<DiscountModel>> getDiscounts() => FirebaseFirestore.instance
      .collection('discounts')
      .where("discountUsed", isEqualTo: false)
      .snapshots()
      .map((snapshots) => snapshots.docs
          .map((doc) => DiscountModel.fromMap(doc.data()))
          .toList());

////////////////////////////////////////////////////////////////////////////////
  // adding a new offer

  Future<int> newOffer(String id, String offerName, File offerImage,
      String offerDescription, int offerDuration) async {
    try {
      Reference reference =
          FirebaseStorage.instance.ref('files/offers/$offerName');
      final TaskSnapshot snapshot = await reference.putFile(offerImage);
      final downloadURL = await snapshot.ref.getDownloadURL();
      final offer = OffersModel(
          offerId: id,
          offerName: offerName,
          offerImage: downloadURL,
          offerDescription: offerDescription,
          offerDuration: offerDuration);
      final upload = FirebaseFirestore.instance
          .collection('offers')
          .doc(id)
          .set(offer.toMap());
      return 1;
    } catch (e) {
      return 0;
    }
  }

//updating offes

  Stream<List<OffersModel>> getOffers() => FirebaseFirestore.instance
      .collection('offers')
      .snapshots()
      .map((snapshots) => snapshots.docs
          .map((doc) => OffersModel.fromMap(doc.data()))
          .toList());

////////////////////////////////////////////////////////////////////////////////

  // adding a dish

  Future<int> newDish(String id, String dishName, File dishImage,
      String dishCategory, int dishPrice) async {
    try {
      Reference reference =
          FirebaseStorage.instance.ref('files/dishes/$dishName');
      final TaskSnapshot snapshot = await reference.putFile(dishImage);
      final downloadURL = await snapshot.ref.getDownloadURL();
      final dish = DishModel(
        dishId: id,
        dishName: dishName,
        dishImage: downloadURL,
        dishCategory: dishCategory,
        dishPrice: dishPrice,
      );
      final upload = FirebaseFirestore.instance
          .collection('dishes')
          .doc(id)
          .set(dish.toMap());
      return 1;
    } catch (e) {
      return 0;
    }
  }

  //updating dishes

  Stream<List<DishModel>> getDishes() => FirebaseFirestore.instance
      .collection('dishes')
      .snapshots()
      .map((snapshots) =>
          snapshots.docs.map((doc) => DishModel.fromMap(doc.data())).toList());
////////////////////////////////////////////////////////////////////////////////

  // adding a dish

  Future<int> newOrder(
      String id,
      String orderUserId,
      String orderDishId,
      String orderDishName,
      String orderDishCategory,
      String orderDishPrice,
      File orderDishImage,
      // bool orderDishIsFav,
      int orderQuantity,
      bool orderAccepted,
      bool orderCompleted,
      bool orderCancelled) async {
    try {
      Reference reference =
          FirebaseStorage.instance.ref('files/orders/${orderDishName}');
      final TaskSnapshot snapshot = await reference.putFile(orderDishImage);
      final downloadURL = await snapshot.ref.getDownloadURL();
      final order = OrdersModel(
          orderId: id,
          orderUserId: orderUserId,
          orderDishId: orderDishId,
          orderDishName: orderDishName,
          orderDishCategory: orderDishCategory,
          orderDishPrice: orderDishPrice,
          orderDishImage: downloadURL,
          // orderDishIsFav: orderDishIsFav,
          orderQuantity: orderQuantity,
          orderAccepted: false,
          orderCompleted: false,
          orderCancelled: false);
      final upload = FirebaseFirestore.instance
          .collection('orders')
          .doc(id)
          .set(order.toMap());
      return 1;
    } catch (e) {
      return 0;
    }
  }

  //updating dishes

  Stream<List<OrdersModel>> getCartOrders(String orderUserId) =>
      FirebaseFirestore.instance
          .collection('orders')
          .where('orderCompleted', isEqualTo: false)
          .where('orderCancelled', isEqualTo: false)
          .where('orderUserId', isEqualTo: orderUserId)
          .snapshots()
          .map((snapshots) => snapshots.docs
              .map((doc) => OrdersModel.fromMap(doc.data()))
              .toList());
  Stream<List<OrdersModel>> getCancelledCartOrders(String orderUserId) =>
      FirebaseFirestore.instance
          .collection('orders')
          .where('orderCancelled', isEqualTo: true)
          .where('orderUserId', isEqualTo: orderUserId)
          .snapshots()
          .map((snapshots) => snapshots.docs
              .map((doc) => OrdersModel.fromMap(doc.data()))
              .toList());
  Stream<List<OrdersModel>> getCompleteCartOrders(String orderUserId) =>
      FirebaseFirestore.instance
          .collection('orders')
          .where('orderCompleted', isEqualTo: true)
          .where('orderUserId', isEqualTo: orderUserId)
          .snapshots()
          .map((snapshots) => snapshots.docs
              .map((doc) => OrdersModel.fromMap(doc.data()))
              .toList());
}

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:resturant/Provider/dishProvider.dart';

import '../../../Database/db.dart';
import '../../../model/dish.dart';

class UpdateDishes extends StatelessWidget {
  int? press;
  late int newPrice;
  var formKey = GlobalKey<FormState>();
  int? a;

  @override
  Widget build(BuildContext context) {
    // var provider = Provider.of<DishProvider>(context, listen: false);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 231, 231, 231),
        appBar: AppBar(
          shadowColor: Colors.transparent,
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          title: Text('Update Dishes'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: StreamBuilder<List<DishModel>>(
            stream: DatabaseService().getDishes(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else {
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('Empty'),
                  );
                } else {
                  List<DishModel> dishes = snapshot.data!;
                  return ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: dishes.length,
                      itemBuilder: (context, index) {
                        // bool isFav = 1 == 1;
                        newPrice = dishes[index].dishPrice;

                        return Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 107, 107, 107),
                                offset: Offset(0, 1.5),
                                blurRadius: 3,
                              )
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(42.73.r),
                          ),
                          margin: EdgeInsets.only(
                              top: 58.h, left: 30.w, right: 30.w),
                          padding: EdgeInsets.only(
                              top: 28.h, bottom: 28.h, left: 15.w, right: 15.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 470.h,
                                width: 440.w,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.green, width: 3),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          dishes[index].dishImage),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              SizedBox(
                                width: 50.w,
                              ),
                              Container(
                                width: 320.w,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 190.h,
                                    ),
                                    Text(
                                      overflow: TextOverflow.ellipsis,
                                      dishes[index].dishName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 65.sp),
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    newPrice != dishes[index].dishPrice
                                        ? Text(
                                            '\$${newPrice}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 65.sp),
                                          )
                                        : Text(
                                            '\$${dishes[index].dishPrice}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 65.sp),
                                          ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 125.w,
                              ),
                              Column(
                                children: [
                                  TextButton.icon(
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                        Colors.green[700],
                                      ),
                                    ),
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection('dishes')
                                          .doc(dishes[index].dishId)
                                          .delete();
                                      await FirebaseStorage.instance
                                          .ref(
                                              'files/dishes/${dishes[index].dishName}')
                                          .delete();
                                      Fluttertoast.showToast(
                                          msg: 'Dish Removed');
                                    },
                                    label: Text('Delete'),
                                    icon: Icon(Icons.delete_outlined),
                                  ),
                                  TextButton.icon(
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                        Colors.green[700],
                                      ),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          content: Form(
                                            key: formKey,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                label: Text('Price'),
                                              ),
                                              initialValue: dishes[index]
                                                  .dishPrice
                                                  .toString(),
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (String? value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please provide Dish Price';
                                                }
                                                newPrice = int.parse(value);
                                                return null;
                                              },
                                            ),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.green[700]),
                                                onPressed: () async {
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    var dish = DishModel(
                                                        dishId: dishes[index]
                                                            .dishId,
                                                        dishName: dishes[index]
                                                            .dishName,
                                                        dishCategory:
                                                            dishes[index]
                                                                .dishCategory,
                                                        dishPrice: newPrice,
                                                        dishImage: dishes[index]
                                                            .dishImage,
                                                        );
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('dishes')
                                                        .doc(dishes[index]
                                                            .dishId)
                                                        .update(dish.toMap());
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            'Dish Price Updated');
                                                    Navigator.pop(
                                                        context, 'done');
                                                  }
                                                },
                                                child: Text('Submit Changes')),
                                          ],
                                        ),
                                      );
                                    },
                                    label: Text('Update'),
                                    icon: Icon(Icons.upgrade),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      });
                }
              }
            },
          ),
        ),
      ),
    );
  }
}

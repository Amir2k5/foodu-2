import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:resturant/model/discounts.dart';

import '../../../Database/db.dart';
import '../../../Provider/discountProvider.dart';

class UpdateDiscounts extends StatelessWidget {
  int? press;
  late int duration;
  var formKey = GlobalKey<FormState>();
  int? a;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 231, 231, 231),
        appBar: AppBar(
          shadowColor: Colors.transparent,
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          title: Text('Update Discounts'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: StreamBuilder<List<DiscountModel>>(
            stream: DatabaseService().getDiscounts(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else {
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('Empty'),
                  );
                } else {
                  List<DiscountModel> discounts = snapshot.data!;
                  return ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: discounts.length,
                      itemBuilder: (context, index) {
                        duration = discounts[index].discountDuration;

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
                              top: 58.h, left: 40.w, right: 40.w),
                          padding: EdgeInsets.only(
                              top: 28.h, bottom: 28.h, left: 20.w, right: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 426.h,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 800.w,
                                          child: Text(
                                            'Discount Dish: ${discounts[index].discountName}',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 65.sp),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    duration !=
                                            discounts[index].discountDuration
                                        ? Text(
                                            'Duration: ${duration}hr',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 65.sp),
                                          )
                                        : Text(
                                            'Duration: ${discounts[index].discountDuration}hr',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 65.sp),
                                          ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 125.h,
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
                                          .collection('discounts')
                                          .doc(discounts[index].discountId)
                                          .delete();
                                      await FirebaseStorage.instance
                                          .ref(
                                              'files/discounts/${discounts[index].discountName}')
                                          .delete();
                                      Fluttertoast.showToast(
                                          msg: 'discount Removed');
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
                                          title: Text('Update Discount'),
                                          content: Form(
                                            key: formKey,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                label: Text('Duration'),
                                              ),
                                              initialValue: discounts[index]
                                                  .discountDuration
                                                  .toString(),
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (String? value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please provide Discount Duration';
                                                }
                                                duration = int.parse(value);
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
                                                  var discount = DiscountModel(
                                                      discountId:
                                                          discounts[index]
                                                              .discountId,
                                                      discountName:
                                                          discounts[index]
                                                              .discountName,
                                                      discountImage:
                                                          discounts[index]
                                                              .discountImage,
                                                      discountDescription:
                                                          discounts[index]
                                                              .discountDescription,
                                                      discountDuration:
                                                          duration,
                                                      discountUsed:
                                                          discounts[index]
                                                              .discountUsed);
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('discounts')
                                                        .doc(discounts[index]
                                                            .discountId)
                                                        .update(
                                                            discount.toMap());
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            'discount Duration Updated');
                                                    Navigator.pop(context);
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

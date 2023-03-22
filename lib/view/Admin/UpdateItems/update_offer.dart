import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:resturant/Provider/offerProvider.dart';
import 'package:resturant/model/offers.dart';
import 'package:resturant/model/offers.dart';

import '../../../Database/db.dart';

class UpdateOffers extends StatelessWidget {
  int? press;
  late int duration;
  var formKey = GlobalKey<FormState>();
  int? a;

  @override
  Widget build(BuildContext context) {
    // var provider = Provider.of<OfferProvider>(context, listen: true);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 231, 231, 231),
        appBar: AppBar(
          shadowColor: Colors.transparent,
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          title: Text('Update Offers'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: StreamBuilder<List<OffersModel>>(
            stream: DatabaseService().getOffers(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else {
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('Empty'),
                  );
                } else {
                  List<OffersModel> offers = snapshot.data!;
                  return ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: offers.length,
                      itemBuilder: (context, index) {
                        duration = offers[index].offerDuration;

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
                                            'Offer: ${offers[index].offerName}',
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
                                    duration != offers[index].offerDuration
                                        ? Text(
                                            'Duration: ${duration}hr',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 65.sp),
                                          )
                                        : Text(
                                            'Duration: ${offers[index].offerDuration}hr',
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
                                          .collection('offers')
                                          .doc(offers[index].offerId)
                                          .delete();
                                      await FirebaseStorage.instance
                                          .ref(
                                              'files/offers/${offers[index].offerName}')
                                          .delete();
                                      Fluttertoast.showToast(
                                          msg: 'offer Removed');
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
                                                label: Text('Duration'),
                                              ),
                                              initialValue: offers[index]
                                                  .offerDuration
                                                  .toString(),
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (String? value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please provide Offer Duration';
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
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    var offer = OffersModel(
                                                        offerId: offers[index]
                                                            .offerId,
                                                        offerName: offers[index]
                                                            .offerName,
                                                        offerDescription: offers[
                                                                index]
                                                            .offerDescription,
                                                        offerDuration: duration,
                                                        offerImage:
                                                            offers[index]
                                                                .offerImage);

                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('offers')
                                                        .doc(offers[index]
                                                            .offerId)
                                                        .update(offer.toMap());
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            'offer Duration Updated');
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

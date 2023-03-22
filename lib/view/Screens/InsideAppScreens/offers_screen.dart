import 'dart:io';
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:resturant/Database/db.dart';
import 'package:resturant/Provider/offerProvider.dart';
import 'package:resturant/model/offers.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  // List<OffersModel> offer;
  // OffersScreen({super.key, required this.offer});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  String? imagePath;
  File? file;
  Uint8List? image;
  Uint8List? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          title: Text('Special Offers')),
      body: Container(
        margin: EdgeInsets.all(40.sp),
        height: 2747.h,
        width: 1400.w,
        child: StreamBuilder(
          stream: DatabaseService().getOffers(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.isEmpty) {
              return Center(
                child: Text('Empty'),
              );
            } else {
              var offers = snapshot.data;

              return ListView.builder(
                  itemCount: offers!.length,
                  itemBuilder: (context, index) {
                    var container = Container(
                      height: 665.h,
                      margin: EdgeInsets.all(20.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.sp),
                        gradient: RadialGradient(
                            colors: [
                              Colors.green.shade700.withOpacity(0.5),
                              Colors.green.shade700
                            ],
                            center: Alignment.center,
                            stops: [0.01, 1]),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '30%',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 100.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 42.h,
                              ),
                              Text(
                                '${offers[index].offerName} \nvalid for ${offers[index].offerDuration}hr !',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 60.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Container(
                            height: 640.h,
                            width: 630.w,
                            alignment: Alignment.bottomCenter,
                            decoration:
                                // offers == null
                                // ? BoxDecoration(color: Colors.transparent)
                                // :
                                BoxDecoration(
                              borderRadius: BorderRadius.circular(60.r),
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    offers[index].offerImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                    if (index % 2 == 0) {
                      return BounceInLeft(
                          duration: Duration(milliseconds: 1200),
                          child: container);
                    } else {
                      return BounceInRight(
                          duration: Duration(milliseconds: 1200),
                          child: container);
                    }
                  });
            }
          },
        ),
      ),
    );
  }
}

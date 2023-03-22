import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:resturant/Database/db.dart';
import 'package:resturant/Provider/offerProvider.dart';
import 'package:resturant/model/offers.dart';

import '../../../model/dish.dart';

class Offers extends StatefulWidget {
  const Offers({super.key});

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  TextEditingController offer_name = TextEditingController();
  TextEditingController offer_description = TextEditingController();
  TextEditingController offer_duration = TextEditingController();
  File? file;
  String? image;
  Future getImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
      image = file!.path;
    });
  }

  bool loading = false;

  // String dish_category = 'Hamburger';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Offer'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(64.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            file == null
                ? Container(
                    height: 850.h,
                    width: 800.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 28.w),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.camera_alt_outlined,
                        size: 100,
                        color: Colors.green[700],
                      ),
                      onPressed: () {
                        getImage();
                      },
                    ),
                  )
                : Container(
                    height: 850.h,
                    width: 800.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 28.w),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: FileImage(file!), fit: BoxFit.cover),
                    ),
                  ),
            SizedBox(
              height: 5.h,
            ),
            Divider(thickness: 12.sp, color: Colors.green[700]),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 105.h),
              child: Form(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Offer:',
                          style: TextStyle(fontSize: 80.sp),
                        ),
                        SizedBox(
                          width: 40.w,
                        ),
                        Expanded(
                            child: TextFormField(
                          controller: offer_name,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 125.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Description:',
                          style: TextStyle(fontSize: 80.sp),
                        ),
                        SizedBox(
                          width: 40.w,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: offer_description,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 128.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Duration:',
                          style: TextStyle(fontSize: 80.sp),
                        ),
                        SizedBox(
                          width: 40.w,
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: offer_duration,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 210.h,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        int result = 0;
                        file != null
                            ? result = await DatabaseService().newOffer(
                                DateTime.now().toString(),
                                offer_name.text,
                                file!,
                                offer_description.text,
                                int.parse(offer_duration.text))
                            : null;
                        if (result > 0) {
                          Fluttertoast.showToast(msg: 'Offer has been Added');
                          offer_name.clear();
                          offer_description.clear();
                          offer_duration.clear();
                          setState(() {
                            file = null;
                            loading = false;
                          });
                        } else {
                          setState(() {
                            loading = false;
                          });
                          Fluttertoast.showToast(
                              msg: 'Offer has not been Added');
                        }
                      },
                      child: loading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text('Add Offer'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          fixedSize: Size(800.w, 170.h)),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}

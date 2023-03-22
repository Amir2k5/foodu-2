import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:resturant/Database/db.dart';
import 'package:resturant/Provider/discountProvider.dart';
import 'package:resturant/Provider/dishProvider.dart';
import 'package:resturant/model/discounts.dart';

import '../../../model/dish.dart';

class Discounts extends StatefulWidget {
  const Discounts({super.key});

  @override
  State<Discounts> createState() => _DiscountsState();
}

class _DiscountsState extends State<Discounts> {
  TextEditingController discount_dish_name = TextEditingController();
  TextEditingController discount_description = TextEditingController();
  TextEditingController discount_duration = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Discount'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        shadowColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.all(64.sp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              file == null
                  ? Container(
                      height: 854.h,
                      width: 800.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 28.w),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt_outlined,
                          size: 400.sp,
                          color: Colors.green[700],
                        ),
                        onPressed: () {
                          getImage();
                        },
                      ),
                    )
                  : Container(
                      height: 854.h,
                      width: 800.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 28.w),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: FileImage(file!), fit: BoxFit.cover),
                      ),
                    ),
              SizedBox(
                height: 85.h,
              ),
              Divider(thickness: 12.sp, color: Colors.green[700]),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 106.h),
                child: Form(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Discount:',
                            style: TextStyle(fontSize: 60.sp),
                          ),
                          SizedBox(
                            width: 40.w,
                          ),
                          Expanded(
                              child: TextFormField(
                            controller: discount_dish_name,
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
                            'Discount Description:',
                            style: TextStyle(fontSize: 60.sp),
                          ),
                          SizedBox(
                            width: 40.w,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: discount_description,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 125.h,
                      ),
                      Row(
                        children: [
                          Text(
                            'Discount Duration',
                            style: TextStyle(fontSize: 60.sp),
                          ),
                          SizedBox(
                            width: 120.w,
                          ),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: discount_duration,
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
                              ? result = await DatabaseService().newDiscount(
                                  DateTime.now().toString(),
                                  discount_dish_name.text.trim(),
                                  file!,
                                  discount_description.text,
                                  int.parse(discount_duration.text),false)
                              : null;
                          if (result > 0) {
                            Fluttertoast.showToast(
                                msg: 'Discount has been Added');
                            discount_description.clear();
                            discount_duration.clear();
                            discount_dish_name.clear();
                            setState(() {
                              loading = false;
                              file = null;
                            });
                          }
                        },
                        child: loading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text('Add Discount'),
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
        ),
      ),
    );
  }
}

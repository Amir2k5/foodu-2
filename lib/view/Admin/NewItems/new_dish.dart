import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:resturant/Database/db.dart';
import 'package:resturant/Provider/dishProvider.dart';

import '../../../model/dish.dart';

class Dishes extends StatefulWidget {
  const Dishes({super.key});

  @override
  State<Dishes> createState() => _DishesState();
}

class _DishesState extends State<Dishes> {
  List<Map> categoryIcons = [
    {'Hamburger': 'assets/images/burger.jpg'},
    {'Pizza': 'assets/images/pizzaicon.jpg'},
    {'Noodles': 'assets/images/noodle.jpg'},
    {'Meat': 'assets/images/meat.jpg'},
    {'Veggies': 'assets/images/lettuce.jpg'},
    {'Dessert': 'assets/images/cake.jpg'},
    {'Drink': 'assets/images/beer.jpg'},
  ];
  TextEditingController dish_name = TextEditingController();
  TextEditingController dish_price = TextEditingController();
  File? file;
  String? image;
  Future getImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
      image = file!.path;
    });
  }

  String dish_category = 'Hamburger';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Dish'),
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
                          'Dish:',
                          style: TextStyle(fontSize: 80.sp),
                        ),
                        SizedBox(
                          width: 40.sp,
                        ),
                        Expanded(
                            child: TextFormField(
                          controller: dish_name,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 128.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Price:',
                          style: TextStyle(fontSize: 80.sp),
                        ),
                        SizedBox(
                          width: 40.w,
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: dish_price,
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
                          'Category:',
                          style: TextStyle(fontSize: 80.sp),
                        ),
                        SizedBox(
                          width: 120.w,
                        ),
                        DropdownButton(
                          isDense: true,
                          iconSize: 120.sp,
                          iconEnabledColor: Colors.green[700],
                          value: dish_category,
                          items: [
                            DropdownMenuItem(
                              child: Row(
                                children: [
                                  Text(categoryIcons[0].keys.first),
                                  SizedBox(
                                    width: 80.w,
                                  ),
                                  Image(
                                    image: AssetImage(
                                        categoryIcons[0].values.first),
                                  ),
                                ],
                              ),
                              value: categoryIcons[0].keys.first.toString(),
                            ),
                            DropdownMenuItem(
                              child: Row(
                                children: [
                                  Text(categoryIcons[1].keys.first),
                                  SizedBox(
                                    width: 260.w,
                                  ),
                                  Image(
                                    image: AssetImage(
                                        categoryIcons[1].values.first),
                                  ),
                                ],
                              ),
                              value: categoryIcons[1].keys.first.toString(),
                            ),
                            DropdownMenuItem(
                              child: Row(
                                children: [
                                  Text(categoryIcons[2].keys.first),
                                  SizedBox(
                                    width: 160.w,
                                  ),
                                  Image(
                                    image: AssetImage(
                                        categoryIcons[2].values.first),
                                  ),
                                ],
                              ),
                              value: categoryIcons[2].keys.first.toString(),
                            ),
                            DropdownMenuItem(
                              child: Row(
                                children: [
                                  Text(categoryIcons[3].keys.first),
                                  SizedBox(
                                    width: 240.w,
                                  ),
                                  Image(
                                    image: AssetImage(
                                        categoryIcons[3].values.first),
                                  ),
                                ],
                              ),
                              value: categoryIcons[3].keys.first.toString(),
                            ),
                            DropdownMenuItem(
                              child: Row(
                                children: [
                                  Text(categoryIcons[4].keys.first),
                                  SizedBox(
                                    width: 140.w,
                                  ),
                                  Image(
                                    image: AssetImage(
                                        categoryIcons[4].values.first),
                                  ),
                                ],
                              ),
                              value: categoryIcons[4].keys.first.toString(),
                            ),
                            DropdownMenuItem(
                              child: Row(
                                children: [
                                  Text(categoryIcons[5].keys.first),
                                  SizedBox(
                                    width: 200.w,
                                  ),
                                  Image(
                                    image: AssetImage(
                                        categoryIcons[5].values.first),
                                  ),
                                ],
                              ),
                              value: categoryIcons[5].keys.first.toString(),
                            ),
                            DropdownMenuItem(
                              child: Row(
                                children: [
                                  Text(categoryIcons[6].keys.first),
                                  SizedBox(
                                    width: 260.w,
                                  ),
                                  Image(
                                    image: AssetImage(
                                        categoryIcons[6].values.first),
                                  ),
                                ],
                              ),
                              value: categoryIcons[6].keys.first.toString(),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              dish_category = value!;
                            });
                          },
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
                            ? result = await DatabaseService().newDish(
                                DateTime.now().toString(),
                                dish_name.text,
                                file!,
                                dish_category,
                                int.parse(dish_price.text),
                                // false
                                )
                            : null;
                        if (result > 0) {
                          Fluttertoast.showToast(msg: 'Dish has been Added');
                          dish_name.clear();
                          dish_price.clear();
                          setState(() {
                            dish_category = 'Hamburger';
                            loading = false;
                            file = null;
                          });
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Dish has not been Added');
                          setState(() {
                            loading = false;
                          });
                        }
                      },
                      child: loading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text('Add Dish'),
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

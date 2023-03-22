import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:resturant/Database/db.dart';
import 'package:resturant/Provider/userProvider.dart';
import 'package:resturant/view/Screens/InsideAppScreens/order_screen.dart';

import '../../../model/dish.dart';
import '../../../model/user.dart';

class DishesScreen extends StatefulWidget {
  List<Map> categoryIcons;
  String title;
  DishesScreen({required this.title, required this.categoryIcons});

  @override
  State<DishesScreen> createState() => _DishesScreenState();
}

class _DishesScreenState extends State<DishesScreen> {
  List filter = ['Filter', 'Sort', 'Promo', 'Self Pick-up'];
  List<Map> filters = [
    {
      'Sort by': ['Recommended', 'Popularity', 'Rating', 'Distance']
    },
    {
      'Restaurant': ['Prome', 'Priority Restaurant', 'Small MSME Restaurant']
    },
    {
      'Delivery Fee': ['Any', 'Less than 2\$', 'Less than 4\$', 'Less than 8\$']
    },
    {
      'Mode': ['Delivery', 'Self Pick-up']
    },
    {
      'Cuisines': [
        'Desert',
        'Beverages',
        'Snack',
        'Chicken',
        'Bakery & Cake',
        'Breakfase',
        'Chinese',
        'Japanese',
        'Fast Food',
        'Noodles',
        'Seafood',
        'Pizza',
        'Pasta',
        'Hamburger',
        'Lunch'
      ]
    }
  ];
  Users? user;
  @override
  void initState() {
    user = Provider.of<UserProvider>(context, listen: false).user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: Text(widget.title),
      ),
      body: widget.title == 'More'
          ? Container(
              margin: EdgeInsets.only(top: 63.h),
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: GridView.builder(
                itemCount: widget.categoryIcons.length - 1,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) => InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DishesScreen(
                        title: widget.categoryIcons[index].keys.first,
                        categoryIcons: widget.categoryIcons),
                  )),
                  child: SizedBox(
                    height: 420.h,
                    width: 400.w,
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage(
                            widget.categoryIcons[index].values.first,
                          ),
                          height: 168.h,
                        ),
                        Text(widget.categoryIcons[index].keys.first)
                      ],
                    ),
                  ),
                ),
              ),
            )
          : Padding(
              padding: EdgeInsets.only(left: 48.w),
              child: Column(
                children: [
                  FadeInRight(
                    duration: const Duration(milliseconds: 700),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 168.h,
                      child: ListView.separated(
                        itemCount: filter.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              shape: const StadiumBorder(),
                              side: BorderSide(
                                  color: Colors.green.shade700, width: 12.w)),
                          onPressed: () {},
                          child: Text(
                            filter[index],
                            style: TextStyle(color: Colors.green[700]),
                          ),
                        ),
                        separatorBuilder: (context, index) => SizedBox(
                          width: 40.w,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    // height: 2645.h,
                    child: StreamBuilder(
                        stream: DatabaseService().getDishes(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            if (snapshot.data!.isEmpty) {
                              return const Center(
                                child: Text('Empty'),
                              );
                            } else {
                              List<DishModel>? dishes = snapshot.data!
                                  .where((element) =>
                                      element.dishCategory == widget.title)
                                  .toList();

                              return ListView.builder(
                                  itemCount: dishes.length,
                                  itemBuilder: (context, index) {
                                    return FadeInUp(
                                      duration:
                                          const Duration(milliseconds: 700),
                                      child: InkWell(
                                        onTap: () async {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => OrderScreen(
                                              dish: dishes[index],
                                            ),
                                          ))
                                              .then((value) {
                                            setState(() {});
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Colors.black,
                                                    blurRadius: 5,
                                                    // spreadRadius: 5,
                                                    offset: Offset(1, 1))
                                              ],
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(63.r)),
                                          margin: EdgeInsets.only(
                                              left: 10.w,
                                              top: 30.h,
                                              right: 40.w,
                                              bottom: 30.h),
                                          padding: EdgeInsets.all(20.sp),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 20.w, right: 60.w),
                                                  height: 555.h,
                                                  width: 520.w,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image:
                                                              CachedNetworkImageProvider(
                                                                  dishes[index]
                                                                      .dishImage),
                                                          fit: BoxFit.cover),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              63.r)),
                                                ),
                                                SizedBox(
                                                  height: 555.h,
                                                  width: 600.w,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        dishes[index].dishName,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 61.sp,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.star,
                                                            color:
                                                                Colors.yellow,
                                                            size: 80.sp,
                                                          ),
                                                          Text(
                                                              '${((Random().nextInt(4) + 1) * 0.9).toStringAsFixed(1)} (${((Random().nextInt(20) + 1) * 0.9).toStringAsFixed(1)}k)'),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              '\$${dishes[index].dishPrice}'),
                                                          user!.userData![
                                                                      'favoriteDishes']!
                                                                  .any((element) =>
                                                                      element ==
                                                                      dishes[index]
                                                                          .dishName)
                                                              ? const Icon(
                                                                  Icons
                                                                      .favorite,
                                                                  color: Colors
                                                                      .red,
                                                                )
                                                              : const Icon(Icons
                                                                  .favorite_outline)
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ]),
                                        ),
                                      ),
                                    );
                                  });
                            }
                          }
                        }),
                  ),
                ],
              ),
            ),
    );
  }
}

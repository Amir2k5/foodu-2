import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant/view/Admin/NewItems/new_discounts.dart';
import 'package:resturant/view/Admin/NewItems/new_dish.dart';
import 'package:resturant/view/Admin/NewItems/new_offer.dart';
import 'package:resturant/view/Admin/NewItems/new_recommends.dart';
import 'package:resturant/view/Admin/UpdateItems/update_discount.dart';
import 'package:resturant/view/Admin/UpdateItems/update_dish.dart';
import 'package:resturant/view/Admin/UpdateItems/update_offer.dart';
import 'package:resturant/view/Admin/UpdateItems/update_recommended.dart';
import 'package:resturant/view/Admin/order.dart';
import 'package:resturant/utils/admin_edit.dart';
import 'package:resturant/utils/divider.dart';
import 'package:resturant/utils/edit.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            title: Text(
              'Admin Home Screen',
            ),
          )
        ],
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 370,
                padding: EdgeInsets.only(left: 40.w, right: 40.w, top: 64.h),
                child: GridView(
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  children: [
                    EditImage('assets/images/pizza.jpg', 'New Dish', context,
                        Dishes()),
                    EditImage('assets/images/offer.jpg', 'New Offer', context,
                        Offers()),
                    EditImage('assets/images/discount.jpg', 'New Discount',
                        context, Discounts()),
                    EditImage('assets/images/recommends.jpg', 'New Recommends',
                        context, Recommends()),
                  ],
                ),
              ),
              Divider(
                thickness: 8.sp,
                color: Colors.grey,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 32.w),
                height: 1570.h,
                child: GridView(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  children: [
                    EditImage('assets/images/pizza.jpg', 'Update Dish', context,
                        UpdateDishes()),
                    EditImage('assets/images/offer.jpg', 'Update Offer',
                        context, UpdateOffers()),
                    EditImage('assets/images/discount.jpg', 'Update Discounts',
                        context, UpdateDiscounts()),
                    EditImage('assets/images/recommends.jpg',
                        'Update Recommends', context, UpdateRecommends())
                  ],
                ),
              ),
              Divider(
                thickness: 8.sp,
                color: Colors.grey,
              ),
              InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Orders(),
                )),
                child: Container(
                  width: 1320.w,
                  margin: EdgeInsets.all(28.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(42.r),
                    color: Color.fromARGB(255, 238, 238, 238),
                    boxShadow: [BoxShadow(color: Colors.black, blurRadius: 3)],
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 21.h),
                          height: 555.h,
                          width: 1240.w,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/order.jpg'),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(63.r)),
                        ),
                        Text(
                          'Orders',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 60.sp,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

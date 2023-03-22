import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteRestaurant extends StatefulWidget {
  const FavoriteRestaurant({super.key});

  @override
  State<FavoriteRestaurant> createState() => _FavoriteRestaurantState();
}

class _FavoriteRestaurantState extends State<FavoriteRestaurant> {
  List restaurant_images = ['restaurant1', 'restaurant2', 'restaurant3'];
  List restaurant_names = [
    'The Breakfast Club',
    "Caustard's Last Stand",
    'Planet of the Salad'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Text('My Favorite Restaurants'),
      ),
      body: ListView.builder(
        itemCount: restaurant_images.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black, blurRadius: 5, offset: Offset(1, 1))
            ], color: Colors.white, borderRadius: BorderRadius.circular(63.r)),
            margin: EdgeInsets.only(top: 42.h, right: 40.w),
            padding: EdgeInsets.all(20.sp),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                margin: EdgeInsets.only(left: 20.w, right: 80.w),
                height: 555.h,
                width: 520.w,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/${restaurant_images[index]}.jpg',
                        ),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(63.r)),
              ),
              Container(
                height: 555.h,
                width: 600.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      restaurant_names[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 68.sp,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 80.sp,
                        ),
                        Text('4.6 (1.4k)',
                            style: TextStyle(
                                color: Color.fromARGB(255, 109, 109, 109)))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            child: Row(
                          children: [
                            Icon(
                              Icons.pedal_bike,
                              color: Colors.green[700],
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Text(
                              '\$2.00',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 109, 109, 109)),
                            )
                          ],
                        )),
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      ],
                    )
                  ],
                ),
              )
            ]),
          );
        },
      ),
    );
  }
}

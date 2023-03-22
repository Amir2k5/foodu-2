import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:resturant/utils/intro_images.dart';
import 'package:resturant/utils/lorem.dart';

import '../../../Provider/increment.dart';
import '../Authenticate/signupScreen.dart';

class Intro4 extends StatefulWidget {
  const Intro4({super.key});

  @override
  State<Intro4> createState() => _Intro4State();
}

class _Intro4State extends State<Intro4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        introImage('assets/images/delivery.jpg'),
        Text(
          'Fast Delivery',
          style: TextStyle(
              color: Colors.green[700],
              fontSize: 40,
              wordSpacing: 5,
              fontWeight: FontWeight.bold),
        ),
        loremText(Colors.black),
        Container(
          margin: EdgeInsets.only(bottom: 106.h),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              width: 40.w,
              height: 33.h,
              decoration:
                  BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
            ),
            Container(
              width: 40.w,
              height: 33.h,
              decoration:
                  BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
            ),
            Container(
              width: 120.w,
              height: 33.h,
              decoration: BoxDecoration(
                  color: Colors.green[700],
                  borderRadius: BorderRadius.circular(21.r)),
            ),
          ]),
        ),
        Consumer<IncrementProvider>(
          builder: (context, value, child) => ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => SignUpPage(),
              ));
            },
            child: Text('Get Started'),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                fixedSize: Size(1200.w, 168.h),
                shape: StadiumBorder()),
          ),
        )
      ]),
    );
    ;
  }
}

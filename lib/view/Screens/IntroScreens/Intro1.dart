import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant/utils/lorem.dart';

class Intro1 extends StatelessWidget {
  const Intro1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeInUp(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/pizza.jpg'),
                fit: BoxFit.cover),
          ),
          child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.01, 1],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Welcome To \nFoodu!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.green[700],
                        fontSize: 140.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  loremText(Colors.white)
                ],
              )),
        ),
      ),
    );
  }
}

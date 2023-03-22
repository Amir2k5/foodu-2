import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/view/Screens/IntroScreens/Intro1.dart';

import '../../../Provider/increment.dart';
import 'Intro2.dart';
import 'Intro3.dart';
import 'Intro4.dart';

class IntroScreen extends StatelessWidget {
  List pages = [
    Intro1(),
    Intro2(),
    Intro3(),
    Intro4(),
  ];
  // var current_page_view = 0.0;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<IncrementProvider>(context).controller;
    return PageView.builder(
        controller: controller,
        itemCount: pages.length,
        itemBuilder: (context, index) {
          return pages[index];
        });
  }
}

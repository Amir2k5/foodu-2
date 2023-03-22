import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:resturant/Database/db.dart';
import 'package:resturant/Home/home.dart';
import 'package:resturant/Provider/userProvider.dart';
import 'package:resturant/view/Screens/AccountSetup/auth_sevice.dart';
import 'package:resturant/view/Screens/Authenticate/signupScreen.dart';
import 'package:resturant/view/Screens/IntroScreens/Intro.dart';

import '../../../model/user.dart';

class SplashScreen extends StatefulWidget {
  // final Users user;
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isNew = false;
  bool isLoged = false;
  String? email;
  Users? user;

  Future<Users?> getInfo() async {
    isNew = await Provider.of<UserProvider>(context, listen: false)
        .getPrefNewUser();
    isLoged =
        await Provider.of<UserProvider>(context, listen: false).getPrefLoged();
    email =
        await Provider.of<UserProvider>(context, listen: false).getPrefEmail();
    if (isLoged) {
      user = await DatabaseService().singleUser(email);
      Provider.of<UserProvider>(context,listen: false).user = user;
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
          );
        } else {
          if (isLoged) {
            return Home(user: snapshot.data!);
          } else {
            return isNew ? IntroScreen() : const SignUpPage();
          }
        }
      },
    );
  }
}

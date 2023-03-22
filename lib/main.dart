import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:resturant/Database/db.dart';
import 'package:resturant/Home/home.dart';
import 'package:resturant/Provider/cartProivder.dart';
import 'package:resturant/Provider/discountProvider.dart';
import 'package:resturant/Provider/dishProvider.dart';
import 'package:resturant/Provider/offerProvider.dart';
import 'package:resturant/Provider/orderProvider.dart';
import 'package:resturant/Provider/userProvider.dart';
import 'package:resturant/view/Screens/AccountSetup/auth_sevice.dart';
import 'package:resturant/view/Screens/SplashScreen/SplashScreen.dart';
import 'package:resturant/model/user.dart';

import 'Provider/increment.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   Stripe.publishableKey =
      '';
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(

      designSize: Size(1440, 3040),
      builder: (BuildContext context, Widget? child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => UserProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => IncrementProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => CartProvider(),
            )
          ],
          child: MaterialApp(
            theme: ThemeData(
              colorScheme: ThemeData().colorScheme.copyWith(
                    secondary: Colors.red,
                  ),
            ),
            home: SplashScreen(),
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}

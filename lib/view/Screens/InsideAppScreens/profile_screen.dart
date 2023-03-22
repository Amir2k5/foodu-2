import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:resturant/Database/db.dart';
import 'package:resturant/view/Admin/admin_home.dart';
import 'package:resturant/Provider/userProvider.dart';
import 'package:resturant/view/Screens/AccountSetup/auth_sevice.dart';
import 'package:resturant/view/Screens/AccountSetup/setupScreen.dart';
import 'package:resturant/view/Screens/Authenticate/loginScreen.dart';
import 'package:resturant/view/Screens/InsideAppScreens/homeScreen.dart';
import 'package:resturant/view/Screens/InsideAppScreens/notification_screen.dart';
import 'package:resturant/view/Screens/InsideAppScreens/offers_screen.dart';
import 'package:resturant/view/Screens/SettingsScreens/address.dart';
import 'package:resturant/view/Screens/SettingsScreens/fav_restaurants.dart';
import 'package:resturant/view/Screens/SettingsScreens/help_center.dart';
import 'package:resturant/view/Screens/SettingsScreens/invite_friends.dart';
import 'package:resturant/view/Screens/SettingsScreens/language.dart';
import 'package:resturant/view/Screens/SettingsScreens/payment.dart';
import 'package:resturant/view/Screens/SettingsScreens/security.dart';
import 'package:resturant/utils/profile_pic.dart';

import '../../../model/user.dart';
import '../AccountSetup/update_account.dart';

class ProfileScreen extends StatefulWidget {
  Users? user;

  ProfileScreen({required this.user});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? email;

  // User? user;
  Future getUser() async {
    email =
        await Provider.of<UserProvider>(context, listen: false).getPrefEmail();
    setState(() {});
    // user = await DatabaseHelper.constructor().getSingleUser(email!);
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    getUser();

    // Future.delayed(
    //   Duration(seconds: 2),
    //   () => setState(() {}),
    // );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, IconData>> quickSettings = [
      {'My Favorite Restaurants': Icons.restaurant},
      // {'Special Offers & Promo ': Icons.local_offer_outlined},
      {'Payment Methods        ': Icons.payment},
      {'Admin Panel': Icons.admin_panel_settings_outlined}
    ];
    List<Map<String, IconData>> normalSettings = [
      {'Profile': Icons.person_outline},
      {'Address': Icons.location_on_outlined},
      {'Notifications': Icons.notifications_active_outlined},
      {'Security': Icons.security},
      {'Language': Icons.language},
      {'Dark Mode': Icons.remove_red_eye_outlined},
      {'Help Center': Icons.help},
      {'Invite Friends': Icons.people_alt_outlined},
      {'Logout': Icons.logout}
    ];
    List quickSettingsScreens = [
      const FavoriteRestaurant(),
      const PaymentScreen(),
      const AdminHome()
    ];
    List normalSettingsScreens = [
      UpdateAccount(user: widget.user),
      const AddressScreen(),
      const NotificationScreen(),
      const SecurityScreen(),
      const LanguageScreen(),
      ProfileScreen(user: widget.user),
      const HelpScreen(),
      const InviteScreen(),
      LoginPage()
      // ProfileScreen(user: widget.user)
    ];
    return Drawer(
      width: double.infinity,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(40.sp),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/logo.jpg',
                      height: 126.h,
                      width: 120.w,
                    ),
                    SizedBox(
                      width: 80.w,
                    ),
                    Text(
                      'Profile',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 76.sp),
                    ),
                    SizedBox(
                      width: 720.w,
                    ),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.more_horiz))
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 295.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      profilePicture(widget.user!),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            widget.user!.userName!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 72.sp),
                          ),
                          Text(widget.user!.userEmail!)
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                UpdateAccount(user: widget.user),
                          ));
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.green[700],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 42.h, bottom: 21.h),
                  height: 21.h,
                  child: Divider(
                    thickness: 8.sp,
                  ),
                ),
                Container(
                  height: 341.h,
                  child: ListView.builder(
                    itemCount: widget.user != null
                        ? widget.user!.userEmail == 'saad@gmail.com'
                            ? quickSettings.length
                            : quickSettings.length - 1
                        : quickSettings.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => quickSettingsScreens[index],
                        ),
                      ),
                      child: Container(
                        height: 168.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(quickSettings[index].values.first),
                            Text(
                              quickSettings[index].keys.first,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 240.w,
                            ),
                            const Icon(Icons.chevron_right)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20.h,
                  child: Divider(thickness: 8.sp),
                ),
                Container(
                  height: 1535.h,
                  child: ListView.builder(
                    physics: const ScrollPhysics(),
                    itemCount: normalSettings.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        normalSettings[index].keys.first == 'Logout'
                            ? {
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .setPrefLoged(false),
                                _auth.signOut(),
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) =>
                                      normalSettingsScreens[index],
                                ))
                              }
                            : normalSettings[index].keys.first == 'Language' &&
                                    normalSettings[index].keys.first ==
                                        'Dark Mode'
                                ? null
                                : Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        normalSettingsScreens[index],
                                  ));
                      },
                      child: Container(
                        height: 164.h,
                        child: normalSettings[index].keys.first != 'Language' &&
                                normalSettings[index].keys.first != 'Dark Mode'
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(normalSettings[index].values.first),
                                  Text(
                                    normalSettings[index].keys.first,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 520.w,
                                  ),
                                  const Icon(Icons.chevron_right)
                                ],
                              )
                            : normalSettings[index].keys.first == 'Language'
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(normalSettings[index].values.first),
                                      Text(
                                        normalSettings[index].keys.first,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 120.w,
                                      ),
                                      const Text('English (US)'),
                                      const Icon(Icons.chevron_right)
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(normalSettings[index].values.first),
                                      Text(
                                        normalSettings[index].keys.first,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 480.w,
                                      ),
                                      Switch(
                                        value: false,
                                        onChanged: (value) {},
                                      )
                                    ],
                                  ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

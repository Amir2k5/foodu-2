import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/Database/db.dart';
import 'package:resturant/Provider/userProvider.dart';
import 'package:resturant/view/Screens/InsideAppScreens/homeScreen.dart';
import 'package:resturant/view/Screens/InsideAppScreens/message_screen.dart';
import 'package:resturant/view/Screens/InsideAppScreens/order_screen.dart';
import 'package:resturant/view/Screens/InsideAppScreens/profile_screen.dart';
import 'package:resturant/view/Screens/InsideAppScreens/wallet_screen.dart';
import 'package:resturant/utils/alertDialog.dart';
import 'package:resturant/model/user.dart';

import '../view/Screens/InsideAppScreens/all_order_screen.dart';

class Home extends StatefulWidget {
  Users user;
  Home({super.key, required this.user});
  // Users user;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int current_screen = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> screen = [
      HomeScreen(
        user: widget.user,
      ),
      AllOrderScreen(user: widget.user),
      MessageScreen(),
      WalletScreen(),
      ProfileScreen(
        user: widget.user,
      )
    ];
    return WillPopScope(
      onWillPop: () async {
        var shouldPop = false;
        if (current_screen != 0) {
          shouldPop = false;
          current_screen = 0;
          setState(() {});
        } else {
          shouldPop = (await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Exit"),
                content: const Text('Are you sure you want to exit the app?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: const Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text(
                      'No',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              );
            },
          ))!;
        }
        return shouldPop;
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 231, 231, 231),
        body: IndexedStack(
          index: current_screen,
          children: screen,
        ),
        bottomNavigationBar: BottomNavigationBar(
            onTap: (index) => setState(() {
                  current_screen = index;
                }),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: Colors.green[700],
            unselectedItemColor: Colors.grey,
            currentIndex: current_screen,
            backgroundColor: Colors.white,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list_alt), label: 'Orders'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.message_outlined), label: 'Message'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.wallet_outlined), label: 'E-Wallet'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline), label: 'Profile')
            ]),
      ),
    );
  }
}

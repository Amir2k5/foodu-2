import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant/Database/db.dart';
import 'package:resturant/model/user.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List<Users> users = [];
  Future getUsers() async {
    // List<Users> _currentEntries =await DatabaseService().getUsers();

    // _currentEntries.listen((listOfUsers) {
    //   for (Users user in listOfUsers) {
    //     users.add(user);
    //   }
    // });
    users = await DatabaseService().getUsers();
    setState(() {});
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text('Chats'),
        leading: Container(
          padding: EdgeInsets.only(left: 13, top: 13, bottom: 13, right: 13),
          child: Image(
            image: AssetImage(
              'assets/images/logo.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 40.w,
                ),
                CircleAvatar(
                    radius: 126.r,
                    backgroundImage:
                        CachedNetworkImageProvider(users[index].userImage!)),
                SizedBox(
                  width: 60.w,
                ),
                SizedBox(
                  width: 560.w,
                  height: 210.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        users[index].userName!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 65.sp),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "I'll be there in 2 mins.",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 21.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 108.w,
                ),
                SizedBox(
                  width: 400.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.green[700],
                        radius: 42.r,
                        child: Text(
                          '1',
                          style:
                              TextStyle(color: Colors.white, fontSize: 48.sp),
                        ),
                      ),
                      SizedBox(
                        height: 42.h,
                      ),
                      Text(
                        '2/8/2022',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 21.h,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

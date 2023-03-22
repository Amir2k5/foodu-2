import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text('E-Wallet'),
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
      body: Padding(
        padding: EdgeInsets.all(40.sp),
        child: Column(
          children: [
            Container(
              height: 725.h,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/ecard.jpg'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(84.r)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transaction History',
                  style:
                      TextStyle(fontSize: 72.sp, fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.green[700]),
                    child: Text('See All'))
              ],
            ),
            Container(
              height: 1280.h,
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Card(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CircleAvatar(
                            radius: 100.r,
                            backgroundImage:
                                AssetImage('assets/images/pizza.jpg')),
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
                                'Pizza',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 64.sp),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                "Dec 15, 2022 | 16:00 PM",
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
                          width: 68.w,
                        ),
                        SizedBox(
                          width: 400.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$${10 * (index + 1)}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 72.sp),
                              ),
                              SizedBox(
                                height: 42.h,
                              ),
                              Text(
                                'Orders',
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
            )
          ],
        ),
      ),
    );
  }
}

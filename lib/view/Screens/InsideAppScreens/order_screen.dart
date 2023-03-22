import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:resturant/Provider/cartProivder.dart';
import 'package:resturant/Provider/dishProvider.dart';
import 'package:resturant/Provider/userProvider.dart';
import 'package:resturant/utils/payments.dart';
import 'package:resturant/utils/spinkit.dart';
import 'package:resturant/model/dish.dart';
import 'package:resturant/model/order.dart';
import 'package:http/http.dart' as http;
import '../../../Database/db.dart';
import '../../../model/user.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({super.key, required this.dish});
  DishModel dish;
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<OrdersModel> orders = [];
  // String? orderUserId;
  bool isFav = false;
  Users? user;
  @override
  void initState() {
    user = Provider.of<UserProvider>(context, listen: false).user;
    super.initState();
    Stream<List<OrdersModel>> _currentEntries =
        DatabaseService().getCartOrders(user!.uid);

    _currentEntries.listen((listOfOrders) {
      for (OrdersModel order in listOfOrders) {
        orders.add(order);
      }
    });
    isFav = user!.userData!['favoriteDishes']!.contains(widget.dish.dishName);
  }

  int num_of_dishes = 1;
  int price = 0;
  static int? a;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () async {
                setState(() {
                  isFav = !isFav;
                });
                Fluttertoast.showToast(
                  msg:
                      isFav ? "Added to favourites" : "Removed from favourites",
                  backgroundColor: Colors.green.shade700,
                  textColor: Colors.white,
                );
                user!.userData!['favoriteDishes']!
                        .contains(widget.dish.dishName)
                    ? user!.userData!['favoriteDishes']!
                        .remove(widget.dish.dishName)
                    : user!.userData!['favoriteDishes']!
                        .add(widget.dish.dishName);
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(user!.uid)
                    .update(user!.toMap());
                Provider.of<UserProvider>(context, listen: false).getUser();
              },
              icon: isFav
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : const Icon(Icons.favorite_outline),
            ),
            // }),
            IconButton(onPressed: () {}, icon: const Icon(Icons.send_outlined))
          ],
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: widget.dish.dishImage,
                errorWidget: (context, url, error) {
                  return Text("Error Accored: $error");
                },
                height: 1280.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 42.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.dish.dishName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 88.sp),
                        ),
                        const Icon(Icons.chevron_right)
                      ],
                    ),
                    Divider(
                      thickness: 8.sp,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 235, 212, 7),
                        ),
                        SizedBox(
                          width: 40.w,
                        ),
                        Expanded(
                          child: Text(
                              '${((Random().nextInt(4) + 1) * 0.9).toStringAsFixed(1)} (${((Random().nextInt(20) + 1) * 0.9).toStringAsFixed(1)}k)'),
                        ),
                        const Icon(Icons.chevron_right)
                      ],
                    ),
                    Divider(
                      thickness: 8.sp,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.green[700],
                        ),
                        SizedBox(
                          width: 40.w,
                        ),
                        Column(
                          children: [
                            const Text(
                              '2.5 km',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 21.h,
                            ),
                            const Text('Delivery Now: \$2.0'),
                          ],
                        ),
                        Expanded(child: Container()),
                        const Icon(Icons.chevron_right)
                      ],
                    ),
                    Divider(
                      thickness: 8.sp,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            setState(() {
                              num_of_dishes == 1 ? null : num_of_dishes--;
                            });
                          },
                          style: OutlinedButton.styleFrom(
                              fixedSize: Size(160.w, 168.h),
                              foregroundColor: Colors.green[700],
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                color: Colors.green,
                              )),
                          child: const Center(
                            child: Icon(
                              Icons.remove,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 80.w,
                        ),
                        Text(
                          num_of_dishes.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 80.sp),
                        ),
                        SizedBox(
                          width: 80.w,
                        ),
                        OutlinedButton(
                            onPressed: () {
                              setState(() {
                                num_of_dishes++;
                              });
                            },
                            style: OutlinedButton.styleFrom(
                                fixedSize: Size(160.w, 168.h),
                                foregroundColor: Colors.green[700],
                                backgroundColor: Colors.white,
                                side: const BorderSide(
                                  color: Colors.green,
                                )),
                            child: const Center(child: Icon(Icons.add))),
                      ],
                    ),
                    SizedBox(
                      height: 63.h,
                    ),
                    TextField(
                      maxLines: 3,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromARGB(255, 240, 240, 240),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(63.r)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(63.r),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        constraints: const BoxConstraints(),
                      ),
                    ),
                    SizedBox(
                      height: 126.h,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          final response =
                              await http.get(Uri.parse(widget.dish.dishImage));

                          final documentDirectory =
                              await getApplicationDocumentsDirectory();

                          final file =
                              File((documentDirectory.path + 'imagetest.jpg'));
                          file.writeAsBytesSync(response.bodyBytes);

                          int result = 0;
                          final paymentDone = await StripePayment().makePayment(
                              "${widget.dish.dishPrice*100 * num_of_dishes}");
                          if (orders.isEmpty && paymentDone) {
                            await DatabaseService().newOrder(
                                DateTime.now().toString(),
                                user!.uid,
                                widget.dish.dishId,
                                widget.dish.dishName,
                                widget.dish.dishCategory,
                                widget.dish.dishPrice.toString(),
                                file,
                                num_of_dishes,
                                false,
                                false,
                                false);
                            Fluttertoast.showToast(
                                msg: 'Your Order Has Been Place.');
                            Provider.of<CartProvider>(context, listen: false)
                                .addCounter();
                            // Navigator.of(context).pop();
                            setState(() {
                              loading = false;
                            });
                          } else if (orders.isNotEmpty && paymentDone) {
                            for (var i = 0; i < orders.length; i++) {
                              if (orders[i].orderDishName ==
                                  widget.dish.dishName) {
                                var updateOrder = OrdersModel(
                                    orderId: orders[i].orderId,
                                    orderUserId: user!.uid,
                                    orderDishName: orders[i].orderDishName,
                                    orderDishId: orders[i].orderDishId,
                                    orderDishImage: orders[i].orderDishImage,
                                    // orderDishIsFav: orders[i].orderDishIsFav,
                                    orderDishPrice: orders[i].orderDishPrice,
                                    orderDishCategory:
                                        orders[i].orderDishCategory,
                                    orderQuantity:
                                        num_of_dishes + orders[i].orderQuantity,
                                    orderCancelled: false,
                                    orderAccepted: false,
                                    orderCompleted: false);
                                await FirebaseFirestore.instance
                                    .collection('orders')
                                    .doc(orders[i].orderId)
                                    .update(updateOrder.toMap());
                                Fluttertoast.showToast(
                                    msg: 'Your Order Has Been Place.');
                                Provider.of<CartProvider>(context,
                                        listen: false)
                                    .addCounter();
                                // Navigator.of(context).pop();
                                setState(() {
                                  loading = false;
                                });
                                result = 1;
                                break;
                              }
                            }
                            if (result != 1) {
                              await DatabaseService().newOrder(
                                  DateTime.now().toString(),
                                  user!.uid,
                                  widget.dish.dishId,
                                  widget.dish.dishName,
                                  widget.dish.dishCategory,
                                  widget.dish.dishPrice.toString(),
                                  file,
                                  // widget.dish.isFav,
                                  num_of_dishes,
                                  false,
                                  false,
                                  false);
                              Fluttertoast.showToast(
                                  msg: 'Your Order Has Been Place.');
                              Provider.of<CartProvider>(context, listen: false)
                                  .addCounter();
                              // Navigator.of(context).pop();
                              setState(() {
                                loading = false;
                              });
                            }
                          } else {
                            setState(() {
                              loading = false;
                            });
                            Fluttertoast.showToast(
                                msg: "Order couldn't be placed. Try again");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(1160.w, 168.h),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green[700],
                            shape: const StadiumBorder()),
                        child: loading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Add To Cart  -  \$${widget.dish.dishPrice * num_of_dishes}'))
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

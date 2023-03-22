import 'dart:io';
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant/Database/db.dart';
import 'package:resturant/view/Screens/InsideAppScreens/all_discounts_screen.dart';
import 'package:resturant/view/Screens/InsideAppScreens/dishes_screen.dart';
import 'package:resturant/view/Screens/InsideAppScreens/mycart_screen.dart';
import 'package:resturant/view/Screens/InsideAppScreens/notification_screen.dart';
import 'package:resturant/view/Screens/InsideAppScreens/offers_screen.dart';
import 'package:resturant/view/Screens/InsideAppScreens/profile_screen.dart';
import 'package:resturant/utils/profile_pic.dart';
import 'package:resturant/model/discounts.dart';
import 'package:resturant/model/dish.dart';
import 'package:resturant/model/offers.dart';

import '../../../model/user.dart';
import 'order_screen.dart';

class HomeScreen extends StatefulWidget {
  Users user;

  HomeScreen({required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _focusNode = FocusNode();
  List<DishModel> searchResult = [];
  String? imagePath;
  File? file;
  Uint8List? image;
  Uint8List? imageFile;
  List<Map> categoryIcons = [
    {'Hamburger': 'assets/images/burger.jpg'},
    {'Pizza': 'assets/images/pizzaicon.jpg'},
    {'Noodles': 'assets/images/noodle.jpg'},
    {'Meat': 'assets/images/meat.jpg'},
    {'Veggies': 'assets/images/lettuce.jpg'},
    {'Dessert': 'assets/images/cake.jpg'},
    {'Drink': 'assets/images/beer.jpg'},
    {'Bread': 'assets/images/bread.jpg'},
    {'Croissant': 'assets/images/croissant.jpg'},
    {'Pancakes': 'assets/images/pancake.jpg'},
    {'Cheese': 'assets/images/cheese.jpg'},
    {'French Fries': 'assets/images/fries.jpg'},
    {'Sandwich': 'assets/images/sandwich.jpg'},
    {'Taco': 'assets/images/taco.jpg'},
    {'Salad': 'assets/images/salad.jpg'},
    {'Bento': 'assets/images/bento.jpg'},
    {'Cooked Rice': 'assets/images/rice.jpg'},
    {'Spagehtti': 'assets/images/spagetti.jpg'},
    {'Sushi': 'assets/images/sushi.jpg'},
    {'Ice Cream': 'assets/images/icecream.jpg'},
    {'Cookies': 'assets/images/cookies.jpg'},
    {'Beverage': 'assets/images/beverage.jpg'},
    {'More': 'assets/images/pie.jpg'},
  ];
  double index = 0;
  List<OffersModel> offers = [];
  List<DiscountModel> discounts = [];
  List<DishModel> allDishes = [];
  List<DishModel> discountDishes = [];
  String deliveryLocation = 'Times Square';
  final textFieldController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future getAllDishes() async {
    allDishes = await DatabaseService().getDishes().first;
    setState(() {});
  }

  @override
  void initState() {
    getAllDishes();
    textFieldController.addListener(() {
      searchResult.clear();
      allDishes.forEach((element) {
        if (element.dishName
            .toLowerCase()
            .contains(textFieldController.text.toLowerCase())) {
          searchResult.add(element);
        }
      });
      setState(() {});

      print(searchResult.length);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  _focusNode.hasFocus
                      ? AppBar(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        )
                      : AppBar(
                          shadowColor: Colors.transparent,
                          backgroundColor: Colors.transparent,
                          leading: InkWell(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProfileScreen(user: widget.user),
                              ),
                            ),
                            child: profilePicture(widget.user),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Deliver to',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 60.sp),
                              ),
                              dropDownMenu()
                            ],
                          ),
                          actions: [
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey)),
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          const NotificationScreen(),
                                    ));
                                  },
                                  icon: Icon(
                                    Icons.notifications_active_outlined,
                                    color: Colors.black,
                                    size: 100.sp,
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 40.w, right: 40.w),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey)),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const CartScreen(),
                                  ));
                                },
                                icon: Icon(
                                  Icons.shopping_bag_outlined,
                                  color: Colors.black,
                                  size: 100.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                  FadeInDown(
                    duration: const Duration(milliseconds: 1000),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60.w),
                      child: Column(
                        children: [
                          AnimatedContainer(
                            curve: Curves.easeInBack,
                            duration: const Duration(milliseconds: 500),
                            padding: _focusNode.hasFocus
                                ? EdgeInsets.only(top: kToolbarHeight - 50.h)
                                : EdgeInsets.only(top: 480.h),
                            child: TextField(
                              controller: textFieldController,
                              focusNode: _focusNode,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.grey[500],
                                ),
                                constraints: const BoxConstraints(),
                                contentPadding: EdgeInsets.zero,
                                hintText: 'What are you carving?',
                                hintStyle: TextStyle(color: Colors.grey[500]),
                                filled: true,
                                fillColor: Colors.grey[200],
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(63.r),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(63.r),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent)),
                              ),
                              onTap: () {
                                setState(() {});
                              },
                              onSubmitted: (value) {
                                setState(() {});
                                _focusNode.unfocus();
                              },
                            ),
                          ),
                          if (textFieldController.text.isEmpty) ...[
                            eventHeader('Special Offers'),
                            carouselSlider(),
                            Container(
                              margin: EdgeInsets.only(top: 63.h),
                              height: 597.h,
                              width: double.infinity,
                              child: GridView.builder(
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 1.3,
                                        // mainAxisSpacing: 10,
                                        crossAxisCount: 4),
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () => Navigator.of(context)
                                      .push(MaterialPageRoute(
                                    builder: (context) => DishesScreen(
                                      title: index == 7
                                          ? categoryIcons.last.keys.first
                                          : categoryIcons[index].keys.first,
                                      categoryIcons: categoryIcons,
                                    ),
                                  )),
                                  child: Column(
                                    children: [
                                      Image(
                                        image: AssetImage(
                                          index == 7
                                              ? categoryIcons.last.values.first
                                              : categoryIcons[index]
                                                  .values
                                                  .first,
                                        ),
                                        height: 168.h,
                                      ),
                                      Text(index == 7
                                          ? categoryIcons.last.keys.first
                                          : categoryIcons[index].keys.first)
                                    ],
                                  ),
                                ),
                                itemCount: 8,
                              ),
                            ),
                            eventHeader('Discount Guaranteed!'),
                            discountSlider(),
                            SizedBox(
                              height: 42.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Recommended For You',
                                  style: TextStyle(
                                      fontSize: 80.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => DishesScreen(
                                          title: 'Recommended For You',
                                          categoryIcons: categoryIcons),
                                    ));
                                  },
                                  child: Text(
                                    'See All',
                                    style: TextStyle(
                                        color: Colors.green[700],
                                        fontSize: 61.sp),
                                  ),
                                ),
                              ],
                            )
                          ] else ...[
                            searchResult.isEmpty
                                ? Container(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.only(bottom: 800.h),
                                    child: Image.asset(
                                        'assets/images/noresult.jpg'),
                                  )
                                : SizedBox(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: searchResult.length,
                                        itemBuilder: (context, index) {
                                          return FadeInUp(
                                            duration: const Duration(
                                                milliseconds: 700),
                                            child: InkWell(
                                              onTap: () async {
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      OrderScreen(
                                                    dish: searchResult[index],
                                                  ),
                                                ))
                                                    .then((value) {
                                                  FocusManager
                                                      .instance.primaryFocus!
                                                      .unfocus();
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    boxShadow: const [
                                                      BoxShadow(
                                                          color: Colors.black,
                                                          blurRadius: 5,
                                                          // spreadRadius: 5,
                                                          offset: Offset(1, 1))
                                                    ],
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            63.r)),
                                                margin: EdgeInsets.only(
                                                    top: 42.h, right: 40.w),
                                                padding: EdgeInsets.all(20.sp),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 20.w,
                                                            right: 60.w),
                                                        height: 555.h,
                                                        width: 520.w,
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                image: CachedNetworkImageProvider(
                                                                    searchResult[
                                                                            index]
                                                                        .dishImage),
                                                                fit: BoxFit
                                                                    .cover),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        63.r)),
                                                      ),
                                                      SizedBox(
                                                        height: 555.h,
                                                        width: 600.w,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Text(
                                                              searchResult[
                                                                      index]
                                                                  .dishName,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 61.sp,
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                      .yellow,
                                                                  size: 80.sp,
                                                                ),
                                                                const Text(
                                                                    '4.6 (1.4k)')
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                    '\$${searchResult[index].dishPrice}'),
                                                                // !searchResult[
                                                                //             index]
                                                                //         .isFav
                                                                !widget
                                                                        .user
                                                                        .userData![
                                                                            'favoriteDishes']!
                                                                        .contains(searchResult[index]
                                                                            .dishId)
                                                                    ? const Icon(
                                                                        Icons
                                                                            .favorite_outline)
                                                                    : const Icon(
                                                                        Icons
                                                                            .favorite,
                                                                        color: Colors
                                                                            .red,
                                                                      )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ]),
                                              ),
                                            ),
                                          );
                                        }))
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dropDownMenu() {
    return DropdownButton(
      isDense: true,
      iconSize: 120.sp,
      iconEnabledColor: Colors.green[700],
      value: deliveryLocation,
      items: const [
        DropdownMenuItem(
          value: "Times Square",
          child: Text('Times Square'),
        ),
        DropdownMenuItem(
          value: "Hayatabad",
          child: Text('Hayatabad'),
        ),
        DropdownMenuItem(
          value: "Sadar",
          child: Text('Sadar'),
        ),
        DropdownMenuItem(
          value: "Islamabad",
          child: Text('Islamabad'),
        ),
      ],
      onChanged: (value) {
        setState(() {
          deliveryLocation = value!;
        });
      },
    );
  }

  Widget eventHeader(String event) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          event,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 72.sp),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => event == "Discount Guaranteed!"
                  ? DiscountsScreen(discounts: discounts)
                  : OffersScreen(),
            ));
          },
          child: Text(
            'See All',
            style: TextStyle(
                color: Colors.green[700],
                fontSize: 60.sp,
                fontWeight: FontWeight.w800),
          ),
        )
      ],
    );
  }

  Widget carouselSlider() {
    return Container(
      height: 640.h,
      width: 1200.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(106.r),
        gradient: RadialGradient(
            colors: [
              const Color.fromARGB(255, 53, 126, 55).withOpacity(0.5),
              const Color.fromARGB(255, 63, 146, 66)
            ],
            center: Alignment.center,
            stops: const [0.01, 1]),
      ),
      child: StreamBuilder<List<OffersModel>>(
        stream: DatabaseService().getOffers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator(
              color: Colors.white,
            );
          } else if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Empty'),
            );
          } else {
            List<OffersModel>? offers = snapshot.data;
            return CarouselSlider.builder(
              itemCount: offers!.length,
              itemBuilder: (context, index, realIndex) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '30%',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 100.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 42.h,
                      ),
                      Text(
                        '${offers[index].offerName} \nvalid for ${offers[index].offerDuration}hr !',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 60.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 70.w),
                    height: 595.h,
                    width: 570.w,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(63.r),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          offers[index].offerImage,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              options: CarouselOptions(
                scrollPhysics: const NeverScrollableScrollPhysics(),
                initialPage: 0,
                autoPlay: true,
                enlargeCenterPage: true,
                enlargeFactor: 0.7,
                viewportFraction: 1,
                autoPlayAnimationDuration: const Duration(milliseconds: 1500),
              ),
            );
          }
        },
      ),
    );
  }

  Widget discountSlider() {
    return SizedBox(
      width: double.infinity,
      height: 1065.h,
      child: StreamBuilder<List<DiscountModel>>(
        stream: DatabaseService().getDiscounts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Empty'),
            );
          } else {
            discounts = snapshot.data!;
            return ListView.builder(
              itemCount: discounts.isEmpty ? 3 : discounts.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.all(20.sp),
                margin: EdgeInsets.all(20.sp),
                width: 680.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(42.r),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 1))
                  ],
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 21.h),
                        height: 630.h,
                        width: 600.w,
                        decoration: discounts.isEmpty
                            ? BoxDecoration(
                                image: const DecorationImage(
                                    image:
                                        AssetImage('assets/images/pizza.jpg'),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(63.r))
                            : BoxDecoration(
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      discounts[index].discountImage,
                                    ),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(63.r)),
                      ),
                      discounts.isEmpty
                          ? const Text('Pizza ')
                          : Text(
                              discounts[index].discountName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 61.sp),
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 60.sp,
                          ),
                          SizedBox(
                            width: 40.w,
                          ),
                          const Text('4.7   (1.2k)')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          discounts.isEmpty
                              ? const Text('')
                              : Text(
                                  '\$${discounts[index].discountDuration}',
                                  style: TextStyle(
                                      color: Colors.green[700],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 61.sp),
                                ),
                          const Icon(
                            Icons.favorite_outline,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ]),
              ),
            );
          }
        },
      ),
    );
  }
}

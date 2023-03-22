import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:resturant/Database/db.dart';
import 'package:resturant/Home/home.dart';
import 'package:resturant/view/Screens/AccountSetup/auth_sevice.dart';
import 'package:resturant/view/Screens/InsideAppScreens/homeScreen.dart';
import 'package:resturant/utils/alertDialog.dart';
import 'package:resturant/utils/textfield.dart';

import '../../../model/user.dart';
import '../../../Provider/userProvider.dart';

class UpdateAccount extends StatefulWidget {
  Users? user;

  UpdateAccount({required this.user});

  @override
  State<UpdateAccount> createState() => _UpdateAccountState();
}

class _UpdateAccountState extends State<UpdateAccount> {
  TextEditingController uFullName = TextEditingController();

  TextEditingController uNickName = TextEditingController();
  TextEditingController uBirthDate = TextEditingController();
  TextEditingController uEmail = TextEditingController();
  TextEditingController uPassword = TextEditingController();
  TextEditingController uGender = TextEditingController();
  bool hidePassword = true;
  File? file;
  // Uint8List? image;
  String? image;
  final _formkey = GlobalKey<FormState>();
  Future getImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
      // image = Base64Decoder().convert(base64Encode(file!.readAsBytesSync()));
      image = file!.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    // File
    (widget.user!.toMap());
    uFullName.text = widget.user!.userName!;
    uNickName.text = widget.user!.userNickname!;
    uBirthDate.text = widget.user!.userBirthday!;
    uEmail.text = widget.user!.userEmail!;
    uPassword.text = widget.user!.userPassword!;
    uGender.text = widget.user!.userGender!;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          'Fill Your Profile',
        ),
      ),
      body: SingleChildScrollView(
        child: BounceInUp(
          duration: Duration(milliseconds: 1000),
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                InkWell(
                  onTap: () => getImage(),
                  child: file != null
                      ? Container(
                          margin: EdgeInsets.only(top: 42.h),
                          padding: EdgeInsets.only(top: 63.h),
                          height: 462.h,
                          width: 440.w,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(file!), fit: BoxFit.cover),
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                          ),
                          // clipBehavior: Clip.antiAlias,
                          // child: Icon(
                          //   Icons.person,
                          //   size: 110,
                          //   color: Colors.grey[400],
                          // ),
                        )
                      : Container(
                          margin: EdgeInsets.only(top: 42.h),
                          padding: EdgeInsets.only(top: 63.h),
                          height: 462.h,
                          width: 440.w,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    widget.user!.userImage!),
                                fit: BoxFit.cover),
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                          ),
                        ),
                ),
                Form(
                  key: _formkey,
                  child: Container(
                    height: 2125.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.w, vertical: 84.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        txFieldDetails(uFullName, "Full Name", null),
                        txFieldDetails(uNickName, "Nickname", null),
                        txFieldDetails(uBirthDate, "Date of Birth",
                            Icons.calendar_month_rounded),
                        txFieldDetails(uEmail, "Email", Icons.mail),
                        TextFormField(
                            validator: (value) => value!.length < 8
                                ? "Password can't be less than 8 characters."
                                : null,
                            controller: uPassword,
                            obscureText: hidePassword,
                            decoration: InputDecoration(
                              suffix: IconButton(
                                padding: EdgeInsets.only(right: 40.w),
                                constraints: BoxConstraints(),
                                icon: Icon(Icons.remove_red_eye_outlined),
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                              ),
                              filled: true,
                              fillColor: Colors.grey[300],
                              prefixIcon: Icon(Icons.lock),
                              label: Text("Password"),
                              contentPadding: EdgeInsets.only(left: 60.w),
                              constraints: BoxConstraints(),
                              enabled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(60.r),
                              ),
                            )),
                        txFieldDetails(uGender, "Gender", null),
                        ElevatedButton(
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {
                                Users? user = await AuthService()
                                    .registerWithEmailAndPassword(
                                        uEmail.text,
                                        uPassword.text,
                                        uFullName.text,
                                        uNickName.text,
                                        uBirthDate.text,
                                        uGender.text,
                                        file!);
                                if (user != null) {
                                  Provider.of<UserProvider>(context,
                                          listen: false)
                                      .setPrefEmail(uEmail.text);
                                  Provider.of<UserProvider>(context,
                                          listen: false)
                                      .setPrefLoged(true);
                                  Provider.of<UserProvider>(context,
                                          listen: false)
                                      .setPrefNewUser(false);
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return alertDialog();
                                    },
                                  );
                                  await Future.delayed(
                                    Duration(seconds: 3),
                                  );
                                  Navigator.of(context).pop();
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) => Home(user: user),
                                  ));
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.green[700],
                                fixedSize: Size(1280.w, 210.h),
                                shape: StadiumBorder()),
                            child: Text('Continue'))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

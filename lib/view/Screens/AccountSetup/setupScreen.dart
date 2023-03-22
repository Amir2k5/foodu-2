import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

class AccountSetup extends StatefulWidget {
  TextEditingController uNameController;
  TextEditingController uEmailController;
  TextEditingController uPasswordController;
  AccountSetup(
      {required this.uNameController,
      required this.uEmailController,
      required this.uPasswordController});

  @override
  State<AccountSetup> createState() => _AccountSetupState();
}

class _AccountSetupState extends State<AccountSetup> {
  bool loading = false;
  TextEditingController uBirthController = TextEditingController();
  TextEditingController uNickNameController = TextEditingController();
  TextEditingController uGenderController = TextEditingController();
  bool hidePassword = true;
  File? file;
  String? image;
  Future getImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
      image = file!.path;
    });
  }

  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
        child: BounceInDown(
          duration: Duration(milliseconds: 1000),
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                InkWell(
                  onTap: () => getImage(),
                  child: file == null
                      ? Container(
                          margin: EdgeInsets.only(top: 42.h),
                          padding: EdgeInsets.only(top: 63.h),
                          height: 460.h,
                          width: 440.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Icon(
                            Icons.person,
                            size: 440.sp,
                            color: Colors.grey[400],
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.only(top: 15),
                          height: 460.h,
                          width: 440.w,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(file!), fit: BoxFit.cover),
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                          ),
                        ),
                ),
                Form(
                  key: formkey,
                  child: Container(
                    height: 2120.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.w, vertical: 84.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        txFieldDetails(
                            widget.uNameController, "Full Name", null),
                        txFieldDetails(uNickNameController, "Nickname", null),
                        InkWell(
                          onTap: () async {
                            var date = (await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime.now()));
                            uBirthController.text =
                                "${date!.day}-${date.month}-${date.year}";
                          },
                          child: IgnorePointer(
                            child: txFieldDetails(uBirthController,
                                "Date of Birth", Icons.calendar_month_rounded),
                          ),
                        ),
                        txFieldDetails(
                            widget.uEmailController, "Email", Icons.mail),
                        TextFormField(
                            validator: (value) => value!.length < 8
                                ? "Password can't be less than 8 characters"
                                : null,
                            controller: widget.uPasswordController,
                            obscureText: hidePassword,
                            decoration: InputDecoration(
                              suffix: IconButton(
                                padding: EdgeInsets.only(right: 40.w),
                                constraints: BoxConstraints(),
                                icon: hidePassword
                                    ? Icon(Icons.visibility_outlined)
                                    : Icon(Icons.visibility_off_outlined),
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
                                borderRadius: BorderRadius.circular(63.r),
                              ),
                            )),
                        txFieldDetails(uGenderController, "Gender", null),
                        ElevatedButton(
                            onPressed: () async {
                              if (image != null) {
                                if (formkey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  Users user = await AuthService()
                                      .registerWithEmailAndPassword(
                                          widget.uEmailController.text,
                                          widget.uPasswordController.text,
                                          widget.uNameController.text,
                                          uNickNameController.text,
                                          uBirthController.text,
                                          uGenderController.text,
                                          file!);
                                  if (user.uid.isNotEmpty) {
                                    loading
                                        ? showDialog(
                                            context: context,
                                            builder: (context) {
                                              return alertDialog();
                                            },
                                          )
                                        : null;
                                    Provider.of<UserProvider>(context,
                                            listen: false)
                                        .setPrefEmail(
                                            widget.uEmailController.text);
                                    Provider.of<UserProvider>(context,
                                            listen: false)
                                        .setPrefLoged(true);
                                    Provider.of<UserProvider>(context,
                                            listen: false)
                                        .setPrefNewUser(false);

                                    await Future.delayed(
                                      Duration(seconds: 2),
                                    );
                                    Navigator.of(context).pop();
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (context) => Home(user: user),
                                    ));
                                  }
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.green[700],
                                fixedSize: Size(1280.w, 213.h),
                                shape: StadiumBorder()),
                            child: loading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text('Continue'))
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

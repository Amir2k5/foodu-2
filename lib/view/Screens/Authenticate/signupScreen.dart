import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant/Database/db.dart';
import 'package:resturant/view/Screens/Authenticate/loginScreen.dart';
import 'package:resturant/utils/divider.dart';
import 'package:resturant/utils/signin_buttons.dart';
import 'package:resturant/utils/textfield.dart';

import '../AccountSetup/setupScreen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController uNameController = TextEditingController();
  TextEditingController uEmailController = TextEditingController();
  TextEditingController uPasswordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool remember = false;
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: BounceInDown(
          duration: Duration(milliseconds: 1500),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 160.h, bottom: 84.h),
                height: 175.h,
                width: double.infinity,
                child: Center(
                  child: Image(
                    image: AssetImage('assets/images/logo.jpg'),
                  ),
                ),
              ),
              Text(
                'Create New Account',
                style: TextStyle(fontSize: 100.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 126.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.sp),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      txFormField(uNameController, "UserName can't be empty!",
                          Icons.person, 'UserName'),
                      SizedBox(
                        height: 84.h,
                      ),
                      txFormField(uEmailController, "UserName can't be empty!",
                          Icons.mail, 'Email'),
                      SizedBox(
                        height: 84.h,
                      ),
                      TextFormField(
                        controller: uPasswordController,
                        validator: (value) => value!.isEmpty
                            ? "Password should be atleast 8 characters"
                            : null,
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
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          label: Text(
                            'Password',
                            style: TextStyle(color: Colors.black),
                          ),
                          filled: true,
                          fillColor: Color.fromARGB(255, 240, 240, 240),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(64.r)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(64.r)),
                          contentPadding: EdgeInsets.only(left: 0),
                          constraints: BoxConstraints(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    side: BorderSide(color: Colors.green, width: 8.w),
                    activeColor: Colors.green[700],
                    value: remember,
                    onChanged: (value) => setState(
                      () {
                        remember = !remember;
                      },
                    ),
                  ),
                  Text(
                    'Remember me',
                    style:
                        TextStyle(fontSize: 60.sp, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    fixedSize: Size(1080.w, 168.h),
                    shape: StadiumBorder()),
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => AccountSetup(
                        uEmailController: uEmailController,
                        uPasswordController: uPasswordController,
                        uNameController: uNameController,
                      ),
                    ));
                  }
                },
                child: Text('Sign Up'),
              ),
              SizedBox(
                height: 42.h,
              ),
              divider(),
              SizedBox(
                height: 42.h,
              ),
              signInButtons(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?',
                      style: TextStyle(color: Colors.grey)),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ));
                      },
                      child: Text(
                        'Sign in',
                        style: TextStyle(color: Colors.green[700]),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

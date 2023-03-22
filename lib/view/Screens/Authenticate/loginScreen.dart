import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:resturant/Database/db.dart';
import 'package:resturant/Home/home.dart';
import 'package:resturant/Provider/userProvider.dart';
import 'package:resturant/view/Screens/AccountSetup/auth_sevice.dart';
import 'package:resturant/view/Screens/Authenticate/signupScreen.dart';
import 'package:resturant/view/Screens/InsideAppScreens/homeScreen.dart';
import 'package:resturant/utils/signin_buttons.dart';
import 'package:resturant/utils/textfield.dart';

import '../../../model/user.dart';
import '../../../utils/divider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool remember = false;
  bool hidepassword = true;
  bool loading = false;
  TextEditingController uEmailController = TextEditingController();
  TextEditingController uPasswordController = TextEditingController();
  // DatabaseHelper? db = DatabaseHelper.instance;
  final _formkey = GlobalKey<FormState>();
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
                'Login to your Account',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 125.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.w),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      txFormField(uEmailController, "Email can't be empty",
                          Icons.mail, 'Email'),
                      SizedBox(
                        height: 84.h,
                      ),
                      TextFormField(
                        controller: uPasswordController,
                        validator: (value) => value!.isEmpty
                            ? "Password should be atleast 8 characters"
                            : null,
                        obscureText: hidepassword,
                        decoration: InputDecoration(
                          suffix: IconButton(
                            padding: EdgeInsets.only(right: 40.w),
                            constraints: BoxConstraints(),
                            icon: hidepassword
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off_outlined),
                            onPressed: () {
                              setState(() {
                                hidepassword = !hidepassword;
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
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    Users? user = await AuthService()
                        .signInWithEmailAndPassword(
                            uEmailController.text, uPasswordController.text);
                    if (user != null) {
                      Provider.of<UserProvider>(context, listen: false)
                          .setPrefEmail(uEmailController.text);
                      Provider.of<UserProvider>(context, listen: false)
                          .setPrefLoged(true);
                      Provider.of<UserProvider>(context, listen: false)
                          .setPrefNewUser(false);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => Home(user: user),
                      ));
                      Fluttertoast.showToast(msg: 'Signed in successfully');
                    } else {
                      Fluttertoast.showToast(
                          msg: "Email and Password don't match");
                    }
                  }
                  setState(() {
                    loading = false;
                  });
                },
                child: loading
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text('Sign in'),
              ),
              SizedBox(
                height: 168.h,
              ),
              divider(),
              SizedBox(
                height: 126.h,
              ),
              signInButtons(context),
              SizedBox(
                height: 84.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => SignUpPage(),
                      ));
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.green[700]),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

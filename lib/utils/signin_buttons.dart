// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:resturant/utils/alertDialog.dart';
import 'package:resturant/utils/textfield.dart';
import 'package:resturant/model/user.dart';

import '../../Database/db.dart';
import '../../Home/home.dart';
import '../../Provider/userProvider.dart';

class AlertDialogSignIn extends StatefulWidget {
  User user;
  File imageFile;
  AlertDialogSignIn({super.key, required this.user, required this.imageFile});

  @override
  State<AlertDialogSignIn> createState() => _AlertDialogSignInState();
}

class _AlertDialogSignInState extends State<AlertDialogSignIn> {
  bool hidePassword = true;
  final formkey = GlobalKey<FormState>();
  final nickName = TextEditingController();
  final password = TextEditingController();
  final dob = TextEditingController();
  final gender = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Before starting we need some information"),
      content: SizedBox(
        height: 1400.h,
        child: Form(
          key: formkey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                txFieldDetails(nickName, "Nich name", null),
                txFieldDetails(dob, "Date of Birth", null),
                txFieldDetails(gender, "Gender", null),
                TextFormField(
                    validator: (value) => value!.length < 8
                        ? "Password can't be less than 8 characters"
                        : null,
                    controller: password,
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                      suffix: IconButton(
                        padding: EdgeInsets.only(right: 40.w),
                        constraints: const BoxConstraints(),
                        icon: hidePassword
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off_outlined),
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: Colors.grey[300],
                      prefixIcon: const Icon(Icons.lock),
                      label: const Text("Password"),
                      contentPadding: EdgeInsets.only(left: 60.w),
                      constraints: const BoxConstraints(),
                      enabled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(63.r),
                      ),
                    )),
                ElevatedButton(
                    onPressed: () async {
                      Provider.of<UserProvider>(context, listen: false)
                          .setPrefEmail(widget.user.email!);
                      Provider.of<UserProvider>(context, listen: false)
                          .setPrefLoged(true);
                      Provider.of<UserProvider>(context, listen: false)
                          .setPrefNewUser(false);
                      showDialog(
                        context: context,
                        builder: (context) => alertDialog(),
                      );
                      String fileName = '${widget.user.email}.jpg';
                      Reference reference = FirebaseStorage.instance
                          .ref('files/user/${fileName}');
                      final TaskSnapshot snapshot =
                          await reference.putFile(widget.imageFile);
                      final downloadURL = await snapshot.ref.getDownloadURL();
                      Users user = await DatabaseService().creatUser(
                          DateTime.now().toString(),
                          widget.user.displayName!,
                          nickName.text,
                          dob.text,
                          widget.user.email!,
                          password.text,
                          gender.text,
                          downloadURL);
                      Navigator.of(context).pop();

                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => Home(user: user),
                      ));

                      Fluttertoast.showToast(msg: 'Signed in successfully');
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green[700],
                        fixedSize: Size(1280.w, 213.h),
                        shape: const StadiumBorder()),
                    child: const Text('Continue'))
              ]),
        ),
      ),
    );
  }
}

Widget signInButtons(BuildContext context) {
  Users? user;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      InkWell(
        onTap: () async {
          final LoginResult loginResult = await FacebookAuth.instance.login(
            permissions: ['email', 'public_profile', 'user_birthday'],
          );
          final OAuthCredential facebookAuthCredential =
              FacebookAuthProvider.credential(loginResult.accessToken!.token);
          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithCredential(facebookAuthCredential);
          User? firebaseUser = userCredential.user;
          user = await DatabaseService().singleUser(firebaseUser!.email);
          if (user == null) {
            final imageFile = await getImage(
                'https://graph.facebook.com/me/picture?type=large&width=900&height=900&access_token=${userCredential.credential!.accessToken}');
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialogSignIn(
                    user: firebaseUser, imageFile: imageFile);
              },
            );
          } else {
            showDialog(
              context: context,
              builder: (context) => alertDialog(),
            );
            Provider.of<UserProvider>(context, listen: false)
                .setPrefEmail(firebaseUser.email!);
            Provider.of<UserProvider>(context, listen: false)
                .setPrefLoged(true);
            Provider.of<UserProvider>(context, listen: false)
                .setPrefNewUser(false);
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => Home(user: user!),
            ));
          }
        },
        child: Container(
          height: 240.h,
          width: 300.w,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(63.r)),
          child: SvgPicture.asset(
            'assets/svg/facebook.svg',
          ),
        ),
      ),
      InkWell(
        onTap: () async {
          // begin interactive sign in process
          final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
          // obtain auth details
          final GoogleSignInAuthentication gAuth = await gUser!.authentication;
          // create a new credential for user
          final credential = GoogleAuthProvider.credential(
              accessToken: gAuth.accessToken, idToken: gAuth.idToken);
          // Sign in
          UserCredential userCredential =
              await FirebaseAuth.instance.signInWithCredential(credential);

          User? firebaseUser = userCredential.user;
          user = await DatabaseService().singleUser(firebaseUser!.email);
          print(user.toString());
          if (user == null) {
            final imageFile = await getImage(firebaseUser.photoURL!);
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialogSignIn(
                    user: firebaseUser, imageFile: imageFile);
              },
            );
          } else {
            showDialog(
              context: context,
              builder: (context) => alertDialog(),
            );
            Provider.of<UserProvider>(context, listen: false)
                .setPrefEmail(firebaseUser.email!);
            Provider.of<UserProvider>(context, listen: false)
                .setPrefLoged(true);
            Provider.of<UserProvider>(context, listen: false)
                .setPrefNewUser(false);
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => Home(user: user!),
            ));
          }
        },
        child: Container(
          height: 240.h,
          width: 300.w,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(63.r)),
          child: SvgPicture.asset(
            'assets/svg/google.svg',
          ),
        ),
      ),
      InkWell(
        child: Container(
          height: 240.h,
          width: 300.w,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(63.r)),
          child: SvgPicture.asset(
            'assets/svg/apple.svg',
          ),
        ),
      ),
    ],
  );
}

Future getImage(String url) async {
  final response = await http.get(Uri.parse(url));
  final directory = await getApplicationDocumentsDirectory();
  final imagePath = '${directory.path}/profile.jpg';
  final imageFile = File(imagePath);
  await imageFile.writeAsBytes(response.bodyBytes);
  return imageFile;
}

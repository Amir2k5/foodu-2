// import 'package:brew_crew/models/user.dart';
// import 'package:brew_crew/services/database.dart';

import 'dart:io';

import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:resturant/Database/db.dart';
import 'package:resturant/model/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Users? _userFromFirebaseUser(User? user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  Stream<Users?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // final _users = FirebaseFirestore.instance.collection('users');
  // final _image = FirebaseStorage.instance.ref();
  Future<Users?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Users user = await FirebaseFirestore.instance
          .collection('users')
          .where('userEmail',isEqualTo: email)
          .snapshots()
          .map((event) =>
              event.docs.map((e) => Users.fromMap(e.data())).singleWhere(
                    (element) => element.userEmail == email,
                  ))
          .first;
      return user;
    } catch (error) {
      print(error.toString());
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(
      String email,
      String password,
      String username,
      String nickname,
      String dob,
      String gender,
      File image) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // User? user = result.user;
      String fileName = '${email}.jpg';
      Reference reference =
          FirebaseStorage.instance.ref('files/users/${fileName}');
      final TaskSnapshot snapshot = await reference.putFile(image);
      final downloadURL = await snapshot.ref.getDownloadURL();
      Users users = await DatabaseService().creatUser(DateTime.now().toString(),
          username, nickname, dob, email, password, gender, downloadURL);
      return users;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}

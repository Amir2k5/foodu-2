import 'package:flutter/cupertino.dart';
import 'package:resturant/Database/db.dart';
import 'package:resturant/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  // var db = DatabaseHelper.instance;
  // late Future<List<User>> _user;
  // Future<List<User>> get user => _user;

  // Future<List<User>> getData() async {
  //   _user = db.getAllUsers();
  //   return _user;
  // }

  String email = '';
  Users? user;
  Future<void> getUser() async {
    user = await DatabaseService().singleUser(email);
  }

  void setPrefEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('email', email);
    notifyListeners();
  }

  Future<String?> getPrefEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email')!;
    notifyListeners();
    return prefs.getString('email');
  }

  void setPrefNewUser(bool isNew) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool('isNew', isNew);
    notifyListeners();
  }

  Future<bool> getPrefNewUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    notifyListeners();
    pref.getBool('isNew') == null ? pref.setBool('isNew', true) : null;
    return pref.getBool('isNew')!;
  }

  void setPrefLoged(bool isLoged) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoged', isLoged);
    notifyListeners();
  }

  Future<bool> getPrefLoged() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    notifyListeners();
    pref.getBool('isLoged') == null ? pref.setBool('isLoged', false) : null;
    return pref.getBool('isLoged')!;
  }
}

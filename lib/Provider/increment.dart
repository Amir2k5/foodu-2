import 'package:flutter/material.dart';

class IncrementProvider with ChangeNotifier {
  // int _page = 0;
  // int get page => _page;
  static const _kDuration = const Duration(milliseconds: 500);
  static const _kCurve = Curves.easeInOut;
  var controller = PageController();
  increment() {
    // _page++;
    controller.nextPage(duration: _kDuration, curve: _kCurve);
    notifyListeners();
  }
}

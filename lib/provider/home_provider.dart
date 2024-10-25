
import 'dart:io';
import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  bool isAndroid = Platform.isAndroid;
  int _menuIndex = 0;

  int get menuIndex => _menuIndex;

  void change() {
    isAndroid = !isAndroid;
    notifyListeners();
  }

  void changeMenuIndex(int index) {
    _menuIndex = index;
    notifyListeners();
  }
}

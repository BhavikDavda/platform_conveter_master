
import 'package:flutter/material.dart';
import 'package:platform_converter/model/contact..dart';
import 'package:platform_converter/utils/global.dart';
import 'package:provider/provider.dart';
class MainProvider extends ChangeNotifier {
  int menuIndex = 0;
  int? itemSelect;
  String? item2Select;
  double slideVal = 0;

  List<Contact> maincontactList = contactList;
  List<Contact> searchcontactList = contactList;




  PageController pageController = PageController();

  void changeMenuIndex(int index) {
    menuIndex = index;
    notifyListeners();

  }

  void searchcontactByName(String name) {
    searchcontactList = maincontactList.where((element) {
      return element.name?.toLowerCase().contains(name.toLowerCase()) ?? false;
    }).toList();
    notifyListeners();
  }



  void changeItem1(int item) {
    itemSelect = item;
    notifyListeners();
  }

  void changeItem2(String item) {
    item2Select = item;
    notifyListeners();
  }
}

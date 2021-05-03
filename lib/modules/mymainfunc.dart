
import 'package:agrifamilyapp/myaccount.dart';
import 'package:agrifamilyapp/myhome.dart';
import 'package:agrifamilyapp/mypost.dart';
import 'package:flutter/material.dart';

abstract class MyMainFunc {
  int selectedIndex = 0;
  List<Widget> widgetOptions = <Widget>[Myhome(), MyPosts(), MyAccount()];
  void onItemTapped(int index) {
      selectedIndex = index;
  }
}

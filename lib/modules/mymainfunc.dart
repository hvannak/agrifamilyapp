
import 'package:agrifamilyapp/myaccount.dart';
import 'package:agrifamilyapp/myhome.dart';
import 'package:agrifamilyapp/mypost.dart';
import 'package:flutter/material.dart';

int selectedIndex = 0;
String title = "Agrifamily Community";
abstract class MyMainFunc {
  int selectedIndex = 0;
  List<Widget> widgetOptions = <Widget>[Myhome(), MyPosts(), MyAccount()];
}

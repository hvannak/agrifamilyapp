import 'package:agrifamilyapp/myaccount.dart';
import 'package:agrifamilyapp/myhomes.dart';
import 'package:agrifamilyapp/mypost.dart';
import 'package:flutter/material.dart';

List<Widget> widgetOptions = <Widget>[Myhome(), MyPosts(), MyAccount()];

List<BottomNavigationBarItem> widgetBottomNav = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'HOME',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.business),
    label: 'POSTS',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.school),
    label: 'ACCOUNTS',
  ),
];

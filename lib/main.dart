import 'dart:convert';

import 'package:agrifamilyapp/modules/mygeneralfunc.dart';
import 'package:agrifamilyapp/modules/mylanguagefunc.dart';
import 'package:agrifamilyapp/modules/mylocalizationfunc.dart';
import 'package:agrifamilyapp/modules/mymainfunc.dart';
import 'package:flutter/material.dart';
import 'Widgets/mainwidget.dart';
import 'modules/mypostfunc.dart';
import 'modules/myhomefunc.dart';
import 'myaccount.dart';
import 'myhome.dart';
import 'mypost.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agrifamily-Cambodia Community',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(key:UniqueKey(),title: title,index: 0),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required Key key, required this.title,required this.index}) : super(key: key);
  final String title;
  final int index;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      resetPostFunc(context);
      resetHomeFunc(context);
    });
  }

  void _onLocalLanguage() async {
    var languages = await fetchAllLanguages(context);
    var localization = await fetchLocalLanguage(context,languages.where((x) => x.defaultlang == true).first.id);
    setsharedPref('local',jsonEncode(localization));
  }

  @override
  void initState() {
    _onItemTapped(widget.index);
    _onLocalLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: widgetBottomNav,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,      
      ),
    );
  }
}

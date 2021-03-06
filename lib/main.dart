import 'dart:convert';

import 'package:agrifamilyapp/Widgets/Callback/mybottomnavcallback.dart';
import 'package:agrifamilyapp/controllers/pagecontroller.dart';
import 'package:agrifamilyapp/controllers/postcontroller.dart';
import 'package:agrifamilyapp/modules/mygeneralfunc.dart';
import 'package:agrifamilyapp/modules/mylanguagefunc.dart';
import 'package:agrifamilyapp/modules/mylocalizationfunc.dart';
import 'package:agrifamilyapp/modules/mymainfunc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Widgets/mainwidget.dart';
import 'controllers/postdisplaycontroller.dart';

void main() {
  // runApp(MyApp());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PostController()),
        ChangeNotifierProvider(create: (context) => PagesController()),
        ChangeNotifierProvider(create: (contex) => PostDisplayController())
      ],
      child: MyApp(),
    ),
  );
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
      Provider.of<PostDisplayController>(context,listen: false).resetDisplayPost();
      Provider.of<PostController>(context,listen: false).resetPost();      
      Provider.of<PagesController>(context,listen: false).resetPage();
    });
  }

  void _onLocalLanguage() async {
    var languages = await fetchAllLanguages(context);
    var localization;
    if(await getsharedPref('lang') != ""){      
      localization = await fetchLocalLanguage(context, await getsharedPref('lang'));
    } else {
      setsharedPref('lang',languages.where((x) => x.defaultlang == true).first.id);
      localization = await fetchLocalLanguage(context,languages.where((x) => x.defaultlang == true).first.id);
    }
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
      bottomNavigationBar: MyBottomNavCallback(onItemTapped: _onItemTapped),
    );
  }
}

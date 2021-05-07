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
      home: MyHomePage(key:UniqueKey(),title: 'Agrifamily Community'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required Key key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      resetPostFunc(context);
      resetHomeFunc(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: widgetBottomNav,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,      
      ),
    );
  }
}

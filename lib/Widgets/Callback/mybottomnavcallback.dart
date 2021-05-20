import 'package:agrifamilyapp/Widgets/mainwidget.dart';
import 'package:agrifamilyapp/modules/mymainfunc.dart';
import 'package:flutter/material.dart';

class MyBottomNavCallback extends StatelessWidget {
  final Function(int) onItemTapped;
  MyBottomNavCallback({required this.onItemTapped});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavigationBar(
        items: widgetBottomNav,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: onItemTapped,      
      ),
    );
  }
}
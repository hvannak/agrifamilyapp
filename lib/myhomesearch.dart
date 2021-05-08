import 'package:agrifamilyapp/Widgets/controlswidget.dart';
import 'package:agrifamilyapp/Widgets/mainwidget.dart';
import 'package:flutter/material.dart';

class Myhomesearch extends StatefulWidget {
  @override
  _MyhomesearchState createState() => _MyhomesearchState();
}

class _MyhomesearchState extends State<Myhomesearch> {
  int _selectedIndex = 0;
  final _formKeymodify = GlobalKey<FormState>();
  var _title = TextEditingController();
  var _description = TextEditingController();
  var _phone = TextEditingController();
  var _email = TextEditingController();
  var _location = TextEditingController();
  var _price = TextEditingController();
  String _currency = "៛";
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Card(
          elevation: 10,
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Form(
              key: _formKeymodify,
            child: Column(
              children: [
                buildControlTF(context, 'Title', _title,
                                      Icons.title,false, true),
                buildControlTF(context, 'Title', _description,
                                      Icons.title,false, true),
                buildControlTF(context, 'Phone', _phone,
                                      Icons.phone,false, true),
                buildControlTF(context, 'Email', _email,
                                      Icons.email,false, true),
                buildControlTF(context, 'Location', _location,
                                      Icons.location_city,false, true),
                buildControlTF(context, 'Price', _price,
                                      Icons.money,false, true),
                // buildControlDropdownTF(context,'Currency',_currency,getCurrencyList(),Icons.money_sharp),
              ],
            )
          ),
          )
        ))
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
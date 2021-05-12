import 'package:agrifamilyapp/Widgets/controlswidget.dart';
import 'package:agrifamilyapp/Widgets/mainwidget.dart';
import 'package:agrifamilyapp/Widgets/mycategorywidget.dart';
import 'package:agrifamilyapp/Widgets/myhomewidget.dart';
import 'package:agrifamilyapp/models/searchpostmodel.dart';
import 'package:agrifamilyapp/modules/mycategoryfunc.dart';
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
  var _fromPrice = TextEditingController();
  var _toPrice = TextEditingController();
  String _currency = "៛";

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Data')),
      body: Container(
          child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Card(
                  shadowColor: Colors.blueGrey,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Form(
                        key: _formKeymodify,
                        child: Column(
                          children: [
                            buildControlDropdownCategory(context,'Category',fetchAllCategory(context),Icons.category),
                            buildControlTF(context, 'Title', _title,
                                Icons.title, false, true),
                            buildControlTF(context, 'Description', _description,
                                Icons.description, false, true),
                            buildControlTF(context, 'Phone', _phone,
                                Icons.phone, false, true),
                            buildControlTF(context, 'Email', _email,
                                Icons.email, false, true),
                            buildControlTF(context, 'Location', _location,
                                Icons.location_city, false, true),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    flex: 40,
                                    child: Column(
                                      children: <Widget>[
                                        buildControlTF(context, 'From Price',
                                            _fromPrice, Icons.money, false, true)
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  Expanded(
                                    flex: 20,
                                    child: Column(
                                      children: <Widget>[buildCurrencyBtn()],
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  Expanded(
                                    flex: 40,
                                    child: Column(
                                      children: <Widget>[
                                        buildControlTF(context, 'To Price',
                                            _toPrice, Icons.money, false, true)
                                      ],
                                    ),
                                  ),
                                ]),
                            buildSearchBtn()
                          ],
                        )),
                  )))),
      bottomNavigationBar: BottomNavigationBar(
        items: widgetBottomNav,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget buildCurrencyBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white60, // background
          onPrimary: Colors.white,
          padding: EdgeInsets.all(20),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: () {
          setState(() {
            _currency = (_currency == '៛') ? '\$' : '៛';
          });
        },
        child: Text(
          _currency,
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget buildSearchBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white60, // background
          onPrimary: Colors.white,
          padding: EdgeInsets.all(20),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: () {
          var fromP = (_fromPrice.text.length == 0) ? null : int.parse(_fromPrice.text);
          var toP = (_toPrice.text.length == 0) ? null : int.parse(_toPrice.text);
          var searching = Searchpostmodel(category,null,_title.text,_description.text,_phone.text,_email.text,_location.text,fromP,_currency,toP);
          Navigator.of(context).pop(searching);
        },
        child: Text(
          'SEARCH DATA',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}
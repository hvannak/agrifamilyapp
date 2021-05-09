import 'package:agrifamilyapp/Widgets/controlswidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildSearchBtn(BuildContext context) {
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
      onPressed: () {},
      child: Text('SEARCH DATA',style: TextStyle(
          color: Color(0xFF527DAA),
          letterSpacing: 1.5,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),),
    ),
  );
}

Widget buildCurrencyBtn(BuildContext context,String currency) {
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
        currency = (currency == '៛') ? '\$' : '៛';
      },
      child: Text(currency,style: TextStyle(
          color: Color(0xFF527DAA),
          letterSpacing: 1.5,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),),
    ),
  );
}

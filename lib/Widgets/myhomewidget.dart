 import 'package:agrifamilyapp/Widgets/controlswidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var _title = TextEditingController();
var _description = TextEditingController();
var _phone = TextEditingController();
var _email = TextEditingController();
var _location = TextEditingController();
var _fromprice = TextEditingController();
var _toprice = TextEditingController();

Future<void> showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              buildControlTF(context, 'Title', _title,
                                      Icons.title,false, true),
              buildControlTF(context, 'Title', _description,
                                      Icons.title,false, true),
              buildControlTF(context, 'Title', _email,
                                      Icons.title,false, true),
              buildControlTF(context, 'Title', _phone,
                                      Icons.title,false, true),
              buildControlTF(context, 'Title', _location,
                                      Icons.title,false, true),
              buildControlTF(context, 'Title', _fromprice,
                                      Icons.title,false, true),
              buildControlTF(context, 'Title', _toprice,
                                      Icons.title,false, true),                                                
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Search'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
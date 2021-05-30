import 'package:agrifamilyapp/Helpers/constants.dart';
import 'package:agrifamilyapp/Widgets/controlswidget.dart';
import 'package:flutter/material.dart';

String searchBy = "title";
var searchKey = [
  {"text": "Title", "value": "title"},
  {"text": "Phone", "value": "phone"}
];

Widget buildControlDropdownPostSearch(
    BuildContext context, String label, IconData iconData) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: DropdownButtonFormField(
              dropdownColor: Colors.white,
              items: searchKey
                  .map((f) => DropdownMenuItem(
                        child: buildText(f['text']!, kTextStyle),
                        value: f['value'],
                      ))
                  .toList(),
              onChanged: (value) {
                print(value);
                searchBy = value.toString();
              },
              hint: buildText(label, headertextStyle),
              value: searchBy,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 5.0),
                prefixIcon: Icon(
                  iconData,
                  color: Colors.white,
                ),
                errorStyle: kErrorTextStyle,
                hintStyle: kHintTextStyle,
              )),
        )
      ]);
}

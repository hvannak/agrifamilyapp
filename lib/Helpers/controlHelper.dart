import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'constants.dart';

class ControlHelper {
  Future<String> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
    return DateFormat('yyyy-MM-dd').format(picked);
  }

  Widget buildControlTF(
      BuildContext context,
      String label,
      TextEditingController textEditingController,
      IconData iconData,
      bool tap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: textEditingController,
            validator: (val) => val.isEmpty ? label + ' is required' : null,
            style: kTextStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                iconData,
                color: Colors.white,
              ),
              hintText: 'Enter your ' + label,
              errorStyle: kErrorTextStyle,
              hintStyle: kHintTextStyle,
            ),
            onTap: () async {
              if (tap) {
                var date = await selectDate(context);
                textEditingController.text = date;
              }
            },
          ),
        ),
      ],
    );
  }

  Widget buildControlMultiLineTF(BuildContext context, String label,
      TextEditingController textEditingController, IconData iconData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          child: TextFormField(
              controller: textEditingController,
              validator: (val) => val.isEmpty ? label + ' is required' : null,
              style: kTextStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  iconData,
                  color: Colors.white,
                ),
                hintText: 'Enter your ' + label,
                errorStyle: kErrorTextStyle,
                hintStyle: kHintTextStyle,
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 4),
        ),
      ],
    );
  }

}

import 'package:agrifamilyapp/Helpers/constants.dart';
import 'package:agrifamilyapp/Widgets/controlswidget.dart';
import 'package:agrifamilyapp/models/categorymodel.dart';
import 'package:flutter/material.dart';

String? category;

Widget buildControlDropdownCategory(
      BuildContext context,
      String label,
      Future<List<Categorymodel>> funData,
      IconData iconData) {
    return FutureBuilder<List<Categorymodel>>(
      future: funData,
      builder: (BuildContext context,
          AsyncSnapshot<List<Categorymodel>> snapshot) {
        Widget children;
        if (snapshot.hasData) {
          children = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.0),
              Container(
                  alignment: Alignment.centerLeft,
                  decoration: kBoxDecorationStyle,
                  height: 60.0,
                  child: DropdownButtonFormField(
                    dropdownColor: Colors.white,
                    items: snapshot.data!
                        .map((f) => DropdownMenuItem(
                              child: Text(f.title,style: kHintTextStyle),
                              value: f.id,
                            ))
                        .toList(),
                    onChanged: (value) {
                      print(value);
                      category = value.toString();
                    },
                    // hint: Text(label,style: kHintTextStyle),
                    hint: buildText(label,headertextStyle),
                    value: (category == null) ? snapshot.data![0].id : category,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 5.0),
                      prefixIcon: Icon(
                        iconData,
                        color: Colors.white,
                      ),
                      errorStyle: kErrorTextStyle,
                      hintStyle: kHintTextStyle,
                    ),
                  )
                  ),
            ],
          );
        } else {
          children = Opacity(opacity: 0.0);
        }
        return children;
      },
    );
  }
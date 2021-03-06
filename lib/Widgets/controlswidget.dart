import 'package:agrifamilyapp/Helpers/constants.dart';
import 'package:agrifamilyapp/modules/mygeneralfunc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

FutureBuilder buildText(String proptext, TextStyle textstyle) {
  return FutureBuilder(
      future: getShowLang(proptext),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return CupertinoActivityIndicator();
        }
        return Text(snapshot.data, style: textstyle);
      });
}

FutureBuilder buildControl(
    BuildContext context,
    String label,
    TextEditingController textEditingController,
    IconData iconData,
    bool obscure,
    bool tap) {
  return FutureBuilder(
      future: getShowLang(label),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return CupertinoActivityIndicator();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 5.0),
            Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle,
              height: 60.0,
              child: FutureBuilder(
                  future: getShowLang('VRequire'),
                  builder: (BuildContext context, AsyncSnapshot snapshot1) {
                    if (snapshot.data == null) {
                      return CupertinoActivityIndicator();
                    }
                    return TextFormField(
                      controller: textEditingController,
                      validator: (val) => val!.isEmpty
                          ? snapshot.data + ' ' + snapshot1.data
                          : null,
                      style: kTextStyle,
                      obscureText: obscure,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                          iconData,
                          color: Colors.white,
                        ),
                        hintText: snapshot.data,
                        errorStyle: kErrorTextStyle,
                        hintStyle: kHintTextStyle,
                      ),
                      onChanged: (value) async {
                        if (tap) {
                          print('Your taped');
                        }
                      },
                    );
                  }),
            ),
          ],
        );
      });
}

FutureBuilder buildControlPassword(
    BuildContext context,
    String label,
    TextEditingController textEditingController,
    IconData iconData,
    bool obscure,
    bool tap) {
  return FutureBuilder(
      future: getShowLang(label),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return CupertinoActivityIndicator();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 5.0),
            Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle,
              height: 60.0,
              child: FutureBuilder(
                  future: getShowLang('VRequire'),
                  builder: (BuildContext context, AsyncSnapshot snapshot1) {
                    if (snapshot.data == null) {
                      return CupertinoActivityIndicator();
                    }
                    return TextFormField(
                      controller: textEditingController,
                      validator: (val) => val!.isEmpty || val.length < 6
                          ? '6 ' + snapshot.data + ' ' + snapshot1.data
                          : null,
                      style: kTextStyle,
                      obscureText: obscure,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                          iconData,
                          color: Colors.white,
                        ),
                        hintText: snapshot.data,
                        errorStyle: kErrorTextStyle,
                        hintStyle: kHintTextStyle,
                      ),
                      onChanged: (value) async {
                        if (tap) {
                          print('Your taped');
                        }
                      },
                    );
                  }),
            ),
          ],
        );
      });
}

FutureBuilder buildControlConfirmPassword(
    BuildContext context,
    String label,
    TextEditingController textEditingController,
    TextEditingController textEditingControllerComp,
    IconData iconData,
    bool obscure,
    bool tap) {
  return FutureBuilder(
      future: getShowLang(label),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return CupertinoActivityIndicator();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 5.0),
            Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle,
              height: 60.0,
              child: FutureBuilder(
                  future: getShowLang('RConfirmPassword'),
                  builder: (BuildContext context, AsyncSnapshot snapshot1) {
                    if (snapshot.data == null) {
                      return CupertinoActivityIndicator();
                    }
                    return TextFormField(
                      controller: textEditingController,
                      validator: (val) => val != textEditingControllerComp.text
                          ? snapshot.data + ' ' + snapshot1.data
                          : null,
                      style: kTextStyle,
                      obscureText: obscure,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                          iconData,
                          color: Colors.white,
                        ),
                        hintText: snapshot.data,
                        errorStyle: kErrorTextStyle,
                        hintStyle: kHintTextStyle,
                      ),
                      onChanged: (value) async {
                        if (tap) {
                          print('Your taped');
                        }
                      },
                    );
                  }),
            ),
          ],
        );
      });
}

FutureBuilder buildControlMultiLine(BuildContext context, String label,
    TextEditingController textEditingController, IconData iconData) {
  return FutureBuilder(
      future: getShowLang(label),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return CupertinoActivityIndicator();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10.0),
            Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle,
              child: FutureBuilder(
                  future: getShowLang('VRequire'),
                  builder: (BuildContext context, AsyncSnapshot snapshot1) {
                    return TextFormField(
                        controller: textEditingController,
                        validator: (val) => val!.isEmpty
                            ? snapshot.data + ' ' + snapshot1.data
                            : null,
                        style: kTextStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 14.0),
                          prefixIcon: Icon(
                            iconData,
                            color: Colors.white,
                          ),
                          hintText: snapshot.data,
                          errorStyle: kErrorTextStyle,
                          hintStyle: kHintTextStyle,
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 4);
                  }),
            ),
          ],
        );
      });
}

Future<Widget> buildControlTF(
    BuildContext context,
    String label,
    TextEditingController textEditingController,
    IconData iconData,
    bool obscure,
    bool tap) async {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: kLabelStyle,
      ),
      SizedBox(height: 5.0),
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 60.0,
        child: TextFormField(
          controller: textEditingController,
          validator: (val) => val!.isEmpty ? label + ' is required' : null,
          style: kTextStyle,
          obscureText: obscure,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              iconData,
              color: Colors.white,
            ),
            hintText: await getShowLang(label),
            errorStyle: kErrorTextStyle,
            hintStyle: kHintTextStyle,
          ),
          onChanged: (value) async {
            if (tap) {
              print('Your taped');
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
            validator: (val) => val!.isEmpty ? label + ' is required' : null,
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

Future<String> selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2050));
  return DateFormat('yyyy-MM-dd').format(picked!);
}

Widget buildSaveBtn(
    BuildContext context, GlobalKey<FormState> formKey, dynamic dynamicFuc) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 25.0),
    width: double.infinity,
    child: RaisedButton(
      elevation: 5.0,
      onPressed: () {
        if (formKey.currentState!.validate()) {
          print('valid');
          dynamicFuc();
        } else {
          final snackBar = SnackBar(content: Text('Please verify your input.'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      padding: EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Colors.white,
      child: Text(
        'SAVE',
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

Widget buildControlDropdownTF(BuildContext context, String label,
    String dropValue, Future<List<String>> funData, IconData iconData) {
  return FutureBuilder<List<String>>(
    future: funData,
    builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
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
                            child: Text(f, style: kHintTextStyle),
                            value: f,
                          ))
                      .toList(),
                  onChanged: (value) {
                    print(value);
                    dropValue = value.toString();
                  },
                  hint: Text(label, style: kHintTextStyle),
                  value: dropValue,
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
                )),
          ],
        );
      } else {
        children = Opacity(opacity: 0.0);
      }
      return children;
    },
  );
}

// Widget buildImage() {
//   return Container(
//       padding: EdgeInsets.symmetric(vertical: 25.0),
//       width: double.infinity,
//       child:
//           Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
//         Container(
//           child: _imagePath == ''
//               ? Image.asset(
//                   'assets/images/user.png',
//                   color: Colors.white,
//                   height: 180.0,
//                   width: 180.0,
//                 )
//               : Image.file(File(_imagePath)),
//           width: 300.0,
//           height: 300.0,
//         )
//       ]));
// }

// Widget buildControlDateChangeTF(
//     BuildContext context,
//     String label,
//     TextEditingController textEditingController,
//     IconData iconData,
//     bool tap) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: <Widget>[
//       Text(
//         label,
//         style: kLabelStyle,
//       ),
//       SizedBox(height: 10.0),
//       Container(
//         alignment: Alignment.centerLeft,
//         decoration: kBoxDecorationStyle,
//         height: 60.0,
//         child: TextFormField(
//           controller: textEditingController,
//           validator: (val) => val.isEmpty ? label + ' is required' : null,
//           style: kTextStyle,
//           decoration: InputDecoration(
//             border: InputBorder.none,
//             contentPadding: EdgeInsets.only(top: 14.0),
//             prefixIcon: Icon(
//               iconData,
//               color: Colors.white,
//             ),
//             hintText: 'Enter your ' + label,
//             errorStyle: kErrorTextStyle,
//             hintStyle: kHintTextStyle,
//           ),
//           onTap: () async {
//             if (tap) {
//               var date = await _controlHelper.selectDate(context);
//               textEditingController.text = date;
//               if (_fromDate.text != '' && _toDate.text != '') {
//                 _numOfDays.text = (DateTime.parse(_toDate.text)
//                             .difference(DateTime.parse(_fromDate.text))
//                             .inDays +
//                         1)
//                     .toString();
//                 _numOfHours.text =
//                     (double.parse(_numOfDays.text) * hourPerday).toString();
//               }
//             }
//           },
//         ),
//       ),
//     ],
//   );
// }

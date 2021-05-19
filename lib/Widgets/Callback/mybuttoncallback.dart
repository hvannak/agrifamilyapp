import 'package:agrifamilyapp/Helpers/constants.dart';
import 'package:agrifamilyapp/modules/mygeneralfunc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButtonCallback extends StatelessWidget {
  final String labelText;
  final VoidCallback myPress;
  MyButtonCallback({ required this.myPress, required this.labelText});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: FutureBuilder(
        future: getShowLang(labelText),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return CupertinoActivityIndicator();
          }
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white60,
                onPrimary: Colors.white,
                padding: EdgeInsets.all(20),
                elevation: 2,              
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: myPress,
              child: Text(snapshot.data,style: kbtnStyle),
            );
        }),
    );
    
  }
}

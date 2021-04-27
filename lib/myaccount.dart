import 'package:flutter/material.dart';

import 'formcontrols/formcontrols.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  final _formKey = GlobalKey<FormState>();
  var _email = TextEditingController();
  var _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10.0,
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      CircleAvatar(
                        child: ClipOval(
                          child: Image.asset('assets/images/profile.png',fit: BoxFit.cover),
                        ),
                        radius: 50,
                      ),
                      buildControlTF(context, 'Email', _email,
                          Icons.person,false, true),
                      buildControlTF(context, 'Password', _password,
                          Icons.security,true, true),
                      buildSaveBtn(_formKey),
                    ],
                  ))
          ],
        ),
      ),
    );
  }

}


import 'package:agrifamilyapp/models/postmodel.dart';
import 'package:agrifamilyapp/models/usermodel.dart';
import 'package:agrifamilyapp/modules/myaccountfunc.dart';
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
  bool _isLogin = false;

  @override
  Widget build(BuildContext context) {
    if(_isLogin){
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
              Card(
                shadowColor: Colors.blue,
                child: Container(
                  child: Text('You ar in'),
                ),
              )
            ],
          ),
        ),
      );
    } else {
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
                      buildLoginBtn(),
                      buildRegisterBtn()
                    ],
                  ))
          ],
        ),
      ),
    );
    }    
  }

  Widget buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 2.0,
        onPressed: () {
          if(_formKey.currentState.validate()){
            logIn(context,UsersModel.login(email: _email.text,password: _password.text).toLoginJson()).then((value) => {
              setState(() {
                _isLogin = true;
              })
            });
          }
          else{
            final snackBar = SnackBar(content: Text('Please verify your input.'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
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

  Widget buildRegisterBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 2.0,
        onPressed: () {
          if(_formKey.currentState.validate()){
            logIn(context,UsersModel.login(email: _email.text,password: _password.text).toLoginJson());
          }
          else{
            final snackBar = SnackBar(content: Text('Please verify your input.'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white,
        child: Text(
          'REGISTER',
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


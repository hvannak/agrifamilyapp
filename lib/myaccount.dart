import 'package:agrifamilyapp/Widgets/controlswidget.dart';
import 'package:agrifamilyapp/models/postmodel.dart';
import 'package:agrifamilyapp/models/usermodel.dart';
import 'package:agrifamilyapp/modules/myaccountfunc.dart';
import 'package:agrifamilyapp/modules/mygeneralfunc.dart';
import 'package:agrifamilyapp/modules/mylanguagefunc.dart';
import 'package:flutter/material.dart';

import 'Helpers/constants.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  final _formKey = GlobalKey<FormState>();
  final _formKeymodify = GlobalKey<FormState>();
  var _userObject;
  var _name = TextEditingController();
  var _email = TextEditingController();
  var _password = TextEditingController();
  bool _isLogin = false;
  String _language = "KH";

  @override
  void initState() {
    super.initState();
    _initUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: (_isLogin) ? authWidget() : unAuthWidget(),
      ),
      floatingActionButton: Container(
        alignment: Alignment.topRight,
        padding: EdgeInsets.only(top: 30),
        child: FloatingActionButton(
          // child: Text(_language),
          child: listLanguages(),
          onPressed: () {
            setState(() {
              _language = (_language == 'KH') ? 'EN' : 'KH';
            });
          },
        ),
      ),
    );
  }

  Widget listLanguages() {
    return Container(
      child: FutureBuilder(
        future: fetchAllLanguages(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
                child: Center(
                    child: SizedBox(
              child: CircularProgressIndicator(),
              width: 20,
              height: 20,
            )));
          } else {
            return Container(
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top:30),
                            child: FloatingActionButton(
                              heroTag: 'btn' + index.toString(),
                              child: Text(snapshot.data[index].shortcode),
                              onPressed: () {}),
                          )
                        ],
                      );
                    }));
          }
        },
      ),
    );
  }

  Widget authWidget() {
    return Container(
      color: Colors.lightBlueAccent,
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    'assets/images/bgprofile.jpg',
                    fit: BoxFit.fitHeight,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: ClipOval(
                                  child: Image.asset(
                                      'assets/images/profile.png',
                                      fit: BoxFit.cover),
                                ),
                                radius: 90,
                              ),
                              ListTile(
                                leading: Icon(Icons.arrow_drop_down_circle),
                                title: Text(_userObject.email,
                                    style: headertextStyle),
                                subtitle: Text(_userObject.name),
                              ),
                              Card(
                                  elevation: 10.0,
                                  child: Padding(
                                    padding: EdgeInsets.all(50),
                                    child: Form(
                                        key: _formKeymodify,
                                        child: Column(
                                          children: <Widget>[
                                            buildControlTF(
                                                context,
                                                'Name',
                                                _name,
                                                Icons.verified_user,
                                                false,
                                                true),
                                            buildControlTF(
                                                context,
                                                'Email',
                                                _email,
                                                Icons.person,
                                                false,
                                                true),
                                            buildControlTF(
                                                context,
                                                'Password',
                                                _password,
                                                Icons.security,
                                                true,
                                                true),
                                            buildChangeBtn()
                                          ],
                                        )),
                                  ))
                            ],
                          ))
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }

  Widget unAuthWidget() {
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
                        child: Image.asset('assets/images/profile.png',
                            fit: BoxFit.cover),
                      ),
                      radius: 50,
                    ),
                    buildControlTF(
                        context, 'Email', _email, Icons.person, false, true),
                    buildControlTF(context, 'Password', _password,
                        Icons.security, true, true),
                    buildLoginBtn(),
                    buildRegisterBtn()
                  ],
                ))
          ],
        ),
      ),
    );
  }

  _initUserData() async {
    var token = await getsharedPref('token');
    if (token.isNotEmpty) {
      var userData = await getById(context);
      setState(() {
        _isLogin = true;
        _userObject = userData;
        _name.text = _userObject.name;
        _email.text = _userObject.email;
      });
    }
  }

  Widget buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 2.0,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            logIn(context,
                    Usermodel.login(_email.text, _password.text).toLoginJson())
                .then((value) => {
                      setState(() {
                        _isLogin = true;
                        _userObject = value;
                      })
                    });
          } else {
            final snackBar =
                SnackBar(content: Text('Please verify your input.'));
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
          if (_formKey.currentState!.validate()) {
            logIn(context,
                Usermodel.login(_email.text, _password.text).toLoginJson());
          } else {
            final snackBar =
                SnackBar(content: Text('Please verify your input.'));
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

  Widget buildChangeBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 2.0,
        onPressed: () {
          if (_formKeymodify.currentState!.validate()) {
            update(
                    context,
                    Usermodel(_userObject.id, _name.text, _password.text, false,
                            _email.text, null)
                        .toJson())
                .then((value) => {
                      setState(() {
                        _isLogin = true;
                        _userObject = value;
                      })
                    });
          } else {
            final snackBar =
                SnackBar(content: Text('Please verify your input.'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white,
        child: Text(
          'CHANG',
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

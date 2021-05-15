import 'package:agrifamilyapp/Widgets/Callback/mybuttoncallback.dart';
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

  @override
  void initState() {
    super.initState();
    _initUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(child: (_isLogin) ? authWidget() : unAuthWidget()));
  }

  void _showPopupMenu() async {
    var selectedItem = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(50, 130, 100, 100),
      items: [
        PopupMenuItem<String>(child: const Text('Logout'), value: 'logout')
      ],
      elevation: 8.0,
    );
    if(selectedItem == 'logout'){
      setState(() {
        _isLogin = false;
        removesharedPref('token');
      });
    }
  }

  Widget listLanguages() {
    return Container(
      alignment: Alignment.center,
      height: 100,
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
            return ListView.builder(
                itemCount: snapshot.data.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: const EdgeInsets.all(3),
                      child: InkWell(
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 25,
                          child: ClipOval(
                            child: Text(
                              snapshot.data[index].shortcode,
                              style: kTextStyle,
                            ),
                          ),
                        ),
                        onTap: () {
                          print('taped');
                        },
                      ));
                });
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
                                leading: InkWell(
                                  child: Icon(Icons.arrow_drop_down_circle),
                                  onTap: () => _showPopupMenu(),
                                ),
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
                                            buildControl(
                                                context,
                                                'Username',
                                                _name,
                                                Icons.verified_user,
                                                false,
                                                true),
                                            buildControl(
                                                context,
                                                'Email',
                                                _email,
                                                Icons.person,
                                                false,
                                                true),
                                            buildControl(
                                                context,
                                                'Password',
                                                _password,
                                                Icons.security,
                                                true,
                                                true),
                                            Center(
                                                child: MyButtonCallback(
                                                    myPress: _changeInfo,
                                                    labelText: 'Save'))
                                          ],
                                        )),
                                  ))
                            ],
                          ))
                    ],
                  ),
                  listLanguages(),
                ],
              )
            ],
          )),
    );
  }

  Widget unAuthWidget() {
    return Container(
      color: Colors.lightBlueAccent,
      alignment: Alignment.topCenter,
      padding: EdgeInsets.all(40),
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
                    buildControl(
                        context, 'Email', _email, Icons.person, false, true),
                    buildControl(context, 'Password', _password, Icons.security,
                        true, true),
                    Center(
                        child: MyButtonCallback(
                            myPress: _logIn, labelText: 'Login')),
                    Center(
                        child: MyButtonCallback(
                            myPress: _register, labelText: 'Register'))
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void _logIn() {
    if (_formKey.currentState!.validate()) {
      logIn(context, Usermodel.login(_email.text, _password.text).toLoginJson())
          .then((value) => {
                setState(() {
                  _isLogin = true;
                  _userObject = value;
                })
              });
    } else {
      final snackBar = SnackBar(content: Text('Please verify your input.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void _changeInfo() {
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
      final snackBar = SnackBar(content: Text('Please verify your input.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void _register() {
    print('you tapped');
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
}

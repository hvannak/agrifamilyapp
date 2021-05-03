import 'package:agrifamilyapp/Helpers/constants.dart';
import 'package:flutter/material.dart';

Widget buildControlTF(
      BuildContext context,
      String label,
      TextEditingController textEditingController,
      IconData iconData,bool obscure,
      bool tap) {
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
              hintText: 'Enter your ' + label,
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


  Widget buildSaveBtn(BuildContext context,GlobalKey<FormState> formKey,dynamic dynamicFuc) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          if(formKey.currentState!.validate()){
            print('valid');
            dynamicFuc();
          }
          else{
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
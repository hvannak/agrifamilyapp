import 'dart:convert';
import 'dart:io';

import 'package:agrifamilyapp/Helpers/apiHelpers.dart';
import 'package:agrifamilyapp/models/usermodel.dart';
import 'package:agrifamilyapp/modules/mygeneralfunc.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';


Future<UsersModel> logIn(BuildContext context,Map<String, dynamic> instance) async {
    try {
      var response = await ApiHelpers.fetchPost(
            '/user/loginclient', instance);
      if (response.statusCode == 200) {
        setsharedPref('token', response.body);
        Map<String, dynamic> payload = Jwt.parseJwt(response.body);
        var userResponse = await ApiHelpers.fetchDataWithAuth('/user/getById/${payload['_id']}', response.body.toString());
        return UsersModel.fromJson(jsonDecode(userResponse.body));
      } else {
        throw (response.statusCode.toString());
      }
    } on SocketException catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      throw(e);
    } on Exception catch (e) {
      throw (e);
    }
  }

  Future<UsersModel> getById(BuildContext context) async {
    try {
      Map<String, dynamic> payload = Jwt.parseJwt(await getsharedPref('token'));
      var response = await ApiHelpers.fetchDataWithAuth('/user/getById/${payload['_id']}',await getsharedPref('token'));
      if (response.statusCode == 200) {
        return UsersModel.fromJson(jsonDecode(response.body));
      } else {
        throw (response.statusCode.toString());
      }
    } on SocketException catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      throw(e);
    } on Exception catch (e) {
      throw (e);
    }
  }

  Future<UsersModel> update(BuildContext context,Map<String, dynamic> instance) async {
    try {
      var response = await ApiHelpers.fetchPutWithAuth(
            '/user/put/${instance['_id']}', instance,await getsharedPref('token'));
      if (response.statusCode == 200) {
        final snackBar = SnackBar(content: Text('Your change is successfully.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return UsersModel.fromJson(jsonDecode(response.body)['obj']);
      } else {
        throw (response.statusCode.toString());
      }
    } on SocketException catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      throw(e);
    } on Exception catch (e) {
      throw (e);
    }
  }
import 'dart:convert';
import 'dart:io';

import 'package:agrifamilyapp/Helpers/apiHelpers.dart';
import 'package:agrifamilyapp/models/usermodel.dart';
import 'package:agrifamilyapp/modules/mygeneralfunc.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';


Future<Usermodel> logIn(BuildContext context,Map<String, dynamic> instance) async {
    try {
      var response = await ApiHelpers.fetchPost(
            '/user/loginclient', instance);
      if (response.statusCode == 200) {
        setsharedPref('token', response.body);
        Map<String, dynamic> payload = Jwt.parseJwt(response.body);
        var userResponse = await ApiHelpers.fetchDataWithAuth('/user/getById/${payload['_id']}', response.body.toString());
        return Usermodel.fromJson(jsonDecode(userResponse.body));
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

  Future<Usermodel> getById(BuildContext context) async {
    try {
      Map<String, dynamic> payload = Jwt.parseJwt(await getsharedPref('token'));
      var response = await ApiHelpers.fetchDataWithAuth('/user/getById/${payload['_id']}',await getsharedPref('token'));
      if (response.statusCode == 200) {
        return Usermodel.fromJson(jsonDecode(response.body));
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

  Future<Usermodel> update(BuildContext context,Map<String, dynamic> instance) async {
    try {
      var response = await ApiHelpers.fetchPutWithAuth(
            '/user/put/${instance['_id']}', instance,await getsharedPref('token'));
      if (response.statusCode == 200) {
        var message = await getShowLang('CSuccessMessage');
        final snackBar = SnackBar(content: Text(message));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return Usermodel.fromJson(jsonDecode(response.body)['obj']);
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

  Future<String> register(BuildContext context,Map<String, dynamic> instance) async {
    try {
      var response = await ApiHelpers.fetchPost(
            '/user/register', instance);
      if (response.statusCode == 200) {
        var message = await getShowLang(jsonDecode(response.body)['message']);
        final snackBar = SnackBar(content: Text(message));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return jsonDecode(response.body)['_id'];
      } else {
        var message = await getShowLang(response.body);
        final snackBar = SnackBar(content: Text(message));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
import 'dart:convert';
import 'dart:io';

import 'package:agrifamilyapp/Helpers/apiHelpers.dart';
import 'package:agrifamilyapp/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';

Future<UsersModel> logIn(BuildContext context,Map<String, dynamic> instance) async {
    try {
      var response = await ApiHelpers.fetchPost(
            '/user/loginclient', instance);
      if (response.statusCode == 200) {
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

  Future<UsersModel> update(BuildContext context,Map<String, dynamic> instance) async {
    try {
      var response = await ApiHelpers.fetchPutWithAuth(
            '/user/put/${instance['_id']}', instance,null);
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
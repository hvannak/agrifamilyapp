import 'dart:convert';
import 'dart:io';

import 'package:agrifamilyapp/Helpers/apiHelpers.dart';
import 'package:agrifamilyapp/models/postmodel.dart';
import 'package:flutter/material.dart';

import 'mygeneralfunc.dart';

List<Postmodel> listPost = [];
int totalDoc = 0;
bool moreLoad = false;

Future<List<Postmodel>> getByPage(BuildContext context,Map<String, dynamic> instance) async {
    try {
      moreLoad = true;
      var response = await ApiHelpers.fetchPostWithAuth('/posts/pageclient',instance,await getsharedPref('token'));
      if (response.statusCode == 200) {
        var list = jsonDecode(response.body)['objList'] as List;
        totalDoc = jsonDecode(response.body)['totalDoc'] as int;
        listPost.addAll(list.map((i) => Postmodel.fromJson(i)).toList());
        print(listPost.length);
        moreLoad = false;
        return listPost;
      } else {
        final snackBar = SnackBar(content: Text(response.body));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print(response.statusCode.toString());
        throw (response.statusCode.toString());
      }
    } on SocketException catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      throw(e);
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
  }

resetPostFunc(BuildContext context) {
  listPost = [];
  totalDoc = 0;
  moreLoad = false;
}

Future<Postmodel> savePostData(BuildContext context,Map<String, dynamic> instance) async {
    try {
      var response;
      if (instance['_id'] != null) {
        response = await ApiHelpers.fetchPutWithAuth(
            '/api/posts/put/' + instance['_id'], instance,await getsharedPref('token'));
      } else {
        response =
            await ApiHelpers.fetchPostWithAuth('/api/posts/post', instance,await getsharedPref('token'));
      }
      if (response.statusCode == 200) {
        var message = await getShowLang('CSuccessMessage');
        final snackBar = SnackBar(content: Text(message));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return Postmodel.fromJson(jsonDecode(response.body));
      } else {
        throw (response.statusCode.toString());
      }
    } on SocketException catch (e) {
      Navigator.of(context).pop();
        final snackBar = SnackBar(content: Text(e.osError.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      throw (e);
    } on Exception catch (e) {
      throw (e);
    }
  }

//   Future<void> deletLeaveData(int leaveId, bool isapprove) async {
//     try {
//       if (isapprove == false) {
//         var response =
//             await _apiHelper.deleteData('/api/EmployeeLeaveRequests/', leaveId);
//         if (response.statusCode == 200) {
//           final snackBar = SnackBar(content: Text('Delete successfully'));
//           _globalKey.currentState.showSnackBar(snackBar);
//         } else {
//           throw (response.statusCode.toString());
//         }
//       } else {
//         _globalKey.currentState.showSnackBar(
//             SnackBar(content: Text('You can\'t delete approval leave.')));
//       }
//     } on SocketException catch (e) {
//       Navigator.of(context).pop();
//       _globalKey.currentState
//           .showSnackBar(SnackBar(content: Text(e.osError.toString())));
//       throw (e);
//     } on Exception catch (e) {
//       throw (e);
//     }
//   }
// 
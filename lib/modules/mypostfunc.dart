import 'package:agrifamilyapp/models/postmodel.dart';
import 'package:flutter/material.dart';

// Future<List<PostsModel>> fetchLeaveData() async {
//     try {
//       var response = await _apiHelper.fetchData(
//           '/api/EmployeeLeaveRequests/EmployeeID/' +
//               _apiHelper.employeeID.toString());
//       if (response.statusCode == 200) {
//         var list = jsonDecode(response.body) as List;
//         _listLeave = list.map((i) => EmployeeLeave.fromJson(i)).toList();
//         return _listLeave;
//       } else {
//         throw (response.statusCode.toString());
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
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
// 

// Future<EmployeeLeave> saveLeaveData(int leaveId) async {
//     try {
//       var response;
//       var empId =
//           _employeeId.text == '0' ? _apiHelper.employeeID : _employeeId.text;
//       var body = {
//         'LeaveRequestID': leaveId,
//         'EmployeeID': empId,
//         'FromDate': _fromDate.text,
//         'ToDate': _toDate.text,
//         'NumberOfDays': _numOfDays.text,
//         'NumberOfHours': _numOfHours.text,
//         'IsApproval': false,
//         'Reason': _reasion.text
//       };
//       if (leaveId > 0) {
//         response = await _apiHelper.fetchPut(
//             '/api/EmployeeLeaveRequests/', body, leaveId);
//       } else {
//         response =
//             await _apiHelper.fetchPost1('/api/EmployeeLeaveRequests', body);
//       }
//       if (response.statusCode == 200) {
//         final snackBar = SnackBar(content: Text('Save successfully'));
//         _globalKey.currentState.showSnackBar(snackBar);
//         Navigator.of(context).pop();
//         return leave;
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
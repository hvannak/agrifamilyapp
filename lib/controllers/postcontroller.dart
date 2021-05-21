import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:agrifamilyapp/Helpers/apiHelpers.dart';
import 'package:agrifamilyapp/models/postmodel.dart';
import 'package:agrifamilyapp/modules/mygeneralfunc.dart';
import 'package:flutter/material.dart';

class PostController extends ChangeNotifier  {
  final List<Postmodel> _postList = [];
  int _totalDoc = 0;
  UnmodifiableListView<Postmodel> get items => UnmodifiableListView(_postList);

  void addPost(Postmodel postmodel){
    _postList.add(postmodel);
    notifyListeners();
  }

  void removePost(Postmodel postmodel){
    _postList.remove(postmodel);
  }

  void updatePost(Postmodel postmodel){
    int index = _postList.indexOf(postmodel);
    _postList[index] = postmodel;   
  }

  Future<List<Postmodel>> getPostByPage(BuildContext context,Map<String, dynamic> instance) async {
    try {
      var response = await ApiHelpers.fetchPostWithAuth('/posts/pageclient',instance,await getsharedPref('token'));
      if (response.statusCode == 200) {
        var list = jsonDecode(response.body)['objList'] as List;
        _totalDoc = jsonDecode(response.body)['totalDoc'] as int;
        _postList.addAll(list.map((i) => Postmodel.fromJson(i)).toList());
        return _postList;
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
}
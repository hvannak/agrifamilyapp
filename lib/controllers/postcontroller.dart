import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:agrifamilyapp/Helpers/apiHelpers.dart';
import 'package:agrifamilyapp/models/postimagemodel.dart';
import 'package:agrifamilyapp/models/postmodel.dart';
import 'package:agrifamilyapp/modules/mygeneralfunc.dart';
import 'package:flutter/material.dart';

class PostController extends ChangeNotifier  {
  List<Postmodel> _postList = [];
  List<Postimagemodel> _postImageList = [];
  bool _waiting = false;
  Postmodel? _postmodel;
  int _totalDoc = 0;
  UnmodifiableListView<Postmodel> get postList => UnmodifiableListView(_postList);
  UnmodifiableListView<Postimagemodel> get postImageList => UnmodifiableListView(_postImageList);
  bool get waiting => _waiting;
  Postmodel? get postmodel => _postmodel;


  void addPost(Postmodel postmodel){
    _postList.add(postmodel);
    notifyListeners();
  }

  void removePost(int index){
    _postList.removeAt(index);
    notifyListeners();
  }

  void updatePost(Postmodel postmodel){
    int index = _postList.indexOf(postmodel);
    _postList[index] = postmodel;
    notifyListeners();   
  }

  void removePostImage(int index){
    _postImageList.removeAt(index);
    notifyListeners();
  }

  void addPostImage(Postimagemodel postimagemodel){
    _postImageList.add(postimagemodel);
    notifyListeners();
  }

  void setPost(Postmodel postmodel){
    _postmodel = postmodel;
    notifyListeners();
  }

  void getPostByPage(BuildContext context,Map<String, dynamic> instance) async {
    try {
      _waiting = true;
      var response = await ApiHelpers.fetchPostWithAuth('/posts/pageclient',instance,await getsharedPref('token'));
      if (response.statusCode == 200) {
        var list = jsonDecode(response.body)['objList'] as List;
        _totalDoc = jsonDecode(response.body)['totalDoc'] as int;
        _postList.addAll(list.map((i) => Postmodel.fromJson(i)).toList());
        notifyListeners();
        _waiting = false;
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

  void fetchPostImages(BuildContext context,String postId) async {
    try {
      _waiting = true;
      final response = await ApiHelpers.fetchData('/posts/getImageByPostId/' + postId);
      if (response.statusCode == 200) {
        var list = jsonDecode(response.body) as List;
        _postImageList = list.map((i) => Postimagemodel.fromJson(i)).toList();
        notifyListeners();
        _waiting = false;      
      } else {
        print(response.statusCode.toString());
        _waiting = false;
        throw (response.statusCode.toString());
      }
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      _waiting = false;
      throw (e);
    }
  }

  void savePostData(BuildContext context,Map<String, dynamic> instance) async {
    try {
      _waiting = true;
      var response;
      if (instance['_id'] != null) {
        response = await ApiHelpers.fetchPutWithAuth(
            '/posts/put/' + instance['_id'], instance,await getsharedPref('token'));
      } else {
        response =
            await ApiHelpers.fetchPostWithAuth('/posts/post', instance,await getsharedPref('token'));
      }
      if (response.statusCode == 200) {
        var message = await getShowLang('Message_post_success');
        final snackBar = SnackBar(content: Text(message));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        addPost(Postmodel.fromJson(jsonDecode(response.body)['obj']));
        _waiting = false;
      } else {
        print(response.statusCode);
        final snackBar = SnackBar(content: Text(response.body));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        _waiting = false;
        throw (response.statusCode.toString());
      }
    } on SocketException catch (e) {
      Navigator.of(context).pop();
        final snackBar = SnackBar(content: Text(e.osError.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        _waiting = false;
      throw (e);
    } on Exception catch (e) {
      throw (e);
    }
  }
  
}
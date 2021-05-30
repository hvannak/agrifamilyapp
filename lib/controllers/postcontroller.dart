import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:agrifamilyapp/Helpers/apiHelpers.dart';
import 'package:agrifamilyapp/models/postimagemodel.dart';
import 'package:agrifamilyapp/models/postmodel.dart';
import 'package:agrifamilyapp/modules/myaccountfunc.dart';
import 'package:agrifamilyapp/modules/mygeneralfunc.dart';
import 'package:flutter/material.dart';

class PostController extends ChangeNotifier {
  List<Postmodel> _postList = [];
  List<Postimagemodel> _postImageList = [];
  bool _waiting = true;
  Postmodel? _postmodel;
  int _totalDoc = 0;
  String _message = '';
  UnmodifiableListView<Postmodel> get postList =>
      UnmodifiableListView(_postList);
  UnmodifiableListView<Postimagemodel> get postImageList =>
      UnmodifiableListView(_postImageList);
  bool get waiting => _waiting;
  Postmodel? get postmodel => _postmodel;
  int get totalDoc => _totalDoc;
  String? get message => _message;

  void addPost(Postmodel postmodel) {
    _postList.add(postmodel);
    notifyListeners();
  }

  void removePost(String id) {
    print(id);
    int index = _postList.indexWhere((x) => x.id == id);
    _postList.removeAt(index);
    notifyListeners();
  }

  void updatePost(Postmodel postmodel) {
    int index = _postList.indexWhere((x) => x.id == postmodel.id);
    _postList[index] = postmodel;
    notifyListeners();
  }

  void removePostImage(Postimagemodel postimagemodel) {
    _postImageList.remove(postimagemodel);
    notifyListeners();
  }

  void addPostImage(Postimagemodel postimagemodel) {
    _postImageList.add(postimagemodel);
    notifyListeners();
  }

  void setPost(Postmodel? postmodel) {
    _postmodel = postmodel;
    notifyListeners();
  }

  void resetPost() {
    this._totalDoc = 0;
    this._postList = [];
    this._postImageList = [];
    this._postmodel = null;
    notifyListeners();
  }

  void getPostByPage(
      BuildContext context, Map<String, dynamic> instance) async {
    try {
      _waiting = true;
      var response = await ApiHelpers.fetchPostWithAuth(
          '/posts/pageclient', instance, await getsharedPref('token'));
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
      throw (e);
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
  }

  void fetchPostImages(BuildContext context, String postId) async {
    try {
      _waiting = true;
      final response =
          await ApiHelpers.fetchData('/posts/getImageByPostId/' + postId);
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

  Future<String> addPostData(Map<String, dynamic> instance) async {
    try {
      notifyListeners();
      _waiting = true;
      var response = await ApiHelpers.fetchPostWithAuth(
          '/posts/post', instance, await getsharedPref('token'));
      if (response.statusCode == 200) {
        _waiting = false;
        addPost(Postmodel.fromJson(jsonDecode(response.body)['obj']));
        return _message = await getShowLang('Message_post_success');
      } else {
        _waiting = false;
        return _message = response.body;
      }
    } on SocketException catch (e) {
      _waiting = false;
      return       _message = e.message;
    } on Exception catch (e) {
      _waiting = false;
      return _message = e.toString();
    }
  }

  Future<String> updatePostData(Map<String, dynamic> instance) async {
    try {
      notifyListeners();
      _waiting = true;
      var response = await ApiHelpers.fetchPutWithAuth(
            '/posts/put/' + instance['_id'],
            instance,
            await getsharedPref('token'));
      if (response.statusCode == 200) {
        _waiting = false;
        updatePost(Postmodel.fromJson(jsonDecode(response.body)['obj']));
        return _message = await getShowLang('Message_post_success');
      } else {
        _waiting = false;
        return _message = response.body;
      }
    } on SocketException catch (e) {
      _waiting = false;
      return _message = e.toString();
    } on Exception catch (e) {
      _waiting = false;
      return _message = e.toString();
    }
  }

  Future<String> removePostData(String id) async {
    try {
      notifyListeners();
      _waiting = true;
      var response = await ApiHelpers.deleteData(
            '/posts/delete/',
            id,await getsharedPref('token'));
      if (response.statusCode == 200) {
        _waiting = false;
        removePost(id);
        return _message = await getShowLang('Message_post_success');
      } else {
        _waiting = false;
        return _message = response.body;
      }
    } on SocketException catch (e) {
      _waiting = false;
      return _message = e.toString();
    } on Exception catch (e) {
      _waiting = false;
      return _message = e.toString();
    }
  }
}

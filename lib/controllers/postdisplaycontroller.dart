import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:agrifamilyapp/Helpers/apiHelpers.dart';
import 'package:agrifamilyapp/models/postdisplaymodel.dart';
import 'package:agrifamilyapp/models/postimagemodel.dart';
import 'package:flutter/material.dart';

class PostDisplayController extends ChangeNotifier {
  List<Postdisplaymodel> _listDisplayPost = [];
  List<Postimagemodel> _postImageList = [];
  bool _waiting = true;
  int _totalDoc = 0;
  UnmodifiableListView<Postdisplaymodel> get listDisplayPost =>
      UnmodifiableListView(_listDisplayPost);
  UnmodifiableListView<Postimagemodel> get postImageList =>
      UnmodifiableListView(_postImageList);
  bool get waiting => _waiting;
  int get totalDoc => _totalDoc;

  void resetDisplayPost() {
    this._totalDoc = 0;
    this._listDisplayPost = [];
    this._postImageList = [];
  }



void fetchDisplayPosts(BuildContext context,Map<String, dynamic> instance) async {
    try {
      _waiting = true;
      if(instance['pageOpt']['page'] == 1){
        _listDisplayPost = [];
      }
      final response = await ApiHelpers.fetchPost('/posts/searchByCat', instance);
      if (response.statusCode == 200) {
        var list = jsonDecode(response.body)["objList"] as List;
        _totalDoc = jsonDecode(response.body)["totalDoc"];
        _listDisplayPost.addAll(list.map((i) => Postdisplaymodel.fromJson(i)).toList());
        print(listDisplayPost.length);
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

  Future<Postimagemodel> fetchFirstImagePost(BuildContext context,String postId) async{
    try{
      int index = _postImageList.indexWhere((element) => element.post == postId);
      if(index == -1){
        final response = await ApiHelpers.fetchData('/posts/getFirstImage/' + postId);
        if (response.statusCode == 200) {
          var obj = jsonDecode(response.body);
          Postimagemodel postImage = Postimagemodel.fromJson(obj);
          _postImageList.add(postImage);
          return postImage;
        } else {
          final snackBar = SnackBar(content: Text(response.body));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          print(response.statusCode.toString());
          throw (response.statusCode.toString());
        }
      } else {
        return _postImageList[index];
      }
    }
    on SocketException catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      throw (e);
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
  }

  void fetchSearchDisplayPosts(BuildContext context,Map<String, dynamic> instance) async {
    try {
      print(instance);
      _waiting = true;
      if(instance['pageOpt']['page'] == 1){
        _listDisplayPost = [];
      }
      final response = await ApiHelpers.fetchPost('/posts/searchdetails', instance);
      if (response.statusCode == 200) {
        var list = jsonDecode(response.body)["objList"] as List;
        _totalDoc = jsonDecode(response.body)["totalDoc"];
        _listDisplayPost.addAll(list.map((i) => Postdisplaymodel.fromJson(i)).toList());
        print(listDisplayPost.length);
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

  reInstantiateImageCodec(List<int> bufferData){
    String str = new String.fromCharCodes(bufferData).split(",")[1];
    var base64 = base64Decode(str);  
    return base64;            
  }

  
}

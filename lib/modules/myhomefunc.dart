import 'dart:convert';

import 'package:agrifamilyapp/Helpers/apiHelpers.dart';
import 'package:agrifamilyapp/models/postdisplaymodel.dart';
import 'package:agrifamilyapp/models/postimagemodel.dart';
import 'package:flutter/material.dart';

List<Postdisplaymodel> listDisplayPost = [];
int totalDoc = 0;
bool moreLoad = false;

  Future<List<Postdisplaymodel>> fetchDisplayPosts(BuildContext context,Map<String, dynamic> instance) async {
    try {
      moreLoad = true;
      final response = await ApiHelpers.fetchPost('/posts/searchByCat', instance);
      if (response.statusCode == 200) {
        var list = jsonDecode(response.body)["objList"] as List;
        totalDoc = jsonDecode(response.body)["totalDoc"];
        listDisplayPost.addAll(list.map((i) => Postdisplaymodel.fromJson(i)).toList());
        moreLoad = false;
        print(listDisplayPost.length);
        return listDisplayPost;      
      } else {
        print(response.statusCode.toString());
        throw (response.statusCode.toString());
      }
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      throw (e);
    }
  }

  Future<Postimagemodel> fetchFirstImagePost(BuildContext context,String postId) async{
    try{
      final response = await ApiHelpers.fetchData('/posts/getFirstImage/' + postId);
      if (response.statusCode == 200) {
         var obj = jsonDecode(response.body);
         Postimagemodel postImage = Postimagemodel.fromJson(obj);
        return postImage;
      } else {
        print(response.statusCode.toString());
        throw (response.statusCode.toString());
      }
    }
    catch(e){
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      throw(e);
    }
  }

  reInstantiateImageCodec(List<int> buffer){
    String str = new String.fromCharCodes(buffer).split(",")[1];
    var base64 = base64Decode(str);  
    return base64;            
  }

  resetHomeFunc(BuildContext context) {
  listDisplayPost = [];
  totalDoc = 0;
  moreLoad = false;
}

Future<List<Postdisplaymodel>> fetchSearchDisplayPosts(BuildContext context,Map<String, dynamic> instance) async {
    try {
      moreLoad = true;
      final response = await ApiHelpers.fetchPost('/posts/searchdetails', instance);
      if (response.statusCode == 200) {
        if(instance["pageOpt"]["page"] == 1) {
          listDisplayPost = [];
        }
        var list = jsonDecode(response.body)["objList"] as List;
        totalDoc = jsonDecode(response.body)["totalDoc"];
        listDisplayPost.addAll(list.map((i) => Postdisplaymodel.fromJson(i)).toList());
        moreLoad = false;
        print(listDisplayPost.length);
        return listDisplayPost;      
      } else {
        print(response.statusCode.toString());
        throw (response.statusCode.toString());
      }
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      throw (e);
    }
  }

  Future<Postdisplaymodel> fetchDisplayDetailPostsById(BuildContext context,String postId) async {
    try {
      final response = await ApiHelpers.fetchData('/posts/getById/' + postId);
      if (response.statusCode == 200) {
        var postObj = jsonDecode(response.body);
        Postdisplaymodel postdisplaymodel = Postdisplaymodel.fromJson(postObj);
        return postdisplaymodel;      
      } else {
        print(response.statusCode.toString());
        throw (response.statusCode.toString());
      }
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      throw (e);
    }
  }

  Future<List<Postimagemodel>> fetchPostImages(BuildContext context,String postId) async {
    try {
      final response = await ApiHelpers.fetchData('/posts/getImageByPostId/' + postId);
      if (response.statusCode == 200) {
        var list = jsonDecode(response.body) as List;
        var listPostImages = list.map((i) => Postimagemodel.fromJson(i)).toList();
        return listPostImages;      
      } else {
        print(response.statusCode.toString());
        throw (response.statusCode.toString());
      }
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      throw (e);
    }
  }
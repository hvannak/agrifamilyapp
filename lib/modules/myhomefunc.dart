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
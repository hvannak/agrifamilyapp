import 'dart:convert';

import 'package:agrifamilyapp/Helpers/apiHelpers.dart';
import 'package:agrifamilyapp/models/postdisplaymodel.dart';
import 'package:flutter/material.dart';

List<Postdisplaymodel> _listPost = [];

  fetchDisplayPosts(BuildContext context,Map<String, dynamic> instance) async {
    try {
      // var body = {
      //   'searchObj': 't',
      //   'categoryId': '-1',
      //   'pageOpt': {'itemsPerPage': 9, 'page': 1}
      // };

      // final response = await http.post(
      //     Uri.parse('https://agrifamily.herokuapp.com/api/posts/searchByCat'),
      //     body: json.encode(body),
      //     headers: {HttpHeaders.contentTypeHeader: 'application/json'});

      final response = await ApiHelpers.fetchPost('/posts/searchByCat', instance);

      if (response.statusCode == 200) {
        var list = jsonDecode(response.body)["objList"] as List;
        _listPost.addAll(list.map((i) => Postdisplaymodel.fromJson(i)).toList());      
      } else {
        print(response.statusCode.toString());
        throw (response.statusCode.toString());
      }
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  fetchFirstImagePost(BuildContext context,String postId) async{
    try{
      final response = await ApiHelpers.fetchData('/posts/getFirstImage/' + postId);
      if (response.statusCode == 200) {
        List<dynamic> imagedata = jsonDecode(response.body)["image"]["data"];
      }
    }
    catch(e){
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  reInstantiateImageCodec(List<int> buffer){
    String str = new String.fromCharCodes(buffer).split(",")[1];
    var base64 = base64Decode(str);  
    return base64;            
  }
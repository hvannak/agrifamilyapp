import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:agrifamilyapp/models/postdisplaymodel.dart';
import 'package:agrifamilyapp/models/postmodel.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;


class Myhome extends StatefulWidget {
  @override
  _MyhomeState createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  List<Postdisplaymodel> _listPost = [];
  List<Postmodel> _listPostImage = [];

  fetchPosts() async {
    try {
      var body = {
        'searchObj': 't',
        'categoryId': '-1',
        'pageOpt': {'itemsPerPage': 9, 'page': 1}
      };

      final response = await http.post(
          Uri.parse('https://agrifamily.herokuapp.com/api/posts/searchByCat'),
          body: json.encode(body),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'});

      if (response.statusCode == 200) {
        print(response.body);
        // var list = jsonDecode(response.body)["objList"] as List;
        // _listPost = list.map((i) => Postdisplaymodel.fromJson(i)).toList();
        var jsonData = jsonDecode(response.body)["objList"] as List;
        for (var i = 0; i < jsonData.length; i++) {
          final response1 = await http.get(
          Uri.parse('https://agrifamily.herokuapp.com/api/posts/getFirstImage/' + jsonData[i]["_id"]),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'});
          if(response1.statusCode == 200){
            try{
              List<dynamic> imagedata = jsonDecode(response1.body)["image"]["data"];
              jsonData[i]["firstimage"] = imagedata;

              _listPost.add(Postdisplaymodel.fromJson(jsonData[i]));              
            } catch(e){
              print(e);
            }
          }
          print('list length:' + _listPost.length.toString());
        }

        return _listPost;
      } else {
        throw Exception('Failed to load post');
      }
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  reInstantiateImageCodec(List<int> buffer){
    Uint8List listdata = Uint8List.fromList(buffer);
    var reduce = listdata.reduce((value, element) => value+element);
    return reduce;
    // String str = new String.fromCharCodes(listdata);
    // String removeMine = str.split(",")[1];
    // print(removeMine);
    // return new Uint8List.fromList(removeMine.codeUnits);              
  }

  fetchFirstImage() async {
    try {
      final response = await http.get(
          Uri.parse('https://agrifamily.herokuapp.com/api/posts/getFirstImage/' + "6067be61e0a52c0022ea1916"),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      if (response.statusCode == 200) {
        var list = jsonDecode(response.body) as List;
        // _listPostImage = list.map((i) => ImageData.fromJson(i)).toList();
        // print(_listPostImage[1].image);
        return _listPostImage;
        // return _listPostImage.add(ImageData.fromJson(jsonDecode(response.body)[0]));
      } else {
        throw Exception('Failed to load post');
      }
    } catch (e) {
      print(e);
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.home),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      body: Container(
        child: FutureBuilder(
      future: fetchPosts(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Container(
              child: Center(
                  child: SizedBox(
            child: CircularProgressIndicator(),
            width: 60,
            height: 60,
          )));
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Card(
                          child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Image.memory(reInstantiateImageCodec(snapshot.data[index].firstimage)),
                              ListTile(
                                leading: Icon(Icons.album),
                                title: Text(snapshot.data[index].title),
                                subtitle: Text(snapshot.data[index].description),
                              ),
                            ],
                          ),
                        )),
                      )
                    ],
                  ));
            },
          );
        }
      },
    )
    ),
    );
    
  }
}

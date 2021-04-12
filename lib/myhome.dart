import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:agrifamilyapp/models/post.dart';
import 'package:agrifamilyapp/models/postimage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Myhome extends StatefulWidget {
  @override
  _MyhomeState createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  List<PostModel> _listPost = [];

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
        // var list = jsonDecode(response.body)["objList"] as List;
        // _listPost = list.map((i) => PostModel.fromJson(i)).toList();
        var jsonData = jsonDecode(response.body)["objList"] as List;
        for (var i = 0; i < jsonData.length; i++) {
          final response1 = await http.get(
          Uri.parse('https://agrifamily.herokuapp.com/api/posts/getImageByPostId/' + jsonData[i]["_id"]),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'});
          if(response1.statusCode == 200){
            // var postImage = PostImageModel.fromJson(jsonDecode(response1.body)[0]);
            // print('post'+ postImage.post);
            print('print');
            // var bytes = new Uint8Array(imagedata.data);
            // var binary = bytes.reduce(
            //   (data, b) => (data += String.fromCharCode(b)),
            //   ""
            // );
            try{
              var imagedata = jsonDecode(response1.body)[0]["image"]["data"];
              print(imagedata);
              Uint8List listdata = Uint8List.fromList((imagedata as List)?.map((e) => e as int)?.toList());
              print(listdata);
              // Uint8List imageblob = Base64Codec().decode(imagedata);
              // var bytes = imagedata.buffer.asUint8List();
              _listPost.add(PostModel.fromJson(jsonData[i], listdata));
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
      final snackBar = SnackBar(content: Text(e));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  fetchFirstImage(postId) async {
    try {
      final response = await http.get(
          Uri.parse('http://192.168.100.67:3000/api/posts/getImageByPostId/' + postId),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      if (response.statusCode == 200) {
        print(jsonDecode(response.body)[0]);
        return PostImageModel.fromJson(jsonDecode(response.body)[0]);
      } else {
        throw Exception('Failed to load post');
      }
    } catch (e) {
      final snackBar = SnackBar(content: Text(e));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    // return TextButton(
    //   style: ButtonStyle(
    //     foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
    //   ),
    //   onPressed: () async {
    //     fetchPosts();
    //   },
    //   child: Text('TextButton'),
    // );

    return Container(
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
                              // Image.network(
                              //   'https://cdn.vuetifyjs.com/images/logos/vuetify-logo-dark.png',
                              //   fit: BoxFit.contain,
                              //   width: 100,
                              // ),
                              Image.memory(snapshot.data[index].firstimage),
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
    ));
  }
}

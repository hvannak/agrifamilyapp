import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:agrifamilyapp/models/postdisplaymodel.dart';
import 'package:agrifamilyapp/models/postmodel.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'Helpers/constants.dart';


class Myhome extends StatefulWidget {
  @override
  _MyhomeState createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  List<Postdisplaymodel> _listPost = [];

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
    String str = new String.fromCharCodes(buffer).split(",")[1];
    var base64 = base64Decode(str);  
    return base64;            
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
                  color: Colors.grey,
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
                              Stack(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: Image.memory(reInstantiateImageCodec(snapshot.data[index].firstimage),
                                    fit: BoxFit.cover,
                                    height: 180,),
                                  ),
                                  Positioned(
                                    top: -20,
                                    right: 10,
                                    child: Container(
                                    alignment: Alignment.topRight,
                                    child: CircleAvatar(                                  
                                    child: ClipOval(
                                      child:Text(snapshot.data[index].price.toString() + " " + snapshot.data[index].currency,
                                      style: headertextStyle),
                                    ),
                                    radius: 50,
                                    backgroundColor: Colors.lightGreen,
                                  ),
                                  ))
                                ],
                              ),                     
                              ListTile(
                                leading: Icon(Icons.info,color: Colors.green,),
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
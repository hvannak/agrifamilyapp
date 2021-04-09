import 'dart:convert';
import 'dart:io';

import 'package:agrifamilyapp/models/post.dart';
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
          Uri.parse('http://192.168.100.67:3000/api/posts/searchByCat'),
          body: json.encode(body),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'});

      if (response.statusCode == 200) {
        var list = jsonDecode(response.body)["objList"] as List;
        _listPost = list.map((i) => PostModel.fromJson(i)).toList();
        return _listPost;
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
                              Image.network(
                                'https://cdn.vuetifyjs.com/images/logos/vuetify-logo-dark.png',
                                fit: BoxFit.contain,
                                width: 100,
                              ),
                              ListTile(
                                leading: Icon(Icons.album),
                                title: Text(snapshot.data[index].title),
                                subtitle: Text(
                                    'Music by Julie Gable. Lyrics by Sidney Stein.'),
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

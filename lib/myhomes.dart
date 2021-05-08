import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:agrifamilyapp/Widgets/mainwidget.dart';
import 'package:agrifamilyapp/Widgets/myhomewidget.dart';
import 'package:agrifamilyapp/models/pageobjmodel.dart';
import 'package:agrifamilyapp/models/pageoptmodel.dart';
import 'package:agrifamilyapp/models/postdisplaymodel.dart';
import 'package:agrifamilyapp/models/postmodel.dart';
import 'package:agrifamilyapp/modules/myhomefunc.dart';
import 'package:agrifamilyapp/myhomesearch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'Helpers/constants.dart';
import 'Widgets/controlswidget.dart';


class Myhome extends StatefulWidget {
  @override
  _MyhomeState createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  late ScrollController _controller;
  late Future<List<Postdisplaymodel>> _future;
  int _currentPage = 1;
  int _pageSize = 6;
  late Pageobjmodel _pageObjModel;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      _scrollListener();
    });
    _pageObjModel = new Pageobjmodel(null, null,"-1",
        new Pageoptmodel(_currentPage, _pageSize, ['date'], [true]));
    _future = fetchDisplayPosts(context, _pageObjModel.toJson());
    super.initState();
  }

  _scrollListener() async {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      print('reach the bottom');
      _currentPage += 1;
      _pageObjModel = new Pageobjmodel(null, null,"-1",
          new Pageoptmodel(_currentPage, _pageSize, ['date'], [true]));
      var totalPage = (totalDoc / _pageSize).ceil();
      if (_currentPage <= totalPage) {
        setState(() {
          _future = fetchDisplayPosts(context, _pageObjModel.toJson());
        });
      }
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      print('reach the top');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(     
      body: Container(
        child: FutureBuilder(
      future: _future,
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
            controller: _controller,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              if (moreLoad && index == listDisplayPost.length - 1) {
                return CupertinoActivityIndicator();
              }
              return Container(
                  height: 300,
                  color: Colors.white70,
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
                                    height: 180,
                                    child: FutureBuilder(
                                      future: fetchFirstImagePost(context,snapshot.data[index].id),
                                      builder: (BuildContext context, AsyncSnapshot snapshot1) {
                                        if (snapshot1.data == null) {
                                          return Container(
                                              child: Center(
                                                  child: SizedBox(
                                            child: CircularProgressIndicator(),
                                            width: 20,
                                            height: 20,
                                          )));
                                        } else {
                                          return Image.memory(reInstantiateImageCodec(snapshot1.data.image.data),fit: BoxFit.cover,);
                                        }
                                      },
                                    ),
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
    floatingActionButton: FloatingActionButton(
        key: UniqueKey(),
        heroTag: 'btnSearch',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Myhomesearch()),
          );
        },                 
        child: Icon(Icons.search_rounded),
        backgroundColor: Colors.green,
      )
    );
    
  }
}
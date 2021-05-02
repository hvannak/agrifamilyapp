import 'package:agrifamilyapp/models/pageobjmodel.dart';
import 'package:agrifamilyapp/models/pageoptmodel.dart';
import 'package:agrifamilyapp/models/postmodel.dart';
import 'package:agrifamilyapp/modules/mypostfunc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class MyPosts extends StatefulWidget {
  @override
  _MyPostsState createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  late ScrollController _controller;
  late Future<List<Postmodel>> _future;
  int _currentPage = 1;
  int _pageSize = 7;
  late Pageobjmodel _pageObjModel;
  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(() {
      _scrollListener();
    });
    _pageObjModel = new Pageobjmodel(null,null,new Pageoptmodel(
      _currentPage,_pageSize,['title'],[false]
    ));
    _future = getByPage(context, _pageObjModel.toJson());
  }

  _scrollListener() async {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      print('reach the bottom');
      _currentPage +=1;
      _pageObjModel = new Pageobjmodel(null,null,new Pageoptmodel(
        _currentPage,_pageSize,['title'],[false]
      ));
      var totalPage = (totalDoc/_pageSize).ceil();
      if(_currentPage <= totalPage){
        setState(() {
          _future = getByPage(context,_pageObjModel.toJson());
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
    return Container(
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
            physics: AlwaysScrollableScrollPhysics(),          
            itemCount: snapshot.data.length,           
            itemBuilder: (BuildContext context, int index) {
              if(moreLoad && index == listPost.length -1){
                return CupertinoActivityIndicator();
              }
              return Container(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Card(
                        shadowColor: Colors.blue,
                        child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.album),
                              title: Text(snapshot.data[index].title),
                              subtitle: Text(snapshot.data[index].location),
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
import 'package:agrifamilyapp/controllers/postcontroller.dart';
import 'package:agrifamilyapp/models/pageobjmodel.dart';
import 'package:agrifamilyapp/models/pageoptmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyPosts extends StatefulWidget {
  @override
  _MyPostsState createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
    int _currentPage = 1;
  int _pageSize = 7;
  late Pageobjmodel _pageObjModel;

  @override
  void initState() {
    _pageObjModel = new Pageobjmodel(null, null, null,
        new Pageoptmodel(_currentPage, _pageSize, ['title'], [false]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<PostController>(context).getPostByPage(context, _pageObjModel.toJson());
    print(appState);
    return Scaffold(
      appBar:AppBar(
        leading: Icon(Icons.data_usage),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      body:Container(

      ) ,
    );
  }
}
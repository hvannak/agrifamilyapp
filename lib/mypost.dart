import 'dart:convert';
import 'dart:io';

import 'package:agrifamilyapp/Helpers/constants.dart';
import 'package:agrifamilyapp/Widgets/Callback/mybuttoncallback.dart';
import 'package:agrifamilyapp/Widgets/mainwidget.dart';
import 'package:agrifamilyapp/Widgets/mycategorywidget.dart';
import 'package:agrifamilyapp/imagefiles.dart';
import 'package:agrifamilyapp/main.dart';
import 'package:agrifamilyapp/models/pageobjmodel.dart';
import 'package:agrifamilyapp/models/pageoptmodel.dart';
import 'package:agrifamilyapp/models/postimagemodel.dart';
import 'package:agrifamilyapp/models/postmodel.dart';
import 'package:agrifamilyapp/modules/mycategoryfunc.dart';
import 'package:agrifamilyapp/modules/mymainfunc.dart';
import 'package:agrifamilyapp/modules/mypostfunc.dart';
import 'package:agrifamilyapp/takephoto.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Widgets/controlswidget.dart';

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
    _pageObjModel = new Pageobjmodel(null, null, null,
        new Pageoptmodel(_currentPage, _pageSize, ['title'], [false]));
    _future = getByPage(context, _pageObjModel.toJson());
  }

  _scrollListener() async {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      print('reach the bottom');
      _currentPage += 1;
      _pageObjModel = new Pageobjmodel(null, null, null,
          new Pageoptmodel(_currentPage, _pageSize, ['title'], [false]));
      var totalPage = (totalDoc / _pageSize).ceil();
      if (_currentPage <= totalPage) {
        setState(() {
          _future = getByPage(context, _pageObjModel.toJson());
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
      appBar: AppBar(
        leading: Icon(Icons.data_usage),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
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
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                if (moreLoad && index == listPost.length - 1) {
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
                                      subtitle:
                                          Text(snapshot.data[index].location),
                                      onTap: () async {
                                        Postmodel? modelObj = snapshot.data[index];
                                        List<Postimagemodel> imgList = await fetchPostImages(context,snapshot.data[index].id);                                    
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => MyEditPosts(modelObj!,imgList)),
                                        ); 
                                      },
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
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyEditPosts(null,[])),
          );
        },
        child: const Icon(Icons.navigation),
        backgroundColor: Colors.green,
      ),
    );
  }

  static Route<Object?> _dialogBuilder(BuildContext context, Object? arguments) {
  return DialogRoute<void>(
    context: context,
    builder: (BuildContext context) => const AlertDialog(title: Text('Material Alert!')),
  );
}
}

//My Edit Post
class MyEditPosts extends StatefulWidget {
  final Postmodel? postmodel;
  final List<Postimagemodel> postimageList;
  MyEditPosts(this.postmodel,this.postimageList);
  @override
  _MyEditPostsState createState() => _MyEditPostsState();
}

class _MyEditPostsState extends State<MyEditPosts> {
  final _formKeymodify = GlobalKey<FormState>();
  String? _id;
  var _title = TextEditingController();
  var _description = TextEditingController();
  var _phone = TextEditingController();
  var _email = TextEditingController();
  var _location = TextEditingController();
  var _price = TextEditingController();
  List<String> _listImage = [];
  List<Postimagemodel> _listRemoveImage = [];  
  bool _waiting = false;
  String _currency = "៛";
  List<String> listCurrency = ['៛', '\$'];
  Future<List<String>> getCurrencyList() async {
    return listCurrency;
  }

  void _onItemTapped(int index) {
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              MyHomePage(key: UniqueKey(), title: title, index: index)),
    );
  }

  @override
  void initState() {
    print(widget.postmodel!.phone);
    if (widget.postmodel != null) {
      _id = widget.postmodel!.id;
      category = widget.postmodel!.category;
      _title.text = widget.postmodel!.title;
      _description.text = widget.postmodel!.description;
      _phone.text = widget.postmodel!.phone!;
      _email.text = widget.postmodel!.email != null ? widget.postmodel!.email! : '';
      _location.text = widget.postmodel!.location!;
      _price.text = widget.postmodel!.price.toString();
      _currency = widget.postmodel!.currency;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: buildText('NewItem', headertextStyle),
      ),
      body: Container(
          child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Card(
                  elevation: 10,
                  child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Stack(
                        children: [
                          Form(
                              key: _formKeymodify,
                              child: Column(
                                children: [
                                  buildControlDropdownCategory(
                                      context,
                                      'Category',
                                      fetchCategoryLang(context, false),
                                      Icons.category),
                                  buildControl(context, 'Title', _title,
                                      Icons.title, false, true),
                                  buildControlMultiLine(context, 'Description',
                                      _description, Icons.text_fields),
                                  buildControl(context, 'Phone', _phone,
                                      Icons.phone, false, true),
                                  buildControl(context, 'Email', _email,
                                      Icons.email, false, true),
                                  buildControl(context, 'Location', _location,
                                      Icons.location_city, false, true),
                                  buildControl(context, 'Price', _price,
                                      Icons.money, false, true),
                                  buildControlDropdownTF(
                                      context,
                                      'Currency',
                                      _currency,
                                      getCurrencyList(),
                                      Icons.money_sharp),
                                  Center(
                                      child: MyButtonCallback(
                                          myPress: _saveData,
                                          labelText: 'Save'))
                                ],
                              )),
                          Visibility(
                              visible: _waiting,
                              child: Container(
                                alignment: Alignment.center,
                                child: Center(
                                  heightFactor: 8,
                                  child: SizedBox(
                                child: CircularProgressIndicator(),
                                width: 60,
                                height: 60,
                              )),
                              ))
                        ],
                      ))))),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              key: UniqueKey(),
              heroTag: 'btnCamera',
              onPressed: () async {
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ImageFiles(widget.postimageList)),
                );
                if (result != null) {
                  _listImage = result[0];
                  _listRemoveImage = result[1];
                }
              },
              child: Icon(Icons.camera_alt),
              backgroundColor: Colors.green,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: widgetBottomNav,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  void _saveData() async {
    if(_waiting == false){
      setState(() {
        _waiting = true;
      });
      Postmodel postmodel = Postmodel(
          _id,
          category,
          null,
          _title.text,
          _description.text,
          _phone.text,
          _email.text,
          _location.text,
          int.parse(_price.text),
          _currency,
          _listImage,_listRemoveImage);
      await savePostData(context, postmodel.toJson());
      setState(() {
        _waiting = false;
      });
      Navigator.of(context).pop();
    }
  }
}

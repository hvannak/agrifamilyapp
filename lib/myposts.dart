import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:agrifamilyapp/Helpers/constants.dart';
import 'package:agrifamilyapp/Widgets/Callback/mybottomnavcallback.dart';
import 'package:agrifamilyapp/Widgets/Callback/mybuttoncallback.dart';
import 'package:agrifamilyapp/Widgets/controlswidget.dart';
import 'package:agrifamilyapp/Widgets/mycategorywidget.dart';
import 'package:agrifamilyapp/controllers/pagecontroller.dart';
import 'package:agrifamilyapp/controllers/postcontroller.dart';
import 'package:agrifamilyapp/main.dart';
import 'package:agrifamilyapp/models/imagedatamodel.dart';
import 'package:agrifamilyapp/models/pageobjmodel.dart';
import 'package:agrifamilyapp/models/pageoptmodel.dart';
import 'package:agrifamilyapp/models/postimagemodel.dart';
import 'package:agrifamilyapp/models/postmodel.dart';
import 'package:agrifamilyapp/modules/mycategoryfunc.dart';
import 'package:agrifamilyapp/modules/mymainfunc.dart';
import 'package:agrifamilyapp/modules/mygeneralfunc.dart';
import 'package:agrifamilyapp/mypostsearch.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MyPosts extends StatefulWidget {
  @override
  _MyPostsState createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  int _currentPage = 1;
  late ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      _scrollListener();
    });
    var pageProvider = Provider.of<PagesController>(context,listen: false); 
    var provider = Provider.of<PostController>(context, listen: false);
    provider.getPostByPage(context, pageProvider.pageobjmodel!.toJson());
    super.initState();
  }

  _scrollListener() async {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      print('reach the bottom');
      _currentPage += 1;
      var pageProvider = Provider.of<PagesController>(context,listen: false);
      pageProvider.setCurrenctPage(_currentPage);
      var provider = Provider.of<PostController>(context,listen: false);
      var totalPage = ( provider.totalDoc/ pageProvider.pageSize).ceil();
      if (_currentPage <= totalPage) {
        provider.getPostByPage(context, pageProvider.pageobjmodel!.toJson());
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
          IconButton(icon: Icon(Icons.search), onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyPostSearch()),
          );
          })
        ],
      ),
      body: Consumer<PostController>(
        builder: (_, notify, __) {
          if (notify.waiting) {
            return Container(
                child: Center(
                    child: SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            )));
          }
          return ListView.builder(
            controller: _controller,
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: notify.postList.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: UniqueKey(),
                onDismissed:(direction) async {
                 await notify.removePostData(notify.postList[index].id!);
                }, 
                background: Container(color: Colors.red),
                child: Container(
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
                                    title: Text(notify.postList[index].title),
                                    subtitle:
                                        Text(notify.postList[index].location!),
                                    onTap: () {
                                      Provider.of<PostController>(context,
                                              listen: false)
                                          .fetchPostImages(context,
                                              notify.postList[index].id!);
                                      notify.setPost(notify.postList[index]);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MyEditPost(true)),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )),
                      )
                    ],
                  ))
              );              
              
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<PostController>(context,listen: false).setPost(null);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyEditPost(false)),
          );
        },
        child: const Icon(Icons.navigation),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class MyEditPost extends StatefulWidget {
  final bool editmode;
  MyEditPost(this.editmode);
  @override
  _MyEditPostState createState() => _MyEditPostState();
}

class _MyEditPostState extends State<MyEditPost> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
    var post = Provider.of<PostController>(context,listen: false).postmodel;
    if ( post != null) {
        _id = post.id;
        category = post.category;
        _title.text = post.title;
        _description.text = post.description;
        _phone.text = post.phone!;
        _email.text = post.email != null ? post.email! : '';
        _location.text = post.location!;
        _price.text = post.price.toString();
        _currency = post.currency;
      }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: (widget.editmode)
            ? buildText('EditItem', headertextStyle)
            : buildText('NewItem', headertextStyle),
      ),
      body: Consumer<PostController>(builder: (_, notify, __) {
        return Container(
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
                                    buildControlMultiLine(
                                        context,
                                        'Description',
                                        _description,
                                        Icons.text_fields),
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
                                visible: notify.waiting,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Center(
                                      heightFactor: 7,
                                      child: SizedBox(
                                        child: CircularProgressIndicator(),
                                        width: 60,
                                        height: 60,
                                      )),
                                ))
                          ],
                        )))));
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              key: UniqueKey(),
              heroTag: 'btnimage',
              onPressed: () async {
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyImageFiles(widget.editmode)),
                );
                if (result != null) {
                  _listImage = result[0];
                  _listRemoveImage = result[1];
                }
              },
              child: Icon(Icons.attach_file),
              backgroundColor: Colors.green,
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavCallback(onItemTapped: _onItemTapped),
    );
  }

  void _saveData() async {
    if (_formKeymodify.currentState!.validate()){
      Postmodel postmodel = Postmodel(
          _id,
          category,
          null,
          _title.text,
          _description.text,
          _phone.text,
          _email.text,
          _location.text,
          double.parse(_price.text),
          _currency,
          _listImage,
          _listRemoveImage);
      var provider = Provider.of<PostController>(context,listen: false);
      if(_id == null){
        await provider.addPostData(postmodel.toJson());
      }
      else {
        await provider.updatePostData(postmodel.toJson());
      }
      final snackBar = SnackBar(content: Text(provider.message!));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context).pop();
    }
    else {
      print('Invalid Data');
    }     
  }
}

class MyImageFiles extends StatefulWidget {
  final bool editmode;
  MyImageFiles(this.editmode);
  @override
  _MyImageFilesState createState() => _MyImageFilesState();
}

class _MyImageFilesState extends State<MyImageFiles> {
  List<String> _listBase64 = [];
  List<Postimagemodel> _listRemove = [];
  final picker = ImagePicker();

  @override
  void initState() {
    var provider = Provider.of<PostController>(context,listen:false);
    if(provider.postImageList.length > 0){
      for (var item in provider.postImageList) {
        if(item.id == null ){
          var fileBuffer = "data:image/png;base64," + base64Encode(item.image!.data);
          _listBase64.add(fileBuffer);
        }
      }
    }
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pop(null);
          },
        ),
        title: buildText('Fileinput', headertextStyle),
      ),
        body: Consumer<PostController>(builder: (_,notify,__){
          return SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 400,
                  child: GridView.builder(
                    itemCount: notify.postImageList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
                    itemBuilder: (BuildContext context,int index){                    
                      return Stack(
                        children: [
                          Card(                
                            child: Image.memory(Uint8List.fromList(reInstantiateImagesCodec(notify.postImageList[index].image!.data)),fit: BoxFit.cover,)
                          ),
                          InkWell(
                            child: Container(
                            alignment: Alignment.topRight,
                            child: CircleAvatar(
                            child: Icon(Icons.delete_forever),
                          ),
                          ),
                          onTap: (){
                            _listRemove.add(Postimagemodel(notify.postImageList[index].id, null, notify.postImageList[index].post));
                            notify.removePostImage(notify.postImageList[index]);
                          },
                          )
                        ],
                      );
                    }
                  ),                   
                ),
                InkWell(
                  child: CircleAvatar(
                    child: ClipOval(
                      child: Icon(Icons.camera_alt),
                    ),
                  ),
                  onTap: () {
                    getImageFromSource(true);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  child: CircleAvatar(
                    child: ClipOval(
                      child: Icon(Icons.file_upload),
                    ),
                  ),
                  onTap: () {
                    getImageFromSource(false);
                  },
                ),
                Center(
                  child: MyButtonCallback(
                      myPress: _keepImageFiles, labelText: 'Fileinput'))
              ],
            ),
          ),
        );
        }));
        
  }

  void _keepImageFiles(){
    if(_listBase64.length > 0 || _listRemove.length > 0){
      Navigator.of(context).pop([_listBase64,_listRemove]);
    }
  }

  Future getImageFromSource(bool camera) async {  
    final pickedFile = (camera) ? await picker.getImage(
        source: ImageSource.camera,
        maxHeight: 180,
        imageQuality: 70
      ) : await picker.getImage(
        source: ImageSource.gallery,
        maxHeight: 180,
        imageQuality: 70
      ) ;
    if (pickedFile != null) {
        File imagefile = new File(pickedFile.path);
        List<int> imageBytes = imagefile.readAsBytesSync();
        var fileBuffer = "data:image/png;base64," + base64Encode(imageBytes);
        _listBase64.add(fileBuffer);
        Provider.of<PostController>(context,listen:false).addPostImage(Postimagemodel(null,Imagedatamodel('buffer',imageBytes), null));
      } else {
        print('No image selected.');
      }
  }

}
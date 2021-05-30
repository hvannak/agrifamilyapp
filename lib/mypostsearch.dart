import 'package:agrifamilyapp/Helpers/constants.dart';
import 'package:agrifamilyapp/Widgets/Callback/mybuttoncallback.dart';
import 'package:agrifamilyapp/Widgets/controlswidget.dart';
import 'package:agrifamilyapp/Widgets/mypostwidget.dart';
import 'package:agrifamilyapp/controllers/pagecontroller.dart';
import 'package:agrifamilyapp/controllers/postcontroller.dart';
import 'package:agrifamilyapp/main.dart';
import 'package:agrifamilyapp/models/pageobjmodel.dart';
import 'package:agrifamilyapp/models/pageoptmodel.dart';
import 'package:agrifamilyapp/models/searchpostmodel.dart';
import 'package:agrifamilyapp/modules/mycategoryfunc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Widgets/Callback/mybottomnavcallback.dart';
import 'modules/mymainfunc.dart';

class MyPostSearch extends StatefulWidget {
  @override
  _MyPostSearchState createState() => _MyPostSearchState();
}

class _MyPostSearchState extends State<MyPostSearch> {
  final _formKeymodify = GlobalKey<FormState>();
  var _searchObj = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        title: buildText('Detail_search_data',headertextStyle)
      ),
      body: Container(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Form(
                key: _formKeymodify,
                child: Column(
                  children: [
                    buildControlDropdownPostSearch(context,'Searchby',
                                        Icons.filter_hdr),
                    buildControl(context, 'Searchdata', _searchObj,
                                        Icons.search_rounded,false, true),
                    Center(
                      child: MyButtonCallback(
                          myPress: _searchData,
                          labelText: 'Searchdata'))
                  ],
                )
              )
            ),
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavCallback(onItemTapped: _onItemTapped),
    );
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

  void _searchData(){
    var pageProvider = Provider.of<PagesController>(context,listen: false);
    pageProvider.setPage(1,_searchObj.text,searchBy,null);
    var provider = Provider.of<PostController>(context, listen: false);
    provider.resetPost();
    provider.getPostByPage(context, pageProvider.pageobjmodel!.toJson());
    Navigator.of(context).pop();
  }
}
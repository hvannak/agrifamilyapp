
import 'package:agrifamilyapp/models/searchpostmodel.dart';

import 'package:agrifamilyapp/myhomesearch.dart';
import 'package:agrifamilyapp/mypostdetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Helpers/constants.dart';
import 'controllers/pagecontroller.dart';
import 'controllers/postdisplaycontroller.dart';

class Myhome extends StatefulWidget {
  @override
  _MyhomeState createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  late ScrollController _controller;
  int _currentPage = 1;
  String _heroTag = "btnSearch";
  int _heroTagIndex = 1;
  late Searchpostmodel _isSearching;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      _scrollListener();
    });
    var pageProvider = Provider.of<PagesController>(context,listen: false); 
    var provider = Provider.of<PostDisplayController>(context, listen: false);
    provider.fetchDisplayPosts(context, pageProvider.pageobjmodel!.toJson());
    super.initState();
  }

  _scrollListener() async {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      print('reach the bottom');
      _currentPage += 1;
      var pageProvider = Provider.of<PagesController>(context,listen: false);
      pageProvider.setCurrenctPage(_currentPage);
      var provider = Provider.of<PostDisplayController>(context,listen: false);
      var totalPage = ( provider.totalDoc/ pageProvider.pageSize).ceil();
      if (_currentPage <= totalPage) {
        provider.fetchDisplayPosts(context, pageProvider.pageobjmodel!.toJson());
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
      body: Consumer<PostDisplayController>(
        builder:(_,notify,__){
          if(notify.waiting){
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
            itemCount: notify.listDisplayPost.length,
            itemBuilder: (BuildContext context, int index) {
              Provider.of<PostDisplayController>(context, listen: false).fetchFirstImagePost(context, notify.listDisplayPost[index].id!);
              return Container(
                height: 300,
                color: Colors.white70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 180,
                                    child: FutureBuilder(
                                      future: notify.fetchFirstImagePost(context, notify.listDisplayPost[index].id!),
                                      builder: (BuildContext context,AsyncSnapshot snapshot){
                                        if (snapshot.data == null) {
                                          return Container(
                                              child: Center(
                                                  child: SizedBox(
                                            child:
                                                CircularProgressIndicator(),
                                            width: 20,
                                            height: 20,
                                          )));
                                        } else {
                                          return Image.memory(
                                            notify.reInstantiateImageCodec(
                                                snapshot.data.image.data),
                                            fit: BoxFit.cover,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  Positioned(
                                    top: -20,
                                    right: 10,
                                    child: Container(
                                      alignment: Alignment.topRight,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => MyPostDetails(notify.listDisplayPost[index])),
                                          );
                                        },
                                        child: CircleAvatar(
                                          child: ClipOval(
                                            child: Text(
                                              notify.listDisplayPost[index].price.toString() + " " + notify.listDisplayPost[index].currency,
                                              style: labeltextStyle,
                                            ),                                          
                                          ),
                                          radius: 50,
                                          backgroundColor: Colors.green,
                                        ),
                                      ),
                                    )
                                  )
                                ],
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.info,
                                  color: Colors.green,
                                ),
                                title: Text(notify.listDisplayPost[index].title),
                                subtitle:
                                    Text(notify.listDisplayPost[index].category.title),
                              ),
                            ],
                          ),
                        ),
                      )
                    )
                  ],
                ),
              );
            }
          );
        } ,
      ),
      floatingActionButton: FloatingActionButton(
          key: UniqueKey(),
          heroTag: _heroTag,
          onPressed: () async {
            _isSearching = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Myhomesearch()),
            );
              if (_isSearching.category != null) {
                var pageProvider = Provider.of<PagesController>(context,listen: false);
                var provider = Provider.of<PostDisplayController>(context,listen: false);
                _currentPage = 1;
                pageProvider.setPage(_currentPage, null, _isSearching, null, _isSearching.category);
              setState(() {
                _heroTagIndex += 1;
                _heroTag = "btnSearching" + _heroTagIndex.toString();
                provider.fetchSearchDisplayPosts(context, pageProvider.pageobjmodel!.toJson());
              });
            }
          },
          child: Icon(Icons.search_rounded),
          backgroundColor: Colors.green,
        )
    );
  }
}

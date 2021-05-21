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
  bool _waiting = false;
  late ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
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
        child: Consumer<PostController>(
          builder: (context, post, child) {
            return Stack(
              children: [
                ListView.builder(
                  controller: _controller,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: post.postList.length,
                  itemBuilder: (BuildContext context, int index) {
                    // if (moreLoad && index == listPost.length - 1) {
                    //   return CupertinoActivityIndicator();
                    // }
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
                                          title:
                                              Text(post.postList[index].title),
                                          subtitle: Text(
                                              post.postList[index].location!),
                                          onTap: () async {
                                            // setState(() {
                                            //   _waiting = true;
                                            // });
                                            // Postmodel? modelObj =
                                            //     snapshot.data[index];
                                            // List<Postimagemodel> imgList =
                                            //     await fetchPostImages(context,
                                            //         snapshot.data[index].id);
                                            // setState(() {
                                            //   _waiting = false;
                                            // });
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           MyEditPosts(
                                            //               modelObj!, imgList,true)),
                                            // );
                                          },
                                        ),
                                      ],
                                    ),
                                  )),
                            )
                          ],
                        ));
                  },
                ),
                Visibility(
                    visible: _waiting,
                    child: Container(
                        child: Center(
                            child: SizedBox(
                      child: CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    ))))
              ],
            );
          },
        )
      ) ,
    );
  }
}
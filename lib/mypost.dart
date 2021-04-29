import 'package:flutter/material.dart';

class MyPosts extends StatefulWidget {
  @override
  _MyPostsState createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  ScrollController _controller; 

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(() {
      _scrollListener();
    });
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      print('reach the bottom');
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
      future: fetchFirstImage(),
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
                              // ListTile(
                              //   leading: Icon(Icons.album),
                              //   title: Text(snapshot.data[index].title),
                              //   subtitle: Text(snapshot.data[index].description),
                              // ),
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
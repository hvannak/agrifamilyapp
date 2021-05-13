import 'dart:convert';

import 'package:agrifamilyapp/Helpers/constants.dart';
import 'package:agrifamilyapp/Widgets/controlswidget.dart';
import 'package:agrifamilyapp/Widgets/mainwidget.dart';
import 'package:agrifamilyapp/main.dart';
import 'package:agrifamilyapp/models/localizationmodel.dart';
import 'package:agrifamilyapp/models/postdisplaymodel.dart';
import 'package:agrifamilyapp/modules/mygeneralfunc.dart';
import 'package:agrifamilyapp/modules/myhomefunc.dart';
import 'package:agrifamilyapp/modules/mymainfunc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPostDetails extends StatefulWidget {
  late final Postdisplaymodel _posts;
  MyPostDetails(this._posts);
  @override
  _MyPostDetailsState createState() => _MyPostDetailsState();
}

class _MyPostDetailsState extends State<MyPostDetails> {

  void _onItemTapped(int index) {
      Navigator.of(context).pop();
      Navigator.push(context,
        MaterialPageRoute(builder: (context) => MyHomePage(key: UniqueKey(), title: title, index: index)),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: buildText('Message_title_detail')),
      body: Container(
          child: FutureBuilder(
        future: fetchPostImages(context, widget._posts.id!),
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
            return Column(
              children: <Widget>[
                Container(
                    height: 200,
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          if (snapshot.data == null) {
                            return CupertinoActivityIndicator();
                          } else {
                            return Padding(
                              padding: EdgeInsets.all(10),
                              child: Card(
                                shadowColor: Colors.blue,
                                child: Container(
                                  child: Image.memory(
                                    reInstantiateImageCodec(
                                        snapshot.data[index].image.data),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          }
                        })),
                Card(
                  child: Column(
                    children: <Widget>[
                      ColoredBox(
                        color: Colors.purple.shade100,                     
                        child: Row(children: <Widget>[
                          Container(
                            height: 40,
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.content_copy,color: Colors.green[600],),
                                    SizedBox(width: 20,),
                                    Text(widget._posts.title,style: headertextStyle,)
                                  ],
                                ),
                              ),
                            ),
                          )
                        ]),
                      ),
                      ListTile(
                        title: Text(widget._posts.description),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: <Widget>[
                      ColoredBox(
                        color: Colors.yellow.shade100,                     
                        child: Row(children: <Widget>[
                          Container(
                            height: 40,
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.email,color: Colors.green[600],),
                                    SizedBox(width: 20,),
                                    buildText('Contact')
                                  ],
                                ),
                              ),
                            ),
                          )
                        ]),
                      ),
                      ListTile(
                        title: Text(widget._posts.phone!),
                        subtitle: Text((widget._posts.email == null ? '' : widget._posts.email)!),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: <Widget>[
                      ColoredBox(
                        color: Colors.cyan.shade100,                     
                        child: Row(children: <Widget>[
                          Container(
                            height: 40,
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.home,color: Colors.green[600],),
                                    SizedBox(width: 20,),
                                    buildText('Address')
                                  ],
                                ),
                              ),
                            ),
                          )
                        ]),
                      ),
                      ListTile(
                        title: Text(widget._posts.location!)
                      ),
                    ],
                  ),
                )
              ],
            );
          }
        },
      )),
      bottomNavigationBar: BottomNavigationBar(
        items: widgetBottomNav,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

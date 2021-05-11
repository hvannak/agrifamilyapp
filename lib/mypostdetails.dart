import 'package:agrifamilyapp/Widgets/mainwidget.dart';
import 'package:agrifamilyapp/models/postdisplaymodel.dart';
import 'package:agrifamilyapp/modules/myhomefunc.dart';
import 'package:flutter/material.dart';

class MyPostDetails extends StatefulWidget {
  late final Postdisplaymodel _posts;
  MyPostDetails(this._posts);
  @override
  _MyPostDetailsState createState() => _MyPostDetailsState();
}

class _MyPostDetailsState extends State<MyPostDetails> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // resetPostFunc(context);
    });
  }

  @override
  void initState() {
    print(widget._posts);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: Container(
        child: FutureBuilder(
          future: fetchPostImages(context,widget._posts.id!),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if (snapshot.data == null) {
              return Container(
                  child: Center(
                      child: SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              )));
            } else {
              return Container(
                child:Column(
                  children: [
                    Container(
                      height: 180,
                      child: Image.memory(
                        reInstantiateImageCodec(
                            snapshot.data[0].image.data),
                        fit: BoxFit.cover,
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.info,
                        color: Colors.green,
                      ),
                      title: Text(widget._posts.title),
                      subtitle:
                          Text(widget._posts.category.title),
                    ),
                  ],
                )
              );
            }
          },
        )
        
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: widgetBottomNav,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,      
      ),
    );
  }
}
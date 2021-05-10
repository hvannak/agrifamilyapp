import 'package:flutter/material.dart';

class MyPostDetails extends StatefulWidget {
  @override
  _MyPostDetailsState createState() => _MyPostDetailsState();
}

class _MyPostDetailsState extends State<MyPostDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: Text('Detials'),
    );
  }
}
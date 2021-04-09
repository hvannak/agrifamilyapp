
import 'package:flutter/material.dart';

final homeUi = SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: <Widget>[
          containerUi,
          containerUi,
          containerUi
        ],
      )
    );      

final containerUi = Container(
  height: 300,
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget> [
      Expanded(
        child: Card(       
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.network(
                  'https://cdn.vuetifyjs.com/images/logos/vuetify-logo-dark.png',
                  fit: BoxFit.contain,
                  width: 100,
                  ),
              const ListTile(
              leading: Icon(Icons.album),
              title: Text('The Enchanted Nightingale'),
              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
            ),

            ],
          ) ,)
        ),
        )
    ],
  )
);

fechPost() async {
  // final response = await _apiHelper.fetchPost1('/api/Gpstrackings', body);
}
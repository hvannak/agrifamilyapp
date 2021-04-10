
import 'package:flutter/services.dart';

class PostImageModel {
   String id;
   String image;
   String post;
   String date;

  PostImageModel({this.id,this.image,this.post,this.date});

  factory PostImageModel.fromJson(Map<String, dynamic> json) {
    return PostImageModel(
      id: json['id'],
      // image: json['image']["data"],
      post: json['post'],
      date: json['date']
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'image':image,
    'post': post,
    'date': date
  };

}

import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PostsModel {
   String id;
   String category;
   String user;
   String title;
   String description;
   String phone;
   String email;
   String location;
   int price;
   String currency;
   Uint8List firstimage;
   String date;
  PostsModel({this.id,this.category,this.user,this.title,this.description,this.phone,this.email,this.location,this.price,this.currency,this.firstimage,this.date});
  factory PostsModel.fromJson(Map<String, dynamic> json) => _$PostDataFromJson(json);
  Map<String, dynamic> toJson() => _$PostDataToJson(this);
 
}

PostsModel _$PostDataFromJson(Map<String, dynamic> json) {
  return PostsModel(
    id: json['_id'] as String,
      category: json['category']["title"] as String,
      user: json['user'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      location: json['location'] as String,
      price: json['price'] as int,
      currency: json['currency'] as String,
      firstimage: json['firstimage'] as Uint8List,
      date: json['date'] as String
  );
}

Map<String, dynamic> _$PostDataToJson(PostsModel instance) => <String, dynamic>{
    '_id': instance.id,
    'category':instance.category,
    'user': instance.user,
    'title': instance.title,
    'description': instance.description,
    'phone': instance.phone,
    'email': instance.email,
    'location': instance.location,
    'price': instance.price,
    'currency': instance.currency,
    'firstimage': instance.firstimage,
    'date': instance.date
    };

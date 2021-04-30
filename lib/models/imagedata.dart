
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ImageData {
   final String? id;
   //List<int> intList = dynList.map((s) => s as int).toList();
   final List<int>? image;
   final String post;
   final String? date;
  ImageData({ this.id, this.image,required this.post,this.date});
  factory ImageData.fromJson(Map<String, dynamic> json) => _$ImageDataFromJson(json);
  Map<String, dynamic> toJson() => _$ImageDataToJson(this);
 
}

ImageData _$ImageDataFromJson(Map<String, dynamic> json) {
  return ImageData(
    id: json['_id'] as String,
    image: (json['image']['data'] as List).map((e) => e as int).toList(),
    post: json['post'] as String,
    date: json['date'] as String
  );
}

Map<String, dynamic> _$ImageDataToJson(ImageData instance) => <String, dynamic>{
      '_id': instance.id,
      'image': instance.image,
      'post': instance.post,
      'date': instance.date
    };

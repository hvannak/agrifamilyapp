
import 'dart:typed_data';

import 'package:agrifamilyapp/models/imagedatamodel.dart';
import 'package:json_annotation/json_annotation.dart';
part 'postimagemodel.g.dart';

@JsonSerializable(explicitToJson: true)
class Postimagemodel {
   @JsonKey(name: "_id")
   String? id;
   String? post;
   Imagedatamodel? image;
  Postimagemodel(this.id, this.image, this.post);
  factory Postimagemodel.fromJson(Map<String, dynamic> json) => _$PostimagemodelFromJson(json);
  Map<String, dynamic> toJson() => _$PostimagemodelToJson(this);
 
}

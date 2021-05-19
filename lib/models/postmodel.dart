
import 'dart:typed_data';

import 'package:agrifamilyapp/models/postimagemodel.dart';
import 'package:json_annotation/json_annotation.dart';
part 'postmodel.g.dart';

@JsonSerializable(explicitToJson: true)
class Postmodel {
   @JsonKey(name: "_id")
   String? id;
   String? category;
   String? user;
   String title;
   String description;
   String? phone;
   String? email;
   String? location;
   int price;
   String currency;
   List<String>? image;
   List<Postimagemodel>? removeimage;
  Postmodel(this.id, this.category, this.user, this.title, this.description, this.phone, this.email, this.location, this.price, this.currency, this.image,this.removeimage);
  factory Postmodel.fromJson(Map<String, dynamic> json) => _$PostmodelFromJson(json);
  Map<String, dynamic> toJson() => _$PostmodelToJson(this);
 
}

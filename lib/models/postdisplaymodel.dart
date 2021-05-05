
import 'dart:typed_data';

import 'package:agrifamilyapp/models/categorymodel.dart';
import 'package:json_annotation/json_annotation.dart';
part 'postdisplaymodel.g.dart';

@JsonSerializable(explicitToJson: true)
class Postdisplaymodel {
   @JsonKey(name: "_id")
   String? id;
   Categorymodel category;
   String user;
   String title;
   String description;
   String? phone;
   String? email;
   String? location;
   int price;
   String currency;
   List<int>? firstimage;
   String? lang;
  Postdisplaymodel(this.id, this.category, this.user, this.title, this.description, this.phone, this.email, this.location, this.price, this.currency, this.firstimage, this.lang);
  factory Postdisplaymodel.fromJson(Map<String, dynamic> json) => _$PostdisplaymodelFromJson(json);
  Map<String, dynamic> toJson() => _$PostdisplaymodelToJson(this);
 
}

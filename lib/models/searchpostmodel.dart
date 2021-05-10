
import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';
part 'searchpostmodel.g.dart';

@JsonSerializable(explicitToJson: true)
class Searchpostmodel {
   String? category;
   String? user;
   String? title;
   String? description;
   String? phone;
   String? email;
   String? location;
   int? fromPrice;
   int? toPrice;
   String currency;
  Searchpostmodel(this.category, this.user, this.title, this.description, this.phone, this.email, this.location, this.fromPrice, this.currency, this.toPrice);
  factory Searchpostmodel.fromJson(Map<String, dynamic> json) => _$SearchpostmodelFromJson(json);
  Map<String, dynamic> toJson() => _$SearchpostmodelToJson(this);
 
}

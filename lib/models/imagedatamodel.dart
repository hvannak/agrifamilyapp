
import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';
part 'imagedatamodel.g.dart';

@JsonSerializable(explicitToJson: true)
class Imagedatamodel {
   String type;
   List<int> data;
  Imagedatamodel(this.type, this.data);
  factory Imagedatamodel.fromJson(Map<String, dynamic> json) => _$ImagedatamodelFromJson(json);
  Map<String, dynamic> toJson() => _$ImagedatamodelToJson(this);
 
}

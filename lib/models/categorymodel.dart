import 'package:json_annotation/json_annotation.dart';
part 'categorymodel.g.dart';

@JsonSerializable()
class Categorymodel {
  @JsonKey(name: "_id")
  String id;
  String title;
  String icon;
  String lang;
  Categorymodel(this.id,this.title,this.icon,this.lang);
  factory Categorymodel.fromJson(Map<String, dynamic> json) => _$CategorymodelFromJson(json);
  Map<String, dynamic> toJson() => _$CategorymodelToJson(this);
}
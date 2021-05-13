import 'package:json_annotation/json_annotation.dart';
part 'localizationmodel.g.dart';

@JsonSerializable()
class Localizationmodel {
  @JsonKey(name: "_id")
  String id;
  String parent;
  String props;
  String type;
  String lang;
  String text;
  Localizationmodel(this.id,this.parent,this.props,this.type,this.lang,this.text);
  factory Localizationmodel.fromJson(Map<String, dynamic> json) => _$LocalizationmodelFromJson(json);
  Map<String, dynamic> toJson() => _$LocalizationmodelToJson(this);
}
import 'package:json_annotation/json_annotation.dart';
part 'languagemodel.g.dart';

@JsonSerializable()
class Languagemodel {
  @JsonKey(name: "_id")
  String id;
  String title;
  String shortcode;
  @JsonKey(name: "default")
  bool defaultlang;
  Languagemodel(this.id,this.title,this.shortcode,this.defaultlang);
  factory Languagemodel.fromJson(Map<String, dynamic> json) => _$LanguagemodelFromJson(json);
  Map<String, dynamic> toJson() => _$LanguagemodelToJson(this);
}
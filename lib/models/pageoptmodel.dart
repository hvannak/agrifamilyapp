import 'package:json_annotation/json_annotation.dart';
part 'pageoptmodel.g.dart';

@JsonSerializable()
class Pageoptmodel {
  int page;
  int itemsPerPage;
  List<String> sortBy;
  List<bool> sortDesc;
  Pageoptmodel(this.page,this.itemsPerPage,this.sortBy,this.sortDesc);
  factory Pageoptmodel.fromJson(Map<String, dynamic> json) => _$PageoptmodelFromJson(json);
  Map<String, dynamic> toJson() => _$PageoptmodelToJson(this);
}

// Map<String, dynamic> _$PageOptDataToJson(PageOptModel instance) => <String, dynamic>{
//     'page': instance.page,
//     'itemsPerPage':instance.itemsPerPage,
//     'sortBy': instance.sortBy,
//     'sortDesc': instance.sortDesc
//     };
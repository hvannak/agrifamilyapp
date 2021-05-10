import 'package:agrifamilyapp/models/pageoptmodel.dart';
import 'package:agrifamilyapp/models/searchpostmodel.dart';
import 'package:json_annotation/json_annotation.dart';
part 'pagesearchobjmodel.g.dart';

@JsonSerializable(explicitToJson: true)
class Pagesearchobjmodel {
  Searchpostmodel searchObj;
  String? searchObjby;
  String? categoryId;
  Pageoptmodel pageOpt;
  Pagesearchobjmodel(this.searchObj,this.searchObjby,this.categoryId,this.pageOpt);
  factory Pagesearchobjmodel.fromJson(Map<String, dynamic> json) => _$PagesearchobjmodelFromJson(json);
  Map<String, dynamic> toJson() => _$PagesearchobjmodelToJson(this);
}

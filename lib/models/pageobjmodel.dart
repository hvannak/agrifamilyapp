import 'package:agrifamilyapp/models/pageoptmodel.dart';
import 'package:json_annotation/json_annotation.dart';
part 'pageobjmodel.g.dart';

@JsonSerializable(explicitToJson: true)
class Pageobjmodel {
  String? searchObj;
  String? searchObjby;
  String? categoryId;
  Pageoptmodel pageOpt;
  Pageobjmodel(this.searchObj,this.searchObjby,this.categoryId,this.pageOpt);
  factory Pageobjmodel.fromJson(Map<String, dynamic> json) => _$PageobjmodelFromJson(json);
  Map<String, dynamic> toJson() => _$PageobjmodelToJson(this);
}

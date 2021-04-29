import 'package:agrifamilyapp/models/pageoptmodel.dart';

class PageObjModel {
  String searchObj;
  String searchObjby;
  PageOptModel pageOpt;
  PageObjModel({this.searchObj,this.searchObjby,this.pageOpt});
  Map<String, dynamic> toJson() => _$PageObjDataToJson(this);
}


Map<String, dynamic> _$PageObjDataToJson(PageObjModel instance) => <String, dynamic>{
    'searchObj': instance.searchObj,
    'searchObjby':instance.searchObjby,
    'pageOpt': instance.pageOpt
    };

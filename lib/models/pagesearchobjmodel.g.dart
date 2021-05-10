// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagesearchobjmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pagesearchobjmodel _$PagesearchobjmodelFromJson(Map<String, dynamic> json) {
  return Pagesearchobjmodel(
    Searchpostmodel.fromJson(json['searchObj'] as Map<String, dynamic>),
    json['searchObjby'] as String?,
    json['categoryId'] as String?,
    Pageoptmodel.fromJson(json['pageOpt'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PagesearchobjmodelToJson(Pagesearchobjmodel instance) =>
    <String, dynamic>{
      'searchObj': instance.searchObj.toJson(),
      'searchObjby': instance.searchObjby,
      'categoryId': instance.categoryId,
      'pageOpt': instance.pageOpt.toJson(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pageobjmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pageobjmodel _$PageobjmodelFromJson(Map<String, dynamic> json) {
  return Pageobjmodel(
    json['searchObj'] as String?,
    json['searchpostmodel'] == null
        ? null
        : Searchpostmodel.fromJson(
            json['searchpostmodel'] as Map<String, dynamic>),
    json['searchObjby'] as String?,
    json['categoryId'] as String?,
    Pageoptmodel.fromJson(json['pageOpt'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PageobjmodelToJson(Pageobjmodel instance) =>
    <String, dynamic>{
      'searchObj': instance.searchObj,
      'searchObjby': instance.searchObjby,
      'categoryId': instance.categoryId,
      'searchpostmodel': instance.searchpostmodel?.toJson(),
      'pageOpt': instance.pageOpt.toJson(),
    };

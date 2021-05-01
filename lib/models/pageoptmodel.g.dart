// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pageoptmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pageoptmodel _$PageoptmodelFromJson(Map<String, dynamic> json) {
  return Pageoptmodel(
    json['page'] as int,
    json['itemsPerPage'] as int,
    (json['sortBy'] as List<dynamic>).map((e) => e as String).toList(),
    (json['sortDesc'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$PageoptmodelToJson(Pageoptmodel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'itemsPerPage': instance.itemsPerPage,
      'sortBy': instance.sortBy,
      'sortDesc': instance.sortDesc,
    };

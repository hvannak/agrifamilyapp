// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categorymodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Categorymodel _$CategorymodelFromJson(Map<String, dynamic> json) {
  return Categorymodel(
    json['_id'] as String,
    json['title'] as String,
    json['icon'] as String?,
    json['lang'] as String?,
  );
}

Map<String, dynamic> _$CategorymodelToJson(Categorymodel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'icon': instance.icon,
      'lang': instance.lang,
    };

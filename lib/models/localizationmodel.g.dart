// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localizationmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Localizationmodel _$LocalizationmodelFromJson(Map<String, dynamic> json) {
  return Localizationmodel(
    json['_id'] as String,
    json['parent'] as String,
    json['props'] as String,
    json['type'] as String,
    json['lang'] as String,
    json['text'] as String,
  );
}

Map<String, dynamic> _$LocalizationmodelToJson(Localizationmodel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'parent': instance.parent,
      'props': instance.props,
      'type': instance.type,
      'lang': instance.lang,
      'text': instance.text,
    };

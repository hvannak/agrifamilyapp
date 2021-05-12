// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'languagemodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Languagemodel _$LanguagemodelFromJson(Map<String, dynamic> json) {
  return Languagemodel(
    json['_id'] as String,
    json['title'] as String,
    json['shortcode'] as String,
    json['default'] as bool,
  );
}

Map<String, dynamic> _$LanguagemodelToJson(Languagemodel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'shortcode': instance.shortcode,
      'default': instance.defaultlang,
    };

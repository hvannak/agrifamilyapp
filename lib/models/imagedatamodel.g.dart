// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imagedatamodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Imagedatamodel _$ImagedatamodelFromJson(Map<String, dynamic> json) {
  return Imagedatamodel(
    json['type'] as String,
    (json['data'] as List<dynamic>).map((e) => e as int).toList(),
  );
}

Map<String, dynamic> _$ImagedatamodelToJson(Imagedatamodel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
    };

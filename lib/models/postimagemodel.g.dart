// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postimagemodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Postimagemodel _$PostimagemodelFromJson(Map<String, dynamic> json) {
  return Postimagemodel(
    json['_id'] as String?,
    json['image'] == null
        ? null
        : Imagedatamodel.fromJson(json['image'] as Map<String, dynamic>),
    json['post'] as String?,
  );
}

Map<String, dynamic> _$PostimagemodelToJson(Postimagemodel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'post': instance.post,
      'image': instance.image?.toJson(),
    };

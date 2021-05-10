// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searchpostmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Searchpostmodel _$SearchpostmodelFromJson(Map<String, dynamic> json) {
  return Searchpostmodel(
    json['category'] as String?,
    json['user'] as String?,
    json['title'] as String?,
    json['description'] as String?,
    json['phone'] as String?,
    json['email'] as String?,
    json['location'] as String?,
    json['fromPrice'] as int?,
    json['currency'] as String,
    json['toPrice'] as int?,
  );
}

Map<String, dynamic> _$SearchpostmodelToJson(Searchpostmodel instance) =>
    <String, dynamic>{
      'category': instance.category,
      'user': instance.user,
      'title': instance.title,
      'description': instance.description,
      'phone': instance.phone,
      'email': instance.email,
      'location': instance.location,
      'fromPrice': instance.fromPrice,
      'toPrice': instance.toPrice,
      'currency': instance.currency,
    };

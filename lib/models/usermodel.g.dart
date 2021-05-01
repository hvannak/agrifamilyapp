// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usermodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Usermodel _$UsermodelFromJson(Map<String, dynamic> json) {
  return Usermodel(
    json['_id'] as String?,
    json['name'] as String,
    json['password'] as String,
    json['backctl'] as bool,
    json['email'] as String,
    json['date'] as String?,
  );
}

Map<String, dynamic> _$UsermodelToJson(Usermodel instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'backctl': instance.backctl,
      'date': instance.date,
    };

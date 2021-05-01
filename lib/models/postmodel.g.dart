// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Postmodel _$PostmodelFromJson(Map<String, dynamic> json) {
  return Postmodel(
    json['id'] as String?,
    json['category'] as String,
    json['user'] as String,
    json['title'] as String,
    json['description'] as String,
    json['phone'] as String,
    json['email'] as String,
    json['location'] as String,
    json['price'] as int,
    json['currency'] as String,
    (json['firstimage'] as List<dynamic>).map((e) => e as int).toList(),
    json['date'] as String,
  );
}

Map<String, dynamic> _$PostmodelToJson(Postmodel instance) => <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'user': instance.user,
      'title': instance.title,
      'description': instance.description,
      'phone': instance.phone,
      'email': instance.email,
      'location': instance.location,
      'price': instance.price,
      'currency': instance.currency,
      'firstimage': instance.firstimage,
      'date': instance.date,
    };

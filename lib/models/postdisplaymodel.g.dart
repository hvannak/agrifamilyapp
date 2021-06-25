// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postdisplaymodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Postdisplaymodel _$PostdisplaymodelFromJson(Map<String, dynamic> json) {
  return Postdisplaymodel(
    json['_id'] as String?,
    Categorymodel.fromJson(json['category'] as Map<String, dynamic>),
    json['user'] as String,
    json['title'] as String,
    json['description'] as String,
    json['phone'] as String?,
    json['email'] as String?,
    json['location'] as String?,
    json['price'] as num,
    json['currency'] as String,
    (json['firstimage'] as List<dynamic>?)?.map((e) => e as int).toList(),
    json['lang'] as String?,
  );
}

Map<String, dynamic> _$PostdisplaymodelToJson(Postdisplaymodel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'category': instance.category.toJson(),
      'user': instance.user,
      'title': instance.title,
      'description': instance.description,
      'phone': instance.phone,
      'email': instance.email,
      'location': instance.location,
      'price': instance.price,
      'currency': instance.currency,
      'firstimage': instance.firstimage,
      'lang': instance.lang,
    };

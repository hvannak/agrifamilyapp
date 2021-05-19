// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Postmodel _$PostmodelFromJson(Map<String, dynamic> json) {
  return Postmodel(
    json['_id'] as String?,
    json['category'] as String?,
    json['user'] as String?,
    json['title'] as String,
    json['description'] as String,
    json['phone'] as String?,
    json['email'] as String?,
    json['location'] as String?,
    json['price'] as int,
    json['currency'] as String,
    (json['image'] as List<dynamic>?)?.map((e) => e as String).toList(),
    (json['removeimage'] as List<dynamic>?)
        ?.map((e) => Postimagemodel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$PostmodelToJson(Postmodel instance) => <String, dynamic>{
      '_id': instance.id,
      'category': instance.category,
      'user': instance.user,
      'title': instance.title,
      'description': instance.description,
      'phone': instance.phone,
      'email': instance.email,
      'location': instance.location,
      'price': instance.price,
      'currency': instance.currency,
      'image': instance.image,
      'removeimage': instance.removeimage?.map((e) => e.toJson()).toList(),
    };

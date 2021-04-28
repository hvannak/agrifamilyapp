
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UsersModel {
   String id;
   String name;
   String email;
   String password;
   bool backctl;
   String date;
  UsersModel({this.id,this.name,this.password,this.backctl,this.email,this.date});
  UsersModel.login({this.email,this.password});
  factory UsersModel.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserDataToJson(this);
  Map<String, dynamic> toLoginJson() => _$UserLoginToJson(this);
}

UsersModel _$UserDataFromJson(Map<String, dynamic> json) {
  return UsersModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      backctl: json['backctl'] as bool,
      date: json['date'] as String
  );
}

Map<String, dynamic> _$UserDataToJson(UsersModel instance) => <String, dynamic>{
    '_id': instance.id,
    'name':instance.name,
    'email': instance.email,
    'password': instance.password,
    'backctl': instance.backctl,
    'date': instance.date
    };

Map<String, dynamic> _$UserLoginToJson(UsersModel instance) => <String, dynamic>{
    'email': instance.email,
    'password': instance.password
    };
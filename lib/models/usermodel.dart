
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class UsersModel {
   String? id;
   late String name;
   String email;
   String password;
   bool backctl = false;
   String? date;
  UsersModel({this.id,required this.name,required this.password,required this.backctl,required this.email,this.date});
  UsersModel.login({required this.email,required this.password});
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
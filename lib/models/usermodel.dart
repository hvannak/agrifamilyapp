
import 'package:json_annotation/json_annotation.dart';
part 'usermodel.g.dart';

@JsonSerializable(explicitToJson: true)
class Usermodel {
   @JsonKey(name: "_id")
   String? id;
   late String name;
   String email;
   String password;
   bool backctl = false;
   String? date;
  Usermodel(this.id, this.name, this.password, this.backctl, this.email,this.date);
  Usermodel.login( this.email, this.password);
  Usermodel.register(this.name, this.email, this.password,this.backctl);
  factory Usermodel.fromJson(Map<String, dynamic> json) => _$UsermodelFromJson(json);
  Map<String, dynamic> toJson() => _$UsermodelToJson(this);
  Map<String, dynamic> toLoginJson() => _$UsermodelLoginToJson(this);
  Map<String, dynamic> toRegisterJson() => _$UsermodelRegisterToJson(this);
}

Map<String, dynamic> _$UsermodelLoginToJson(Usermodel instance) => <String, dynamic>{
    'email': instance.email,
    'password': instance.password
    };

Map<String, dynamic> _$UsermodelRegisterToJson(Usermodel instance) => <String, dynamic>{
    'name': instance.name,
    'email': instance.email,
    'password': instance.password,
    'backctl': instance.backctl
    };
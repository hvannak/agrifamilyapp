
import 'package:json_annotation/json_annotation.dart';
part 'usermodel.g.dart';

@JsonSerializable(explicitToJson: true)
class Usermodel {
   String? id;
   late String name;
   String email;
   String password;
   bool backctl = false;
   String? date;
  Usermodel(this.id, this.name, this.password, this.backctl, this.email,this.date);
  Usermodel.login( this.email, this.password);
  factory Usermodel.fromJson(Map<String, dynamic> json) => _$UsermodelFromJson(json);
  Map<String, dynamic> toJson() => _$UsermodelToJson(this);
  Map<String, dynamic> toLoginJson() => _$UsermodelLoginToJson(this);
}
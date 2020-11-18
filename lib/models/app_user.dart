import 'package:json_annotation/json_annotation.dart';
part 'app_user.g.dart';

@JsonSerializable()
class AppUser {
  String uid;
  String email;
  String password;

  AppUser({this.uid = '', this.email, this.password});

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}

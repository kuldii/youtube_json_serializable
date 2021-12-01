import 'package:json_annotation/json_annotation.dart';

import './data.dart';
import './support.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  final Data data;
  final Support support;

  UserModel({
    required this.data,
    required this.support,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'season.g.dart';

@JsonSerializable()
class Season {
  final String h4aId;
  final String name;

  Season(this.name, this.h4aId);

  factory Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);
  Map<String, dynamic> toJson() => _$SeasonToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'league.g.dart';

@JsonSerializable()
class League {
  final String h4aId;
  final String h4aDistrictId;

  final String name;
  final String abbreviation;

  final String gender;
  final String ageLetter;
  final int age;

  League(this.h4aId, this.h4aDistrictId, this.name, this.abbreviation,
      this.gender, this.ageLetter, this.age);

  factory League.fromJson(Map<String, dynamic> json) => _$LeagueFromJson(json);

  Map<String, dynamic> toJson() => _$LeagueToJson(this);
}

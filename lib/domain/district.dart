import 'package:json_annotation/json_annotation.dart';

part 'district.g.dart';

@JsonSerializable()
class District {
  final String h4aId;
  final String name;

  District(this.name, this.h4aId);

  factory District.fromJson(Map<String, dynamic> json) => _$DistrictFromJson(json);
  Map<String, dynamic> toJson() => _$DistrictToJson(this);
}

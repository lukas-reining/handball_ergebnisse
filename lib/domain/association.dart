import 'package:json_annotation/json_annotation.dart';

part 'association.g.dart';

@JsonSerializable()
class Association {
  final String h4aId;
  final String name;
  final String abbreviation;

  Association(this.name, this.abbreviation, this.h4aId);

  factory Association.fromJson(Map<String, dynamic> json) => _$AssociationFromJson(json);
  Map<String, dynamic> toJson() => _$AssociationToJson(this);
}

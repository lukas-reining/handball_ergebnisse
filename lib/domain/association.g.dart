// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'association.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Association _$AssociationFromJson(Map<String, dynamic> json) => Association(
      json['name'] as String,
      json['abbreviation'] as String,
      json['h4aId'] as String,
    );

Map<String, dynamic> _$AssociationToJson(Association instance) =>
    <String, dynamic>{
      'h4aId': instance.h4aId,
      'name': instance.name,
      'abbreviation': instance.abbreviation,
    };

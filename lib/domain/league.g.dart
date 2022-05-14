// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

League _$LeagueFromJson(Map<String, dynamic> json) => League(
      json['h4aId'] as String,
      json['h4aDistrictId'] as String,
      json['name'] as String,
      json['abbreviation'] as String,
      json['gender'] as String,
      json['ageLetter'] as String,
      json['age'] as int,
    );

Map<String, dynamic> _$LeagueToJson(League instance) => <String, dynamic>{
      'h4aId': instance.h4aId,
      'h4aDistrictId': instance.h4aDistrictId,
      'name': instance.name,
      'abbreviation': instance.abbreviation,
      'gender': instance.gender,
      'ageLetter': instance.ageLetter,
      'age': instance.age,
    };

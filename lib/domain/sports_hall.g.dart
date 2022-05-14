// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sports_hall.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SportsHall _$SportsHallFromJson(Map<String, dynamic> json) => SportsHall(
      json['h4aId'] as int,
      json['number'] as int,
      json['name'] as String,
      json['phoneNumber'] as String,
      GymnasiumAddress.fromJson(json['address'] as Map<String, dynamic>),
      json['permittedFor1'] as String,
      json['permittedFor2'] as String,
      json['wax'] as String,
    );

Map<String, dynamic> _$SportsHallToJson(SportsHall instance) =>
    <String, dynamic>{
      'h4aId': instance.h4aId,
      'number': instance.number,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'permittedFor1': instance.permittedFor1,
      'permittedFor2': instance.permittedFor2,
      'wax': instance.wax,
    };

GymnasiumAddress _$GymnasiumAddressFromJson(Map<String, dynamic> json) =>
    GymnasiumAddress(
      json['country'] as String,
      json['zip'] as int,
      json['city'] as String,
      json['street'] as String,
      json['streetNumber'] as String,
      (json['latitude'] as num).toDouble(),
      (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$GymnasiumAddressToJson(GymnasiumAddress instance) =>
    <String, dynamic>{
      'country': instance.country,
      'zip': instance.zip,
      'city': instance.city,
      'street': instance.street,
      'streetNumber': instance.streetNumber,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

import 'package:json_annotation/json_annotation.dart';

part 'sports_hall.g.dart';

@JsonSerializable()
class SportsHall {
  final int h4aId;
  final int number;
  final String name;

  final String phoneNumber;

  final GymnasiumAddress address;

  final String permittedFor1;
  final String permittedFor2;
  final String wax;

  String get displayAddress =>
      "$name, ${address.street}, ${address.zip} ${address.city}";

  SportsHall(this.h4aId, this.number, this.name, this.phoneNumber, this.address,
      this.permittedFor1, this.permittedFor2, this.wax);

  factory SportsHall.fromJson(Map<String, dynamic> json) =>
      _$SportsHallFromJson(json);

  Map<String, dynamic> toJson() => _$SportsHallToJson(this);
}

@JsonSerializable()
class GymnasiumAddress {
  final String country;
  final int zip;
  final String city;
  final String street;
  final String streetNumber;
  final double latitude;
  final double longitude;

  GymnasiumAddress(this.country, this.zip, this.city, this.street,
      this.streetNumber, this.latitude, this.longitude);

  factory GymnasiumAddress.fromJson(Map<String, dynamic> json) =>
      _$GymnasiumAddressFromJson(json);

  Map<String, dynamic> toJson() => _$GymnasiumAddressToJson(this);
}

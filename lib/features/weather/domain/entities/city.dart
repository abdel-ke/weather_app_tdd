// {
// "id": 2538475,
// "name": "Rabat",
// "latitude": 34.01325,
// "longitude": -6.83255,
// "elevation": 46,
// "feature_code": "PPLC",
// "country_code": "MA",
// "admin1_id": 11281877,
// "admin2_id": 2538474,
// "timezone": "Africa/Casablanca",
// "population": 1655753,
// "country_id": 2542007,
// "country": "Morocco",
// "admin1": "Rabat-Salé-Kénitra",
// "admin2": "Rabat"
// },

import 'package:equatable/equatable.dart';

class City extends Equatable {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final int elevation;
  final String featureCode;
  final String countryCode;
  final int admin1Id;
  final int admin2Id;
  final String timezone;
  final int population;
  final int countryId;
  final String country;
  final String admin1;
  final String admin2;

  const City(
      {required this.id,
      required this.name,
      required this.latitude,
      required this.longitude,
      required this.elevation,
      required this.featureCode,
      required this.countryCode,
      required this.admin1Id,
      required this.admin2Id,
      required this.timezone,
      required this.population,
      required this.countryId,
      required this.country,
      required this.admin1,
      required this.admin2});

  @override
  List<Object?> get props => [
        id,
        name,
        latitude,
        longitude,
        elevation,
        featureCode,
        countryCode,
        admin1Id,
        admin2Id,
        timezone,
        population,
        countryId,
        country,
        admin1,
        admin2
      ];
}

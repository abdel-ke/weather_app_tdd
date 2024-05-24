import 'package:weather_app_tdd/features/weather/domain/entities/weather.dart';

class CityModel extends City {
  const CityModel(
      {required super.name,
      required super.admin1,
      required super.country,
      required super.latitude,
      required super.longitude});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
        name: json['name'],
        admin1: json['admin1'],
        country: json['country'],
        latitude: json['latitude'],
        longitude: json['longitude']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'admin1': admin1,
      'country': country,
      'latitude': latitude,
      'longitude': longitude
    };
  }
}

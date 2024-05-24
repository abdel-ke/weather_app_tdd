import 'package:equatable/equatable.dart';

class City extends Equatable {
  final String name;
  final String admin1;
  final String country;
  final double latitude;
  final double longitude;

  const City({
    required this.name,
    required this.admin1,
    required this.country,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [name, admin1, country, latitude, longitude];
}

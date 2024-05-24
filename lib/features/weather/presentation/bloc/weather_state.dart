part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();  

  @override
  List<Object> get props => [];
}
class WeatherInitial extends WeatherState {}

class LoadedWeather extends WeatherState {
  final City city;

  const LoadedWeather({
    required this.city
  });

  @override
  List<Object> get props => [city];
}

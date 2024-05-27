part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();  

  @override
  List<Object> get props => [];
}

class WeatherInitialState extends WeatherState {}

class LoadedWeatherState extends WeatherState {
  final List<City> city;

  const LoadedWeatherState({
    required this.city
  });

  @override
  List<Object> get props => [city];
}

class ErrorWeatherState extends WeatherState {
  final String message;

  const ErrorWeatherState({required this.message});

  @override
  List<Object> get props => [message];
}

class LoadingWeatherState extends WeatherState {}
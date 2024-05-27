import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_app_tdd/features/weather/domain/entities/weather.dart';
import 'package:weather_app_tdd/features/weather/domain/usecases/weather_usecase.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherUsecase weatherUsecase;

  WeatherBloc({required this.weatherUsecase}) : super(WeatherInitialState()) {
    on<WeatherEvent>((event, emit) async {
      debugPrint('WeatherBloc event.runtimeType: ${event.runtimeType}');
      if (event is GetCityEvent) {
        try {
          emit(LoadingWeatherState());
          debugPrint('start GetCityEvent call');
          final failureOrCity = await weatherUsecase(event.city);
          debugPrint('failureOrCity: $failureOrCity');
          debugPrint('done GetCityEvent call');
          debugPrint('failureOrCity.runtimeType: ${failureOrCity.runtimeType}');
          emit(
            failureOrCity.fold(
              (failure) {
                debugPrint('failure.runtimeType: ${failure.runtimeType}');
                return const ErrorWeatherState(message: 'error alkhawa dyali');
              },
              (city) {
                debugPrint('city.runtimeType: ${city.runtimeType}');
                return LoadedWeatherState(city: city);
              },
            ),
          );
        } catch (e) {
          debugPrint('error.runtimeType: ${e.runtimeType}');
          emit(const ErrorWeatherState(message: 'error alkhawa dyali'));
        }
      } else if (event is LoadInitialWeatherEvent) {
        debugPrint('LoadInitialWeatherEvent call');
        emit(WeatherInitialState());
      } else if (event is ErrorGetCityEvent) {
        debugPrint('ErrorGetCityEvent call');
        emit(ErrorWeatherState(message: event.errorMessage));
      } else if (event is LoadingWeatherEvent) {
        debugPrint('LoadingWeatherEvent call');
        emit(LoadingWeatherState());
      }
    });
  }
}

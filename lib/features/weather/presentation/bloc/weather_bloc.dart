import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app_tdd/features/weather/domain/entities/weather.dart';
import 'package:weather_app_tdd/features/weather/domain/usecases/weather_usecase.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherUsecase weatherUsecase;

  WeatherBloc({required this.weatherUsecase}) : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) async {
      if (event is GetCity) {
        final failureOrCity = await weatherUsecase(event.city);
        failureOrCity.fold(
            (failure) => const ErrorGetCity(errorMessage: 'errorMessage'),
            (city) => emit(LoadedWeather(city: city)));
      }
    });
  }
}

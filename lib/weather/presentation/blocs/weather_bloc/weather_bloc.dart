import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_watch/core/resources/data_state.dart';
import 'package:weather_watch/weather/domain/entities/weather.dart';
import 'package:weather_watch/weather/domain/use_cases/get_weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeather _getWeather;

  WeatherBloc(this._getWeather) : super(WeatherInitial()) {
    on<FetchWeather>(onGetWeather);
  }

  void onGetWeather(FetchWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    final dataState = await _getWeather(event.lat, event.lon);
    if (dataState is DataSuccess && dataState.data != null) {
      emit(WeatherLoaded(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(WeatherError(dataState.error!));
    }
  }
}

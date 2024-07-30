import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_watch/core/resources/data_state.dart';
import 'package:weather_watch/weather/domain/entities/weather.dart';
import 'package:weather_watch/weather/domain/use_cases/get_weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

/// Bloc that handles weather-related events and states.
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeather _getWeather;

  /// Constructor for WeatherBloc.
  ///
  /// Takes a [GetWeather] use case as a parameter.
  WeatherBloc(this._getWeather) : super(WeatherInitial()) {
    on<FetchWeather>(onGetWeather);
  }

  /// Event handler for fetching weather data.
  ///
  /// Emits [WeatherLoading] state initially, then fetches weather data using the [GetWeather] use case.
  /// Depending on the result, it emits either [WeatherLoaded] or [WeatherError] state.
  ///
  /// \param event The [FetchWeather] event containing latitude and longitude.
  /// \param emit The function to emit new states.
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

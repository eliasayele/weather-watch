import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_watch/core/constants/constants.dart';
import 'package:weather_watch/core/resources/data_state.dart';
import 'package:weather_watch/weather/data/data_sources/remote/weather_api.dart';
import 'package:weather_watch/weather/domain/entities/weather.dart';
import 'package:weather_watch/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApiService _weatherApiService;
  WeatherRepositoryImpl(this._weatherApiService);
  @override
  Future<DataState<Weather>> fetchWeather(double lat, double lon) async {
    final String weatherApiKey = dotenv.env['WEATHER_API_KEY'] ?? '';
    final httpResponse = await _weatherApiService.getWeather(
      lat: latitude,
      lon: longitude,
      apiKey: weatherApiKey,
    );
    try {
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}

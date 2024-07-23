import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_watch/weather/data/data_sources/remote/weather_api.dart';
import 'package:weather_watch/weather/data/repositories/weather_repository.dart';
import 'package:weather_watch/weather/domain/repositories/weather_repository.dart';
import 'package:weather_watch/weather/domain/use_cases/get_weather.dart';
import 'package:weather_watch/weather/presentation/blocs/blocs.dart';

/// A global instance of GetIt for dependency injection.
final sl = GetIt.instance;

/// Sets up the dependency injection container.
///
/// Registers necessary instances for the application to function.
Future<void> setUpServiceLocator() async {
  // Register a Dio instance for network requests
  sl.registerSingleton<Dio>(Dio());

  // Register the WeatherApiService for fetching weather data
  sl.registerSingleton<WeatherApiService>(WeatherApiService(sl()));

  // Register the WeatherRepository to handle weather data
  sl.registerSingleton<WeatherRepository>(WeatherRepositoryImpl(sl()));

  // Register the GetWeather use case for retrieving weather information
  sl.registerSingleton<GetWeather>(GetWeather(sl()));

  // Register the WeatherBloc for managing weather-related UI state
  sl.registerFactory<WeatherBloc>(() => WeatherBloc(sl()));
}
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_watch/core/constants/constants.dart';
import 'package:weather_watch/core/resources/data_state.dart';
import 'package:weather_watch/service_locator.dart';
import 'package:weather_watch/weather/domain/entities/weather.dart';
import 'package:weather_watch/weather/domain/use_cases/get_weather.dart';
import 'package:weather_watch/weather/presentation/blocs/weather_bloc/weather_bloc.dart';
import 'package:dio/dio.dart';
import 'package:bloc_test/bloc_test.dart';

class MockGetWeather extends Mock implements GetWeather {}

void main() {
  late MockGetWeather mockGetWeather;
  late WeatherBloc weatherBloc;

  setUp(() {
    sl.reset();
    mockGetWeather = MockGetWeather();
    sl.registerSingleton<GetWeather>(mockGetWeather);
    weatherBloc = WeatherBloc(sl<GetWeather>());
  });

  tearDown(() {
    weatherBloc.close();
  });

  group('WeatherBloc Tests', () {
    const testWeather = Weather(
      temperature: 20.0,
      locationName: 'Test Location',
    );
    const testLat = latitude;
    const testLon = longitude;

    test('initial state is WeatherInitial', () {
      expect(weatherBloc.state, equals(WeatherInitial()));
    });

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherLoaded] when weather data is fetched successfully',
      build: () {
        when(() => mockGetWeather(testLat, testLon))
            .thenAnswer((_) async => const DataSuccess(testWeather));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(FetchWeather(lat: testLat, lon: testLon)),
      expect: () => [
        WeatherLoading(),
        WeatherLoaded(testWeather),
      ],
      verify: (_) {
        verify(() => mockGetWeather(testLat, testLon)).called(1);
      },
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherError] when fetching weather data fails',
      build: () {
        final error = DioException(requestOptions: RequestOptions(path: ''));
        when(() => mockGetWeather(testLat, testLon))
            .thenAnswer((_) async => DataFailed(error));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(FetchWeather(lat: testLat, lon: testLon)),
      expect: () => [
        WeatherLoading(),
        isA<WeatherError>(),
      ],
      verify: (_) {
        verify(() => mockGetWeather(testLat, testLon)).called(1);
      },
    );

    blocTest<WeatherBloc, WeatherState>(
      'does not emit new states when no event is added',
      build: () => weatherBloc,
      wait: const Duration(seconds: 1),
      expect: () => [],
    );
  });
}

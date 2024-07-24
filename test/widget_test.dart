// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:weather_watch/main.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:weather_watch/weather/presentation/blocs/cubits/temperature_unit_cubit.dart';
import 'package:weather_watch/weather/presentation/blocs/weather_bloc/weather_bloc.dart';
import 'package:weather_watch/weather/domain/entities/weather.dart';
import 'package:weather_watch/service_locator.dart';

// Mock classes
class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

class MockTemperatureUnitCubit extends MockCubit<bool>
    implements TemperatureUnitCubit {
  @override
  bool get isCelsius => state;
}

void main() {
  late MockWeatherBloc mockWeatherBloc;
  late MockTemperatureUnitCubit mockTempCubit;

  setUp(() {
    // Initialize mocks
    mockWeatherBloc = MockWeatherBloc();
    mockTempCubit = MockTemperatureUnitCubit();

    // Reset the service locator
    sl.reset();

    // Register mocks
    sl.registerFactory<WeatherBloc>(() => mockWeatherBloc);
    sl.registerFactory<TemperatureUnitCubit>(() => mockTempCubit);

    // Set up default state for mockTempCubit
    when(() => mockTempCubit.state).thenReturn(true);
    when(() => mockTempCubit.isCelsius).thenReturn(true);
  });

  tearDown(() {
    sl.reset();
  });

  testWidgets('WeatherPage displays weather information correctly',
      (WidgetTester tester) async {
    // Arrange
    const testWeather = Weather(temperature: 20.0, locationName: 'Test City');

    when(() => mockWeatherBloc.state).thenReturn(WeatherLoaded(testWeather));

    // Act
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Assert
    expect(find.text('Weather App'), findsOneWidget);
    expect(find.text('THIS IS MY WEATHER APP'), findsOneWidget);
    expect(find.text('Test City'), findsOneWidget);
  });
}

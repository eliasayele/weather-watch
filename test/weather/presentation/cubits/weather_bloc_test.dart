import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_watch/weather/presentation/blocs/blocs.dart';

void main() {
  group('TemperatureUnitCubit', () {
    late TemperatureUnitCubit temperatureUnitCubit;

    setUp(() {
      temperatureUnitCubit = TemperatureUnitCubit();
    });

    test('initial state is Celsius (true)', () {
      expect(temperatureUnitCubit.state, true);
      expect(temperatureUnitCubit.isCelsius, true);
    });

    blocTest<TemperatureUnitCubit, bool>(
      'emits [false] when toggleUnit is called from initial state',
      build: () => temperatureUnitCubit,
      act: (cubit) => cubit.toggleUnit(),
      expect: () => [false],
    );

    blocTest<TemperatureUnitCubit, bool>(
      'emits [true] when toggleUnit is called twice from initial state',
      build: () => temperatureUnitCubit,
      act: (cubit) => cubit
        ..toggleUnit()
        ..toggleUnit(),
      expect: () => [false, true],
    );

    test('isCelsius getter returns correct value', () {
      expect(temperatureUnitCubit.isCelsius, true);
      temperatureUnitCubit.toggleUnit();
      expect(temperatureUnitCubit.isCelsius, false);
    });
  });
}

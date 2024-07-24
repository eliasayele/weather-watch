import 'package:flutter_bloc/flutter_bloc.dart';

class TemperatureUnitCubit extends Cubit<bool> {
  TemperatureUnitCubit() : super(true); // true for Celsius false for Fahrenheit

  void toggleUnit() => emit(!state);

  bool get isCelsius => state;
}

import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final double? temperature;
  final String? locationName;

  const Weather({
    this.temperature,
    this.locationName,
  });

  @override
  List<Object?> get props => [temperature, locationName];
}

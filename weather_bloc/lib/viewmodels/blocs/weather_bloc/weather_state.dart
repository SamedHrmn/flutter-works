import 'package:meta/meta.dart';
import 'package:weather_bloc/models/weather_model.dart';

abstract class WeatherState {
  const WeatherState();
}

class WeatherInitial extends WeatherState {}

class WeatherLoadInProgress extends WeatherState {}

class WeatherLoadSuccess extends WeatherState {
  final Weather weather;

  const WeatherLoadSuccess({@required this.weather}) : assert(weather != null);
}

class WeatherLoadFailure extends WeatherState {}

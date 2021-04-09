import 'package:weather_bloc/models/weather_model.dart';
import 'package:meta/meta.dart';

abstract class ThemeEvent {
  const ThemeEvent();
}

class WeatherChanged extends ThemeEvent {
  final WeatherCondition condition;

  const WeatherChanged({@required this.condition}) : assert(condition != null);
}

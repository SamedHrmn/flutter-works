import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc/repositories/weather_api_client.dart';
import 'package:weather_bloc/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:weather_bloc/viewmodels/blocs/theme_bloc/theme_bloc.dart';
import 'package:weather_bloc/viewmodels/blocs/theme_bloc/theme_state.dart';
import 'package:weather_bloc/viewmodels/blocs/weather_bloc/weather_bloc.dart';
import 'package:weather_bloc/view/weather_screen.dart';

void main() {
  final WeatherRepository weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      httpClient: http.Client(),
    ),
  );

  runApp(
    BlocProvider<ThemeBloc>(
      create: (context) => ThemeBloc(),
      child: MyApp(weatherRepository: weatherRepository),
    ),
  );
}

class MyApp extends StatelessWidget {
  final WeatherRepository weatherRepository;

  MyApp({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: state.theme,
        home: BlocProvider(
          create: (context) => WeatherBloc(weatherRepository: weatherRepository),
          child: WeatherScreen(),
        ),
      ),
    );
  }
}

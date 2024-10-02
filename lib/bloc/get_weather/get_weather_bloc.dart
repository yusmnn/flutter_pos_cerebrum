import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/datasources/remote/weather_datasource.dart';
import '../../data/models/response/get_weather_response_model.dart';

part 'get_weather_event.dart';
part 'get_weather_state.dart';

class GetWeatherBloc extends Bloc<GetWeatherEvent, GetWeatherState> {
  final WeatherDatasource weatherDatasource;
  GetWeatherBloc(this.weatherDatasource) : super(GetWeatherInitial()) {
    on<DoGetWeatherEvent>((event, emit) async {
      try {
        emit(GetWeatherLoading());
        final result = await weatherDatasource.getWeather();
        log('Bloc: $result');
        emit(GetWeatherLoaded(dataWeather: result));
      } catch (e) {
        emit(GetWeatherError(e.toString()));
        log('Bloc: $e');
      }
    });
  }
}

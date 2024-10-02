part of 'get_weather_bloc.dart';

@immutable
sealed class GetWeatherEvent {}

class DoGetWeatherEvent extends GetWeatherEvent {}

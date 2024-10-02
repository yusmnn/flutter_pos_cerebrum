part of 'get_weather_bloc.dart';

@immutable
sealed class GetWeatherState {}

final class GetWeatherInitial extends GetWeatherState {}

final class GetWeatherLoading extends GetWeatherState {}

final class GetWeatherLoaded extends GetWeatherState {
  final GetWeatherResponseModel dataWeather;

  GetWeatherLoaded({required this.dataWeather});
}

final class GetWeatherError extends GetWeatherState {
  final String message;

  GetWeatherError(this.message);
}

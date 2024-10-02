import 'dart:convert';
import 'dart:developer';
import 'package:flutter_pos_cerebrum/data/datasources/endpoint.dart';
import 'package:http/http.dart' as http;
import '../../models/response/get_weather_response_model.dart';

class WeatherDatasource {
  Future<GetWeatherResponseModel> getWeather() async {
    try {
      var response = await http.get(
        Uri.parse(
          '${Endpoint.wilayah}${Endpoint.bandung}',
        ),
      );

      final responseBody = response.body;

      final Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
      final result = GetWeatherResponseModel.fromMap(jsonResponse);

      return result;
    } catch (e, stacktrace) {
      log('Stack Trace: $stacktrace');
      rethrow;
    }
  }
}

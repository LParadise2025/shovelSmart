// CREDIT: https://github.com/Bytx-youtube/flutterapiweather/blob/main/lib/services/weather_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shovel_smart_afg/model/weather.dart';

class WeatherService {
  
  Future<Weather> getWeatherData(String place) async {
    // b392368e5c7e43a9b13154049241903
    try {
      final queryParameters = {
        'key': 'b392368e5c7e43a9b13154049241903',
        //b392368e5c7e43a9b13154049241903
        'q': place,
      };
      final uri = Uri.https('api.weatherapi.com', '/v1/current.json', queryParameters);
      print(uri);
      final response = await http.get(uri);
      if(response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Can not get weather");
      }
    } catch(e) {
      rethrow;
    }
  }
}
import 'package:weather_app/apis/http.dart';
import 'package:weather_app/consts/environment/environment.dart';
import 'package:weather_app/mixin/dio_mixin.dart';

class WeatherDataService {
  Future<Response> getForecastWeatherData(
      {required double lat, required long}) async {
    try {
      // final response = await HTTP.api.get(
      //     '/forecast?lat=$lat&lon=$long&appid=ed76c95f9cc51efcd5d6632686502fa8');
      final response = await HTTP.api
          .get('/forecast?lat=$lat&lon=$long&appid=${Environment.apiKey}');
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<Response> getCurrentWeatherData(
      {required double lat, required long}) async {
    try {
      // final response = await HTTP.api.get(
      //     '/weather?lat=$lat&lon=$long&appid=ed76c95f9cc51efcd5d6632686502fa8');
      final response = await HTTP.api
          .get('/weather?lat=$lat&lon=$long&appid=${Environment.apiKey}');
      return response;
    } catch (error) {
      rethrow;
    }
  }
}

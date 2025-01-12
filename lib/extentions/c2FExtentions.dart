import 'package:weather_app/consts/enum/convertToCF.dart';
import 'package:weather_app/consts/enum/weather_status.dart';

extension TemperatureConversion on double {
  String convertTo(ConvertTo convertTo) {
    switch (convertTo) {
      case ConvertTo.celsius:
        return (this - 273.15).toStringAsFixed(2);
      case ConvertTo.toFahrenheit:
        return ((this - 273.15) * 9 / 5 + 32).toStringAsFixed(2);
    }
  }
}

extension GetWeatherStatus on String {
  WeatherStatus getWeatherStatus() {
    if (this.contains('cloud')) {
      return WeatherStatus.cloudy;
    } else if (this.contains('rain')) {
      return WeatherStatus.rainy;
    } else {
      return WeatherStatus.sunny;
    }
  }
}

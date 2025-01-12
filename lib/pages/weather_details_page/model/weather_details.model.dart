import 'package:json_annotation/json_annotation.dart';
part 'weather_details.model.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherDataModel {
  final Main? main;
  final List<Weather>? weather;
  final int? visibility;
  final double? pop;
  final Sys? sys;
  @JsonKey(name: 'dt_txt')
  final String? dtTxt;

  WeatherDataModel({
    this.main,
    this.weather,
    this.visibility,
    this.pop,
    this.sys,
    this.dtTxt,
  });

  factory WeatherDataModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherDataModelToJson(this);
}

@JsonSerializable()
class Main {
  final double? temp;
  @JsonKey(name: 'feels_like')
  final double? feelsLike;
  @JsonKey(name: 'temp_min')
  final double? tempMin;
  @JsonKey(name: 'temp_max')
  final double? tempMax;
  final int? pressure;
  @JsonKey(name: 'sea_level')
  final int? seaLevel;
  @JsonKey(name: 'grnd_level')
  final int? grndLevel;
  final int? humidity;
  @JsonKey(name: 'temp_kf')
  final double? tempKf;

  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
  });

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);
  Map<String, dynamic> toJson() => _$MainToJson(this);
}

@JsonSerializable()
class Weather {
  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

@JsonSerializable()
class Sys {
  final String? pod;

  Sys({this.pod});

  factory Sys.fromJson(Map<String, dynamic> json) => _$SysFromJson(json);
  Map<String, dynamic> toJson() => _$SysToJson(this);
}

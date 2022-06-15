import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/models/clouds.dart';
import 'package:weather_app/models/main.dart';
import 'package:weather_app/models/sys.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/models/wind.dart';

part 'weather_list.g.dart';

@JsonSerializable()
class WeatherList {
  int? dt;
  Main? main;
  List<Weather>? weather;
  Clouds? clouds;
  Wind? wind;
  int? visibility;
  num? pop;
  Sys? sys;
  @JsonKey(name: 'dt_txt')
  String? dtTxt;

  WeatherList({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.sys,
    this.dtTxt,
  });

  factory WeatherList.fromJson(Map<String, dynamic> json) =>
      _$WeatherListFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherListToJson(this);
}

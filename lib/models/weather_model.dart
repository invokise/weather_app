import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/models/weather_list.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel {
  String? cod;
  int? message;
  int? cnt;
  List<WeatherList>? list;
  City? city;

  WeatherModel({
    this.cod,
    this.message,
    this.cnt,
    this.list,
    this.city,
  });
  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
}

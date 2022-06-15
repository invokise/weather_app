part of 'weather_info_bloc.dart';

@immutable
abstract class WeatherInfoEvent {}

// Событие информация о погоде загружено
class WeatherInfoLoadedEvent extends WeatherInfoEvent {
  // Чтобы извне принять название города
  final String cityName;

  WeatherInfoLoadedEvent({required this.cityName});
}

part of 'weather_info_bloc.dart';

@immutable
abstract class WeatherInfoState {}

// Состояние инициализации
class WeatherInfoInitial extends WeatherInfoState {}

// Состояние загружено
class WeatherInfoLoadedState extends WeatherInfoState {
  // Модель для данных
  final WeatherModel weatherModel;

  WeatherInfoLoadedState({required this.weatherModel});
}

// Состояние ошибки
class WeatherInfoErrorState extends WeatherInfoState {
  // Для получения и вывода и ошибок
  final dynamic error;

  WeatherInfoErrorState({required this.error});
}

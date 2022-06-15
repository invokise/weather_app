import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/resources/weather_api_provider.dart';

part 'weather_info_event.dart';
part 'weather_info_state.dart';

class WeatherInfoBloc extends Bloc<WeatherInfoEvent, WeatherInfoState> {
  WeatherInfoBloc() : super(WeatherInfoInitial()) {
    on<WeatherInfoLoadedEvent>(_onWeatherInfoLoadedEvent);
  }

  // Экземпляр WeatherAPIProvider
  final _weatherAPIProvider = WeatherAPIProvider();

  // Метод который вызовется при возбуждении ивента WeatherInfoLoadedEvent
  _onWeatherInfoLoadedEvent(
      WeatherInfoLoadedEvent event, Emitter<WeatherInfoState> emit) async {
    // Состояние инициализации
    emit(WeatherInfoInitial());
    // блок try/catch чтобы отлавливать ошибки
    try {
      // Заполняем нашу модель данными из сети
      final weatherModel =
          await _weatherAPIProvider.getWeatherInfo(event.cityName);
      // Состояние данные загружены
      emit(WeatherInfoLoadedState(weatherModel: weatherModel));
      // Ловим ошибки
    } catch (e) {
      // Состояние ошибки
      emit(WeatherInfoErrorState(error: e));
    }
  }
}

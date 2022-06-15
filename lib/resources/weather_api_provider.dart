import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

// Здесь происходит запрос в сеть с помощью пакета http.
class WeatherAPIProvider {
  // Ключ который позволяет нам получить доступ к данным openweatherapi
  static const _api = "97535c66f6735430593f9d1c46751055";
  // Базовый url
  static const _baseUrl = "http://api.openweathermap.org/data/2.5/forecast";

  Future<WeatherModel> getWeatherInfo(String cityName) async {
    // Полный url куда будет делаться запрос
    /*
      1)q = cityName - название города ее будет вводить пользователь. Чтобы получить данные о погоде
      в текщуем городе
      
      2)units = metric - говорит о том что температура будет прилетать в Цельсиях

      3)cnt = 3 - говорит о том что данные о погоде прилетят на сегодняшний и последующие 
      2 дня ну вообщем на 3 дня
    */

    final url = '$_baseUrl?q=$cityName&units=metric&cnt=3&appid=$_api';
    // Метод get принимает в себя url типа Uri поэтому мы его парсим в Uri.
    // Также не забываем про async/await, так как процесс занимает некоторое время
    // поэтому нам надо подождать.
    final response = await http.get(Uri.parse(url));
    // Проверяем если код ответа = 200, то есть все хорошо, то берем тело ответа
    // декодируем его и делаем из него нашу модельку WeatherModel.
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
      // В противном случае выкидваем ошибку.
    } else {
      throw Exception('Failed to load weather');
    }
  }
}

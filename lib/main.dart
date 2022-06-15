import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/ui/pages/bloc/weather_info_bloc.dart';
import 'package:weather_app/ui/pages/city/city.dart';

// Точка входа в приложение
void main() {
  // Запуск приложения (виджета) MyApp
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Создания WeatherInfoBloс. Виджеты ниже по дереву смогут получить его
    // с помощью контекста
    return BlocProvider(
      create: (context) => WeatherInfoBloc(),
      child: const MaterialApp(
        home: CityPage(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/ui/pages/bloc/weather_info_bloc.dart';
import 'package:weather_app/ui/pages/weather_info/weather_info.dart';

// Первая страница с текстовым полем и кнопкой, позволяет ввести в текстовое поле
// что угодно, но мы ожидаем город. После нажатия на кнопки перекинет на второую
// страницу, где выведется данные погоды в текущем городе, который пользователь вбил
// или какая-нибудь ошибка
class CityPage extends StatefulWidget {
  const CityPage({Key? key}) : super(key: key);

  @override
  State<CityPage> createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  // Текст контроллер - позволит получить нам текст введенный в текстовое поле
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose city page'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(35),
          child: TextFormField(
            controller: _textEditingController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    // Переход на вторую страницу.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WeatherInfo()),
                    );
                    // Уведомляем блок о новом ивенте
                    BlocProvider.of<WeatherInfoBloc>(context).add(
                        WeatherInfoLoadedEvent(
                            cityName: _textEditingController.text));
                  },
                  icon: const Icon(Icons.search)),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4.0),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Очищаем наш контроллер
    _textEditingController.dispose();
    super.dispose();
  }
}

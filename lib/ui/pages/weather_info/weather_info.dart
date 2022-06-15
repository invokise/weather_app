import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/constants/app_text_styles.dart';
import 'package:weather_app/ui/pages/bloc/weather_info_bloc.dart';
import 'package:weather_app/ui/pages/weather_info_for_3_days/weather_info_for_3_days.dart';

class WeatherInfo extends StatefulWidget {
  const WeatherInfo({Key? key}) : super(key: key);

  @override
  State<WeatherInfo> createState() => _WeatherInfoState();
}

class _WeatherInfoState extends State<WeatherInfo> {
  // Метод который показывает SnackBar
  void showSnackbar(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          error.toString(),
          style: AppTextStyles.text16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // StreamBuilder для слежки за состоянием интернета.
    return StreamBuilder(
        initialData: ConnectivityResult.none,
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Weather info'),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    // Переход на третью страницу
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WeatherInfoFor3Days(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.navigate_next),
                ),
              ],
            ),
            // Внутри BlocBuilder реализуем все наши стейты
            body: BlocBuilder<WeatherInfoBloc, WeatherInfoState>(
                builder: (context, state) {
              // При состоянии инициализации
              if (state is WeatherInfoInitial) {
                return const Center(
                  child: CircularProgressIndicator(),
                );

                // При состоянии когда данные загружены
              } else if (state is WeatherInfoLoadedState) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          // Из стейта берем нашу модель и выводим данные
                          state.weatherModel.city!.name.toString(),
                          style: AppTextStyles.text24,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        // Из стейта берем нашу модель и выводим данные, также я тут округлил
                        // температуру, так как обычно температуру показывают целым.
                        'Температура: ${state.weatherModel.list![0].main!.temp!.round()} °C',
                        style: AppTextStyles.text16,
                      ),
                      Text(
                        // Из стейта берем нашу модель и выводим данные
                        'Скорость ветра: ${state.weatherModel.list![0].wind!.speed} м',
                        style: AppTextStyles.text16,
                      ),
                      Text(
                        // Из стейта берем нашу модель и выводим данные
                        'Влажность: ${state.weatherModel.list![0].main!.humidity} %',
                        style: AppTextStyles.text16,
                      ),
                    ],
                  ),
                );
                // При состоянии ошибки
              } else if (state is WeatherInfoErrorState) {
                // Если подключения к интернету нет, то выводим следующий snackbar
                if (snapshot.data == ConnectivityResult.none) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showSnackbar('Нет подключения к интернету!');
                  });
                  // Иначе выводим следующий snackbar
                } else {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showSnackbar(state.error.toString());
                  });
                }
                // Также помимо snackbar показываем текст с ошибкой
                return const Center(
                  child: Text(
                    'Ошибка получения данных',
                    style: AppTextStyles.text16,
                  ),
                );
                // Иначе
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/constants/app_text_styles.dart';
import 'package:weather_app/ui/pages/bloc/weather_info_bloc.dart';
import 'package:weather_app/ui/pages/weather_info_for_3_days/widgets/weather_info_card.dart';

class WeatherInfoFor3Days extends StatelessWidget {
  const WeatherInfoFor3Days({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather info for 3 days'),
        centerTitle: true,
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
          // Из стейта берем нашу модель из него список, где хранятся наши погоды
          // далее сортируем список погод по температуре,
          // сначала идет маленькая и по увеличению
          state.weatherModel.list!.sort((a, b) {
            return a.main!.temp!.compareTo(b.main!.temp!.toDouble());
          });
          return ListView.builder(
              itemCount: state.weatherModel.list!.length,
              itemBuilder: (context, index) {
                return WeatherInfoCardWidget(
                  // Из стейта берем нашу модель и выводим данные
                  temp: state.weatherModel.list![index].main!.temp!.round(),
                  windSpeed: state.weatherModel.list![index].wind!.speed ?? 0,
                  humidity: state.weatherModel.list![index].main!.humidity ?? 0,
                );
              });
          // При состоянии ошибки
        } else if (state is WeatherInfoErrorState) {
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
  }
}

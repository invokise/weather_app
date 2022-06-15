import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_text_styles.dart';

class WeatherInfoCardWidget extends StatelessWidget {
  const WeatherInfoCardWidget({
    Key? key,
    required this.temp,
    required this.windSpeed,
    required this.humidity,
  }) : super(key: key);

  final int temp;
  final double windSpeed;
  final int humidity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Card(
        color: Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Center(
          child: Column(
            children: [
              Text(
                'Температура: $temp °C',
                style: AppTextStyles.text24,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Скорость ветра: $windSpeed м',
                style: AppTextStyles.text16,
              ),
              Text(
                'Влажность: $humidity %',
                style: AppTextStyles.text16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

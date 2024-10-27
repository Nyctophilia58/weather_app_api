import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  final _weatherService = WeatherService(apiKey: 'YOUR_API_KEY');
  WeatherModel? _weather;

  _fetchWeather() async {
    // String cityName = await _weatherService.getCurrentCity();

    String cityName = 'Tangail';
    try {
      final weather = await _weatherService.getWeather(cityName);

      setState(() {
        _weather = weather;
      });
    }
    catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation (String? mainCondition) {
    if (mainCondition == null) return 'lib/assets/sunny.json';

    switch (mainCondition) {
      case 'fog':
        return 'lib/assets/cloudy.json';
      case 'shower rain':
        return 'lib/assets/rainy.json';
      case 'clear':
        return 'lib/assets/sunny.json';
      case 'thunderstorm':
        return 'lib/assets/storm.json';
      default:
        return 'lib/assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _weather?.cityName ?? 'Loading city...'
            ),

            Lottie.asset(
              getWeatherAnimation(_weather?.mainCondition),
            ),

            Text(
              '${_weather?.temperature.round()}°C'
            ),

            Text(
              _weather?.mainCondition ?? ''
            ),
          ],
        )
      )
    );
  }
}
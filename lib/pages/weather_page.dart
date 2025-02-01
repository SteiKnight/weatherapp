import 'package:flutter/material.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  WeatherService weatherService =
      WeatherService(apiKey: '043ecd32eeb49d22b709900c559b5c6c');
  Weather? weather;

  //fetch weather data
  Future<void> fetchWeather() async {
    //get current city name
    String cityName = await weatherService.getCurrentCity();

    //get weather for that city
    try {
      Weather fetchedWeather = await weatherService.getWeather(cityName);
      setState(() {
        this.weather = fetchedWeather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //fetch weather on startup
    fetchWeather();
  }

  //weather animations

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //City name'
          Text(weather?.cityName ?? 'Loading city...'),

          //animation

          //temperature
          Text(weather != null
              ? '${weather!.temperature.round()}°C'
              : 'Loading temperature...'),
        ],
      ),
    ));
  }
}

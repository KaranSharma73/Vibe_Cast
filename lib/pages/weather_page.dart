import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherService = WeatherService('68f6b98329d471cb34fa4acba97c2cda');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // get current city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    // any errors
    catch (e) {
      print(e);
    }
  }

  // weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/images/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'haze':
      case 'smoke':
      case 'dust':
      case 'fog':
        return 'assets/images/windy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/images/storm_shower.json';
      case'night':
        return 'assets/images/night.json';
      case 'storm shower':
        return 'assets/images/storm_shower.json';
      case 'storm':
        return 'assets/images/storm.json';
      case 'snow':
        return 'assets/images/snow.json';
      case 'snow sunny':
        return 'assets/images/snow_sunny.json';
      case 'thunder':
        return 'assets/images/thunder.json';
        
      default: 
        return 'assets/images/sunny.json';
    }
  }

  // init state
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("VibeCast",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        centerTitle: true,

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Text(
              _weather?.cityName ?? "loading city..",
              style: TextStyle(fontSize: 30.0,color: Colors.white),
            ),
            Icon(Icons.location_on,color: Colors.white,size: 20.0,),

            // animations

            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            // Temperature
            Text(
              '${_weather?.temperature.round()}°',
              style: TextStyle(fontSize: 80.0,color: Colors.amberAccent),
            ),

            // Weather condition
            Text(_weather?.mainCondition ?? "",style: TextStyle(color: Colors.white, fontSize: 20.0),),

            Container(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}

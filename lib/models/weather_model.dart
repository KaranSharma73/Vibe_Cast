import 'package:flutter/foundation.dart';

class Weather{
  final String cityName;
  final double temperature;
  final String mainCondition;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,});


  factory Weather.fromJson(Map<String, dynamic> json) => Weather(cityName: json['name'], temperature: json['main']['temp'].toDouble(), mainCondition: json['weather'][0]['main'],);
}
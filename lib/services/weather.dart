import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/cupertino.dart';

const apikey = '3b586f5920797798470cfb74f43158e4';
const openMapApi = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getcityName(cityName) async {
    Networking network =
        Networking('$openMapApi?q=$cityName&appid=$apikey&units=metric');
    var weatherData = await network.apicall();
    return weatherData;
  }

  Future<dynamic> getweatherData() async {
    Location location = Location();
    await location.getCurrentLocation();
    // latitude = location.latitude;
    // longitude = location.longitude;
    Networking network = Networking(
        '$openMapApi?lat=${location.latitude}&lon=${location.longitude}&appid=$apikey&units=metric');
    var weatherData = await network.apicall();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return 'Stormy';
    } else if (condition < 400) {
      return 'Rainy';
    } else if (condition < 600) {
      return 'It Might Rain';
    } else if (condition < 700) {
      return 'Snowy';
    } else if (condition < 800) {
      return 'Foggy';
    } else if (condition == 800) {
      return 'Sunny️';
    } else if (condition <= 804) {
      return 'Cloudy️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  AssetImage getimages(dynamic condition) {
    if (condition < 300) {
      return AssetImage('images/stormy.jpg');
    } else if (condition < 400) {
      return AssetImage('images/rainy.jpg');
    } else if (condition < 600) {
      return AssetImage('images/it might rain.jpg');
    } else if (condition < 700) {
      return AssetImage('images/snowy.jpg');
    } else if (condition < 800) {
      return AssetImage('images/foggy.jpg');
    } else if (condition == 800) {
      return AssetImage('images/sunny.jpg');
    } else if (condition <= 804) {
      return AssetImage('images/cloudy.jpg');
    } else {
      return AssetImage('images/location_background.jpg');
    }
  }
}

import '/services/location.dart';

import '/services/networking.dart';
const apiKey = 'c0fcf9d84b7e55d44ea67ef8247b50c0';
const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
class WeatherModel {

  Future<dynamic> getCityWeather(String city) async {
    String url = '$baseUrl?q=$city&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var watherData = await networkHelper.getData();

    return watherData;
  }

  Future<dynamic> getLocationWeather() async{
    Location location = new Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper =  NetworkHelper('$baseUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    print(networkHelper.getData());
    var weatherData = await networkHelper.getData();
    return weatherData;
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
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
}


import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import '/services/weather.dart';
import '/screens/city_screen.dart';
class LocationScreen extends StatefulWidget {
  final locationWeather;
  LocationScreen({this.locationWeather});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  dynamic temp;
  String name;
  String weatherIcon;
  String weatherMessage;
  WeatherModel weather = new WeatherModel();
  @override
    void initState() {

      super.initState();
      //print(widget.locationWeather);
      updateUi(widget.locationWeather);
    }
  void updateUi(dynamic weatherData) {
    
    setState(() {
      temp = weatherData['main']['temp'].toInt();
      name = weatherData['name'];
      var condstion = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condstion);
      weatherMessage = weather.getMessage(temp);
      print(weatherIcon);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUi(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async{
                      var typeNamed = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>CityScreen()
                        )
                      );

                      if(typeNamed != null)  {
                        print(typeNamed);
                        var weatherData = await weather.getCityWeather(typeNamed);
                        print(weatherData);
                        updateUi(weatherData);
                      }
     
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage $name',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

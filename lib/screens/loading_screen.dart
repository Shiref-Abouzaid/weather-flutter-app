import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import '/screens/location_screen.dart';
import '/services/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double lat;
  double lng;

  //get location
  void getLocation()  async{




    WeatherModel weathermodel = new WeatherModel();
    var weatherData = await weathermodel.getLocationWeather();

    Navigator.push(context,MaterialPageRoute(
      builder: (context){
        return LocationScreen(locationWeather:weatherData);
      }
    ));
  }

  @override
  void initState() {
    super.initState();
    getLocation();

  }

  @override
  void deactivate() {
    super.deactivate();
    print('deactivite');
  }

  void getData() async {

  }
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SpinKitWanderingCubes(
          color: Colors.white,

          size: 150,
        ),
      ),
    );
  }
}

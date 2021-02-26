import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  int temperature;
  int conditionId;
  String city;
  String weathertype;
  String message;
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        Alert(context: context, title: "ERROR", desc: "Something went wrong.")
            .show();
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      conditionId = weatherData['weather'][0]['id'];
      weathertype = weatherModel.getWeatherIcon(conditionId);
      message = weatherModel.getMessage(temperature);
      city = weatherData['name'];
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
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getweatherData();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.location_on_rounded,
                      size: 30.0,
                    ),
                  ),
                  Text(
                    'Weatherman',
                    style: TextStyle(fontSize: 30),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var cityOutput = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (cityOutput != null) {
                        var weather = await weatherModel.getcityName(cityName);
                        updateUI(weather);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 80,
              ),
              Center(
                child: Text(
                  "$city",
                  style: kMessageTextStyle,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '$temperature°c',
                        style: kTempTextStyle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        weathertype,
                        style: kConditionTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(right: 15.0),
              //   child: Text(
              //     '$message in $city',
              //     textAlign: TextAlign.right,
              //     style: kMessageTextStyle,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

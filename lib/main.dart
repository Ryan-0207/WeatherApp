import 'dart:ui';

import 'package:flutter/material.dart';
import 'page2.dart';
import 'getData.dart';
import 'Models.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Weather',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _getData = getData();
  WeatherResponse _response1;

  @override
  void initState() {
    super.initState();

    getPosition().then((position) async {
      final result = await _getData.getWeatherData(
          position.latitude.toString(), position.longitude.toString());
      print(result.cityName);
      print(result.tempInfo.temperature);
      print(result.weatherInfo.description);
      setState(() {
        _response1 = result;
      });
    });
  }

  Future<Position> getPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text('Current Weather'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_response1 != null)
              Column(
                children: <Widget>[
                  Image.network(_response1.iconUrl),
                  Text(
                    '${_response1.tempInfo.temperature} °C',
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    _response1.weatherInfo.description,
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    _response1.cityName,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            new RaisedButton(
              child: Text(
                'Other Locations',
                style: TextStyle(color: Colors.black),
              ),
              color: Colors.red,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Page2()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

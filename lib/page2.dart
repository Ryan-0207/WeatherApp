import 'package:flutter/material.dart';
import 'package:weather2/getdata2.dart';
import 'getData.dart';
import 'Models.dart';

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  WeatherResponse _response;
  TextEditingController city = TextEditingController();
  final _getData = getData2();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('City Weather'),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.yellow[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_response != null)
              Column(
                children: <Widget>[
                  Image.network(_response.iconUrl),
                  Text(
                    '${_response.tempInfo.temperature} °C',
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    _response.weatherInfo.description,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: TextField(
                  style: TextStyle(color: Colors.blue, fontSize: 30),
                  controller: city,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.location_on,
                      color: Colors.red,
                    ),
                    labelText: 'City',
                    labelStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                  ),
                ),
              ),
            ),
            new RaisedButton(
                child: Text(
                  'Search',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.red,
                onPressed: _search)
          ],
        ),
      ),
    );
  }

  void _search() async {
    final result = await _getData.getWeatherData(city.text);
    // Future.delayed(Duration(seconds: 1));
    print(result.cityName);
    setState(() => _response = result);
  }
}

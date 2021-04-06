import 'dart:convert';
import 'package:http/http.dart' as https;
import 'Models.dart';

class getData2 {
  Future<WeatherResponse> getWeatherData(String city) async {
    final inputData = {
      'q': city,
      'appid': '81e6928b0bff92415533ce30556be869',
      'units': 'metric'
    };

    final uri =
        Uri.https('api.openweathermap.org', '/data/2.5/weather', inputData);

    final result = await https.get(uri);
    print(result.body);
    final json = jsonDecode(result.body);
    return WeatherResponse.fromJson(json);
  }
}

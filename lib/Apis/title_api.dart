import '../model/model_title.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<PowerSeries> fetchPowerSeries(String title, String apiKey) async {
  final url = 'http://www.omdbapi.com/?apikey=$apiKey&t=$title';

  // Send a GET request to the API
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // If the request is successful, parse the JSON data
    final Map<String, dynamic> jsonData = json.decode(response.body);
    if (jsonData['Response'] == 'True') {
      return PowerSeries.fromJson(jsonData); // Return parsed object
    } else {
      throw Exception('Failed to load series data');
    }
  } else {
    throw Exception('Failed to fetch data');
  }
}

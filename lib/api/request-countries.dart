
import 'dart:convert';

import 'package:calendar_app/api/core.api.dart';
import 'package:calendar_app/api/country.api.dart';
import 'package:http/http.dart' as http;

Future<List<Country>> loadCountryList(String baseUrl, String language) async {
  var url = Uri.parse('$baseUrl/Countries?languageIsoCode=$language');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return fromArray(data, (row) => Country.fromJson(row));
  }
  throw Exception('Failed to load the list of countries (code=$response.statusCode)');
}
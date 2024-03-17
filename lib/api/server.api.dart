import 'dart:convert';

import 'package:calendar_app/api/core.api.dart';
import 'package:calendar_app/api/country.api.dart';
import 'package:http/http.dart' as http;

class Server {
  final String baseUrl;
  Server({required this.baseUrl});

  Future<List<Country>> getCountryList(String language) async {
    var url = Uri.parse('$baseUrl/Countries?languageIsoCode=$language');
    var result = await http.get(url);
    if (result.statusCode != 200) {
      return Future.error('Could not get country list');
    }
    var data = json.decode(result.body);

    return Future.value(fromArray(data, (row) => Country.fromJson(row)));
  }
}

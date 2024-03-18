// ignore_for_file: file_names

import 'dart:convert';

import 'package:calendar_app/api/core.api.dart';
import 'package:calendar_app/api/country.api.dart';
import 'package:calendar_app/api/language.api.dart';
import 'package:calendar_app/start/start-state.dart';
import 'package:calendar_app/country/country-state.dart';
import 'package:calendar_app/holiday-state.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


class HolidayService {
  static const Map<String, String> headers = {
    'accept': 'application.json'
  };

  static Future<StartState> loadLanguageList(BuildContext context) async {
    final state = Provider.of<HolidayState>(context);
    var url = Uri.parse('${state.baseUrl}/Languages?languageIsoCode=${state.language}');
    var response = await http.get(url, headers: headers);
    if (response.statusCode != 200) {
      throw Exception('Failed to load language list (status=${response.statusCode})');
    }
    var data = json.decode(response.body);
    var languages = fromArray(data, (row) => Language.fromJson(row));

    state.updateLanguages(languages);

    return StartState(state.languages, state.language, (language) {
      state.selectLanguage(language.code);
    });
  }

  static Future<CountryState> loadCountryList(BuildContext context) async {
    final state = Provider.of<HolidayState>(context);
    if (state.isCountryListEmpty) {
      var url = Uri.parse('${state.baseUrl}/Countries?languageIsoCode=$state.language');
      var response = await http.get(url, headers: headers);
      if (response.statusCode != 200) {
        throw Exception('Failed to load country list (status=${response.statusCode})');
      }
      var data = json.decode(response.body);
      var countries = fromArray(data, (row) => Country.fromJson(row));

      state.updateCountries(countries);
    }
    return CountryState(state.countries, state.selectCountryCode, (CountryItem country) {
      state.selectCountry(country);
    });
  }
}

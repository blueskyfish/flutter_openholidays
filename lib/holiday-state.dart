
import 'dart:collection';

import 'package:calendar_app/api/country.api.dart';
import 'package:calendar_app/api/language.api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HolidayState extends ChangeNotifier {

  /// The base url to the open holidays api
  final String baseUrl = 'https://openholidaysapi.org';

  var _language = 'de';

  var _languageMap = <String, LanguageItem>{};
  /// The list of countries from the open holidays api
  List<CountryItem> _countries = List.empty();

  var _selectCountryCode = '';

  String get language => _language;

  bool get isCountryListEmpty => _countries.isEmpty;

  void updateLanguages(List<Language> languages) {
    var languageMap = <String, LanguageItem>{};
    for (var lang in languages) {
      languageMap[lang.isoCode] = LanguageItem.from(lang);
    }
    _languageMap = languageMap;
    notifyListeners();
  }

  List<LanguageItem> fromLanguage(List<String> languages) {
    return languages.map((lang) => _languageMap[lang] ?? _languageMap['de']!).toList();
  }

  void updateCountries(List<Country> countries) {
    _countries = countries.map((Country c) => CountryItem.from(c)).toList(growable: false);
    notifyListeners();
  }

  void selectLanguage(String language) {
    if (_language != language) {
      _language = language;
      notifyListeners();
    }
  }

  void selectCountry(CountryItem country) {
    if (_selectCountryCode != country.code) {
      _selectCountryCode = country.code;
      notifyListeners();
    }
  }

  String get selectCountryCode => _selectCountryCode;

  List<CountryItem> get countries => _countries;

  List<LanguageItem> get languages => List.of(_languageMap.values);

  bool isCountrySelected(CountryItem country) {
    return _selectCountryCode == country.code;
  }

  bool hasCountrySelect() {
    return _selectCountryCode != '';
  }


  reset() {
    _selectCountryCode = '';
    _countries = List.empty();
  }
}
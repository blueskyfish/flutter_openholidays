import 'package:calendar_app/api/country.api.dart';
import 'package:calendar_app/api/language.api.dart';
import 'package:calendar_app/common/icon-list-widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HolidayState extends ChangeNotifier {
  /// The base url to the open holidays api
  final String baseUrl = 'https://openholidaysapi.org';

  /// The language code in the request
  var _languageCode = 'de';

  // The map with all languages. The isoCode in lower case is the key
  var _languageMap = <String, IconListItem>{};

  /// The list of countries from the open holidays api
  List<IconListItem> _countries = List.empty();

  /// The selected country code
  var _selectCode = '';

  /// Getter property for the selected language
  String get language => _languageCode;

  /// Check if the list of countries is empty
  bool get isCountryListEmpty => _countries.isEmpty;

  bool get isLanguageMapEmpty => _languageMap.values.isEmpty;

  /// Update with the new list of languages
  void updateLanguages(List<Language> languages) {
    var languageMap = <String, IconListItem>{};
    for (var lang in languages) {
      languageMap[lang.isoCode.toLowerCase()] = IconListItem.fromLanguage(lang);
    }
    _languageMap = languageMap;
    notifyListeners();
  }

  List<IconListItem> fromLanguage(List<String> languages) {
    return languages.map((lang) => _languageMap[lang] ?? _languageMap['de']!).toList();
  }

  void updateCountries(List<Country> countries) {
    _countries = countries.map((Country c) => IconListItem.fromCountry(c)).toList(growable: false);
    notifyListeners();
  }

  void selectLanguage(String language) {
    _languageCode = language;
    notifyListeners();
  }

  void selectCountry(IconListItem country) {
    _selectCode = country.code;
    notifyListeners();
  }

  String get selectCountryCode => _selectCode;

  List<IconListItem> get countries => _countries;

  List<IconListItem> get languages => List.of(_languageMap.values);

  bool hasCountrySelect() {
    return _selectCode != '';
  }

  reset() {
    _selectCode = '';
    _languageMap = {};
    _countries = List.empty();
  }
}

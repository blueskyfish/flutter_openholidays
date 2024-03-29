import 'package:calendar_app/api/country.api.dart';
import 'package:calendar_app/api/holiday.api.dart';
import 'package:calendar_app/api/language.api.dart';
import 'package:calendar_app/common/holiday-list-widgets.dart';
import 'package:calendar_app/common/icon-list-widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HolidayState extends ChangeNotifier {
  var _initiaizedLocales = false;

  var _backendRunning = false;

  /// The base url to the open holidays api
  final String baseUrl = 'https://openholidaysapi.org';

  /// The default language
  String _defaultLanguageCode = 'de';
  /// The default country
  String _defaultCountryCode = 'de';

  /// The language code in the request
  var _languageCode = 'de';

  // The map with all languages. The isoCode in lower case is the key
  var _languageMap = <String, IconListItem>{};

  /// The list of countries from the open holidays api
  List<IconListItem> _countries = List.empty();

  /// The list of holidays by the selected country in the selected language
  List<HolidayListItem> _holidays = List.empty();

  /// The selected country code
  var _countryCode = '';

  /// The selected holiday id
  var _holidayId = '';

  /// Getter property for the selected language
  String get languageCode => _languageCode;

  /// Getter property for the selected country
  String get countryCode => _countryCode;

  String get holidayId => _holidayId;

  /// Check if the list of countries is empty
  bool get isCountryListEmpty => _countries.isEmpty && !_backendRunning;

  /// Check if the map of languages is empty
  bool get isLanguageMapEmpty => _languageMap.values.isEmpty && !_backendRunning;

  bool get isHolidayListEmpty => _holidays.isEmpty && !_backendRunning;

  List<IconListItem> get countries => _countries;

  List<IconListItem> get languages => List.of(_languageMap.values);

  List<HolidayListItem> get holidays => _holidays;

  bool get backendRunning => _backendRunning;

  HolidayState() {
    _languageCode = _defaultLanguageCode;
    _countryCode = _defaultCountryCode;
  }

  /// Initialized the locales from the os settings
  initLocales(BuildContext context) {
    if (_initiaizedLocales) {
      return;
    }
    _initiaizedLocales = true;
    try {
      var locales = Localizations.localeOf(context);
      _defaultCountryCode = locales.countryCode ?? locales.languageCode;
      _defaultLanguageCode = locales.languageCode;
      _languageCode = _defaultLanguageCode;
      _countryCode = _defaultCountryCode;

      print('Locales (language=$_defaultLanguageCode, country=$_defaultCountryCode)');
    } catch (e) {
      print('Error by initized locales ${e.toString()}');
    }
  }

  void startBackend() {
    _backendRunning = true;
    print('Backend is running');
  }

  /// Update with the new list of languages
  void updateLanguages(List<Language> languages) {
    var languageMap = <String, IconListItem>{};
    for (var lang in languages) {
      languageMap[lang.isoCode.toLowerCase()] = IconListItem.fromLanguage(lang);
    }
    _languageMap = languageMap;
    _backendRunning = false;
    notifyListeners();
  }

  List<IconListItem> fromLanguage(List<String> languages) {
    return languages.map((lang) => _languageMap[lang] ?? _languageMap['de']!).toList();
  }

  void updateCountries(List<Country> countries) {
    _countries = countries.map((Country c) => IconListItem.fromCountry(c)).toList(growable: false);
    _backendRunning = false;
    notifyListeners();
  }

  void updateHolidays(List<Holiday> holidays) {
    _holidays = holidays.map((Holiday holiday) => HolidayListItem.from(holiday)).toList(growable: false);
    _backendRunning = false;
    notifyListeners();
  }

  void selectLanguage(String language) {
    _languageCode = language;
    notifyListeners();
  }

  void selectCountry(IconListItem country) {
    _countryCode = country.code;
    notifyListeners();
  }

  void selectHoliday(HolidayListItem holiday) {
    _holidayId = holiday.id;
    notifyListeners();
  }

  /// Reset to the default values
  void resetState() {
    print('reset all');
    _countryCode = _defaultCountryCode;
    _languageCode = _defaultLanguageCode;
    _languageMap = {};
    _countries = List.empty();
    _holidayId = '';
    _holidays = List.empty();
  }

  void resetHolidays() {
    print('reset holidays');
    _holidayId = '';
    _holidays = List.empty();
  }

  void resetCounties() {
    print('reset countries');
    _countryCode = _defaultCountryCode;
    _countries = List.empty();
  }

  void resetLanguages() {
    print('reset languages');
    _languageCode = _defaultCountryCode;
    _languageMap = {};
  }
}

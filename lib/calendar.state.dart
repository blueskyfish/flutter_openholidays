
import 'package:calendar_app/models/country.dart';
import 'package:flutter/material.dart';

class CalendarState extends ChangeNotifier {
  var selectKey = '';
  var countries = buildCountries();

  void selectCountry(CountryItem country) {
    if (selectKey != country.key) {
      selectKey = country.key;
      notifyListeners();
    }
  }

  bool isSelected(CountryItem country) {
    return selectKey == country.key;
  }

  bool hasCountrySelect() {
    return selectKey != '';
  }

  reset() {
    selectKey = '';
  }
}

import 'package:calendar_app/api/country.api.dart';

typedef SelectCountry = void Function(CountryItem country);

class CountryState {
  final String selectCode;
  final SelectCountry selectCountry;
  late final List<CountryItem> _countries;
  
  
  CountryState(List<CountryItem> countries, this.selectCode, this.selectCountry) {
    _countries = countries;
  }

  int get length => _countries.length;
  List<CountryItem> get countries => _countries;
  
  bool isCountrySelected(CountryItem country) {
    return selectCode == country.code;
  }
}
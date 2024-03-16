
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class CountryItem {
  final String key;
  final String title;
  late String assetName;

  Widget? _flag;

  CountryItem(this.key, this.title) {
    assetName = 'assets/images/country/$key.svg';
  }

  Widget get flag {
    _flag ??= SvgPicture.asset(assetName);
    return _flag!;
  }
}

List<CountryItem> buildCountries() {
  return List.unmodifiable([
    CountryItem('de', 'Germany'),
    CountryItem('at', 'Austria'),
    CountryItem('fr', 'France'),
    CountryItem('it', 'Italy'),
  ]);
}
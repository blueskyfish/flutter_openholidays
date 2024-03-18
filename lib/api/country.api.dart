import 'package:calendar_app/api/core.api.dart';
import 'package:calendar_app/api/name.api.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class Country {
  final String isoCode;
  final List<Name> name;
  final List<String> officialLanguages;

  Country({
    required this.isoCode,
    required this.name,
    required this.officialLanguages,
  });

  factory Country.fromJson(Map<String, dynamic> data) {
    final isoCode = asString(data, 'isoCode');
    final officialLanguages = asList(data, 'officialLanguages', (row) => row.toString());
    final name = asList(data, 'name', (row) => Name.fromJson(row));

    return Country(
      isoCode: isoCode,
      name: name,
      officialLanguages: officialLanguages,
    );
  }
}

/// ListView item with the country entity
class CountryItem {
  final String code;
  final String name;
  final List<String> languages;
  late final String assetName;
  Widget? _flag;

  CountryItem({required this.code, required this.name, required this.languages}) {
    assetName = 'assets/images/country/${code.toLowerCase()}.svg';
  }

  /// Returns the country flag
  Widget get flag {
    _flag ??= _loadAssetFlag(assetName);
    return _flag!;
  }
  Widget _loadAssetFlag(String assetName) {
    try {
      return SvgPicture.asset(assetName);
    } catch (e) {
      return SvgPicture.asset('assets/images/country/xx.svg');
    }
  }

  /// Create the ListView item from country entity
  factory CountryItem.from(Country country) {
    final name = country.name[0].text;
    return CountryItem(
      code: country.isoCode,
      name: name,
      languages: country.officialLanguages,
    );
  }
}

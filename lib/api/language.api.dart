import 'package:calendar_app/api/core.api.dart';
import 'package:calendar_app/api/name.api.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class Language {
  final String isoCode;
  final List<Name> name;

  Language({required this.isoCode, required this.name});

  factory Language.fromJson(Map<String, dynamic> data) {
    final isoCode = asString(data, 'isoCode');
    final name = asList(data, 'name', (row) => Name.fromJson(row));

    return Language(
      isoCode: isoCode,
      name: name,
    );
  }
}

class LanguageItem {
  final String code;
  final String name;
  late final String assetName;

  Widget? _flag;

  LanguageItem({required this.code, required this.name}) {
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

  factory LanguageItem.from(Language language) {
    final name = language.name[0].text;

    return LanguageItem(
      code: language.isoCode,
      name: name,
    );
  }
}

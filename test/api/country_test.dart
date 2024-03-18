import 'dart:convert';

import 'package:calendar_app/api/core.api.dart';
import 'package:calendar_app/api/country.api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Country deserialized', () {
    var source = '''{
      "isoCode": "DE",
      "name": [{"text": "Deutschland", "language": "DE"}],
      "officialLanguages": ["DE"]
    }''';
    var result = json.decode(source);
    var country = Country.fromJson(result);

    expect(country.isoCode, 'DE');
    expect(country.name.length, 1);
    expect(country.officialLanguages, ['DE']);
  });

  test('List of Country deserialized', () {
    var source = '''
[
  {
    "isoCode": "AL",
    "name": [
      {
        "language": "DE",
        "text": "Albanien"
      }
    ],
    "officialLanguages": [
      "SQ"
    ]
  },
  {
    "isoCode": "AT",
    "name": [
      {
        "language": "DE",
        "text": "Österreich"
      }
    ],
    "officialLanguages": [
      "DE"
    ]
  }
]''';
    var data = json.decode(source);

    var list = fromArray(data, (data) => Country.fromJson(data));

    // ignore: unnecessary_type_check
    expect(list is List, true);
    expect(list.length, 2);
  });
}

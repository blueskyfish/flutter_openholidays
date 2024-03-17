import 'dart:convert';

import 'package:calendar_app/api/region.api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Region deserialized', () {
    var source = '''
{
  "code": "DE-BB",
  "isoCode": "DE-BB",
  "shortName": "BB",
  "category": [
    {
      "language": "DE",
      "text": "Bundesland"
    }
  ],
  "name": [
    {
      "language": "DE",
      "text": "Brandenburg"
    }
  ],
  "officialLanguages": [
    "DE"
  ]
}
''';
    var data = json.decode(source);
    var region = Region.fromJson(data);
    expect(region.code, 'DE-BB');
    expect(region.isoCode, 'DE-BB');
    expect(region.category[0].text, 'Bundesland');
    expect(region.name[0].text, 'Brandenburg');
  });
}

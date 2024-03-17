import 'dart:convert';

import 'package:calendar_app/api/core.api.dart';
import 'package:calendar_app/api/language.api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Language deserialized', () {
    var source = '''
[
  {
    "isoCode": "BG",
    "name": [
      {
        "language": "DE",
        "text": "Bulgarisch"
      }
    ]
  },
  {
    "isoCode": "CS",
    "name": [
      {
        "language": "DE",
        "text": "Tschechisch"
      }
    ]
  }
]''';

    var data = json.decode(source);
    var items = fromArray(data, (row) => Language.fromJson(row));
    expect(items.length, 2);
    expect(items[0].isoCode, 'BG');
    expect(items[0].name[0].text, 'Bulgarisch');
  });
}

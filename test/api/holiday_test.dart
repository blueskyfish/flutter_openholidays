import 'dart:convert';

import 'package:calendar_app/api/holiday.api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Holiday deserialized', () {
    var source = '''
{
  "id": "ed4084d4-897c-4c1c-9d11-837874a5122f",
  "startDate": "2023-11-01",
  "endDate": "2023-11-01",
  "type": "Public",
  "name": [
    {
      "language": "DE",
      "text": "Allerheiligen"
    }
  ],
  "nationwide": false,
  "subdivisions": [
    {
      "code": "DE-SL",
      "shortName": "SL"
    },
    {
      "code": "DE-BY",
      "shortName": "BY"
    },
    {
      "code": "DE-BW",
      "shortName": "BW"
    },
    {
      "code": "DE-RP",
      "shortName": "RP"
    },
    {
      "code": "DE-NW",
      "shortName": "NW"
    }
  ]
}
''';
    var data = json.decode(source);
    var holiday = Holiday.fromJson(data);
    expect(holiday.startDate, '2023-11-01');
    expect(holiday.endDate, '2023-11-01');
    expect(holiday.name[0].text, 'Allerheiligen');
    expect(holiday.nationwide, false);
    expect(holiday.regions?.length, 5);
    expect(holiday.comment, null);
    expect(holiday.qualitiy, null);
  });
}

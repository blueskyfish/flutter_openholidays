import 'dart:convert';

import 'package:calendar_app/api/name.api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Name deserialized', () {
    var source = '{"text": "Deutschland", "language": "DE"}';
    var result = json.decode(source);
    var cn = Name.fromJson(result);

    expect(cn.text, 'Deutschland');
  });
}

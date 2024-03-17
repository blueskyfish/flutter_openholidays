import 'package:calendar_app/api/server.api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Server server;
  setUp(() => server = Server(baseUrl: 'https://openholidaysapi.org'));

  test('Get list of Countries', () async {
    var list = await server.getCountryList('DE');
    expect(list[0].name[0].text, 'Albanien');
  });
}

import 'package:calendar_app/api/core.api.dart';
import 'package:calendar_app/api/name.api.dart';

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
    final officialLanguages =
        asList(data, 'officialLanguages', (row) => row.toString());
    final name = asList(data, 'name', (row) => Name.fromJson(row));

    return Country(
      isoCode: isoCode,
      name: name,
      officialLanguages: officialLanguages,
    );
  }
}

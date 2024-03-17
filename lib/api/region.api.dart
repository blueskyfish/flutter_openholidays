import 'package:calendar_app/api/core.api.dart';
import 'package:calendar_app/api/name.api.dart';

class Region {
  final String code;
  final String isoCode;
  final String shortName;
  final List<Name> category;
  final List<Name> name;
  final List<String> officialLanguages;

  Region({
    required this.code,
    required this.isoCode,
    required this.shortName,
    required this.category,
    required this.name,
    required this.officialLanguages,
  });

  factory Region.fromJson(Map<String, dynamic> data) {
    final code = asString(data, 'code');
    final isoCode = asString(data, 'isoCode');
    final shortName = asString(data, 'shortName');
    final category = asList(data, 'category', (row) => Name.fromJson(row));
    final name = asList(data, 'name', (row) => Name.fromJson(row));
    final officialLanguages =
        asList(data, 'officialLanguages', (row) => row.toString());

    return Region(
      code: code,
      isoCode: isoCode,
      shortName: shortName,
      category: category,
      name: name,
      officialLanguages: officialLanguages,
    );
  }
}

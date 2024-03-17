import 'package:calendar_app/api/core.api.dart';
import 'package:calendar_app/api/name.api.dart';

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

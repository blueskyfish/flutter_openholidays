import 'package:calendar_app/api/core.api.dart';

class ShortName {
  final String code;
  final String shortName;

  ShortName({required this.code, required this.shortName});

  factory ShortName.fromJson(Map<String, dynamic> data) {
    final code = asString(data, 'code');
    final shortName = asString(data, 'shortName');

    return ShortName(
      code: code,
      shortName: shortName,
    );
  }
}

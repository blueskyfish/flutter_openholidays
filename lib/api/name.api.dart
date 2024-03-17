import 'package:calendar_app/api/core.api.dart';

class Name {
  final String text;
  final String language;

  Name({required this.text, required this.language});

  factory Name.fromJson(Map<String, dynamic> data) {
    final text = asString(data, 'text');
    final language = asString(data, 'language');
    return Name(text: text, language: language);
  }
}

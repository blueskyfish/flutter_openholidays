

import 'package:calendar_app/api/language.api.dart';

typedef SelectLanguage = void Function(LanguageItem language);

class StartState {
  late final String _language;
  final SelectLanguage selectLanguage;
  late final List<LanguageItem> _languages;
  StartState(List<LanguageItem> languages, String language, this.selectLanguage) {
    _language = language;
    _languages = languages;
  }

  int get length => _languages.length;

  List<LanguageItem> get languages => _languages;
  
  isSelected(LanguageItem language) => language.code == _language;
}
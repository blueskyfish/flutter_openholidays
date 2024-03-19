import 'package:calendar_app/api/country.api.dart';
import 'package:calendar_app/api/language.api.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class IconListItem {
  final String code;
  final String title;
  late final String assetName;
  Widget? _flag;

  IconListItem({required this.code, required this.title}) {
    assetName = 'assets/images/country/${code.toLowerCase()}.svg';
  }

  Widget get flag {
    _flag ??= _loadFlagWidget(assetName);
    return _flag!;
  }

  Widget _loadFlagWidget(String assetName) {
    try {
      return SvgPicture.asset(assetName);
    } catch (e) {
      return SvgPicture.asset('assets/images/country/xx.svg');
    }
  }

  factory IconListItem.fromCountry(Country country) {
    return IconListItem(
      code: country.isoCode.toLowerCase(),
      title: country.name[0].text,
    );
  }

  factory IconListItem.fromLanguage(Language language) {
    return IconListItem(
      code: language.isoCode.toLowerCase(),
      title: language.name[0].text,
    );
  }
}

typedef IconListSelect = Function(IconListItem item);

class IconListItemController {
  final IconListSelect onSelect;
  late String _code = '';
  late List<IconListItem> _items;

  IconListItemController(List<IconListItem> items, String code, this.onSelect) {
    _code = code;
    _items = items;
  }

  String get code => _code;
  int get length => _items.length;

  IconListItem operator [](int index) {
    if (index < 0 || index >= length) {
      throw Exception('Index "$index" out of range');
    }
    return _items[index];
  }

  bool isSelect(IconListItem item) {
    return _code == item.code;
  }

  void setSelect(IconListItem item) {
    _code = item.code;
    onSelect(item);
  }
}

class IconListTile extends StatelessWidget {
  final int index;
  final IconListItemController controller;

  const IconListTile({super.key, required this.index, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final item = controller[index];
    final isSelected = controller.isSelect(item);
    return ListTile(
      tileColor: isSelected ? theme.colorScheme.inversePrimary : null,
      leading: SizedBox(
        height: 48,
        width: 48,
        child: item.flag,
      ),
      title: Text(
        item.title,
        style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, fontSize: 20.0),
      ),
      onTap: () {
        controller.setSelect(item);
      },
    );
  }
}

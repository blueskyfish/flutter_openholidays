import 'package:calendar_app/api/holiday.api.dart';
import 'package:calendar_app/api/short-name.api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:svg_flutter/svg.dart';

class HolidayListItem {
  final String id;
  final String startDate;
  final String endDate;
  final String title;
  final String type;
  final String quality;
  final bool nationwide;
  final List<ShortName>? regions;
  final String? comment;

  HolidayListItem({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.title,
    required this.type,
    required this.quality,
    required this.nationwide,
    required this.regions,
    required this.comment,
  });

  factory HolidayListItem.from(Holiday holiday) {
    return HolidayListItem(
      id: holiday.id,
      startDate: holiday.startDate,
      endDate: holiday.endDate,
      title: holiday.name[0].text,
      type: holiday.type,
      quality: holiday.quality ?? 'Mandatory',
      nationwide: holiday.nationwide,
      regions: holiday.regions,
      comment: holiday.comment,
    );
  }
}

typedef HolidayListSelect = void Function(HolidayListItem item);

class HolidayListController {
  final HolidayListSelect onSelect;
  late String _id = '';
  late List<HolidayListItem> _items;

  Widget? _holiday;

  HolidayListController(List<HolidayListItem> items, String id, this.onSelect) {
    _id = id;
    _items = items;
  }

  String get id => _id;
  int get length => _items.length;

  HolidayListItem operator [](int index) {
     if (index < 0 || index >= length) {
      throw Exception('Index "$index" out of range');
    }
    return _items[index];
  }

  bool isSelect(HolidayListItem item) {
    return _id == item.id;
  }

  void setSelect(HolidayListItem item) {
    _id = item.id;
    onSelect(item);
  }

  Widget getIcon(double width, double height) {
    _holiday ??= Image.asset('assets/images/holiday.png');

    return SizedBox(
      width: width,
      height: height,
      child: _holiday!,
    );
  }
}

class HolidayListTile extends StatelessWidget {
  final int index;
  final HolidayListController controller;
  const HolidayListTile({ super.key, required this.index, required this.controller });

  @override
  Widget build(BuildContext context) {
    final holiday = controller[index];
    return ListTile(
      leading: controller.getIcon(48.0, 48.0),
      title: Text(holiday.title),
      subtitle: Text(holiday.startDate),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        controller.setSelect(holiday);
      },
    );
  }
}

import 'package:calendar_app/api/core.api.dart';
import 'package:calendar_app/api/name.api.dart';
import 'package:calendar_app/api/short-name.api.dart';

class Holiday {
  final String id;
  final String startDate;
  final String endDate;
  final String type;
  final List<Name> name;
  final bool nationwide;
  final List<ShortName>? regions;
  final String? comment;
  final String? qualitiy;

  Holiday({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.name,
    required this.nationwide,
    this.regions,
    this.comment,
    this.qualitiy,
  });

  factory Holiday.fromJson(Map<String, dynamic> data) {
    final id = asString(data, 'id');
    final startDate = asString(data, 'startDate');
    final endDate = asString(data, 'endDate');
    final type = asString(data, 'type');
    final name = asList(data, 'name', (row) => Name.fromJson(row));
    final nationwide = asBool(data, 'nationwide');
    final regions =
        opList(data, 'subdivisions', (row) => ShortName.fromJson(row));
    final comment = opString(data, 'comment');
    final qualitiy = opString(data, 'quality');

    return Holiday(
      id: id,
      startDate: startDate,
      endDate: endDate,
      type: type,
      name: name,
      nationwide: nationwide,
      regions: regions,
      comment: comment,
      qualitiy: qualitiy,
    );
  }
}

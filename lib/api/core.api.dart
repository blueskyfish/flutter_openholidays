/// Callback function to create the entity
typedef CreateEntity<T> = T Function(dynamic row);

String asString(Map<String, dynamic> data, String name) {
  var value = data[name];
  if (value is! String) {
    throw FormatException(
        'Invalid JSON: required "$name" field from type "String" in $data');
  }
  return value;
}

bool asBool(Map<String, dynamic> data, String name) {
  var value = data[name];
  if (value is! bool) {
    throw FormatException(
        'Invalid JSON: required "$name" from type "bool" in $data');
  }
  return value;
}

int asInt(Map<String, dynamic> data, String name) {
  var value = data[name];
  if (value is! int) {
    throw FormatException(
        'Invalid JSON: required "$name" from type "int" in $data');
  }
  return value;
}

/// Returns the list of entity from the given json map with the name of attribute
List<T> asList<T>(
  Map<String, dynamic> data,
  String name,
  CreateEntity<T> func,
) {
  var value = data[name];
  if (value is! List) {
    throw FormatException(
        'Invalid JSON: required "$name" from type "List" in $data');
  }
  return value.map((row) => func(row)).toList();
}

List<T>? opList<T>(
    Map<String, dynamic> data, String name, CreateEntity<T> func) {
  var value = data[name];
  if (value is List) {
    return value.map((row) => func(row)).toList();
  }
  return null;
}

List<T> fromArray<T>(dynamic data, CreateEntity<T> func) {
  if (data is! List) {
    throw FormatException('Invalid JSON: required as List from $data');
  }
  return data.map((row) => func(row)).toList();
}

String? opString(Map<String, dynamic> data, String name) {
  var value = data[name];
  if (value is String) {
    return value;
  }
  return null;
}

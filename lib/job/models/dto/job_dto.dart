import 'dart:convert';

class JobDto {
  final int id;
  String? name;
  String? type;
  String? dataMap;
  String? executeAfter;

  JobDto(this.id);

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};

    map['name'] = name;
    map['type'] = type;
    Map<String, dynamic>? data;
    if (dataMap != null) {
      try {
        data = jsonDecode(dataMap!);
      } catch (_) {}
    }
    map['dataMap'] = data;
    map['executeAfter'] = executeAfter;

    return map;
  }
}

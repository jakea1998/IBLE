import 'package:json_annotation/json_annotation.dart';

enum DefaultStatuses {
  initial,
  loading,
  loaded,
  error;

  String toJson() => name;
  static DefaultStatuses fromJson(String json) => values.byName(json);
}

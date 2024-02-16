// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'symptom.g.dart';

@JsonSerializable()
class Symptom {
  final String id;
  final String name;
  final String description;
  final List<String> treatments;
  final List<String> preventions;
  final String duration;
  final String thumbnail_url;

  const Symptom(
    this.id,
    this.name,
    this.description,
    this.treatments,
    this.preventions,
    this.duration,
    this.thumbnail_url,
  );

  factory Symptom.fromJson(Map<String, dynamic> json) =>
      _$SymptomFromJson(json);

  Map<String, dynamic> toJson() => _$SymptomToJson(this);
}

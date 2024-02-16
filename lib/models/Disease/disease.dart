// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';

part 'disease.g.dart';

@JsonSerializable()
class Disease {
  final String id;
  final String name;
  final String description;
  final List<String> symptoms;
  final List<String> treatments;
  final List<String> preventions;
  final String thumbnail_url;

  const Disease(
    this.id,
    this.name,
    this.description,
    this.symptoms,
    this.treatments,
    this.preventions,
    this.thumbnail_url,
  );

  factory Disease.fromJson(Map<String, dynamic> json) =>
      _$DiseaseFromJson(json);

  Map<String, dynamic> toJson() => _$DiseaseToJson(this);
}

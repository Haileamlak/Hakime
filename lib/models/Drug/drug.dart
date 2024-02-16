// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'drug.g.dart';

@JsonSerializable()
class Drug {
  final String id;
  final String name;
  final String description;
  final String category;
  final String manufacturer;
  final String dosage_form;
  final String usage;
  final List<String> side_effects;
  final String thumbnail_url;

  const Drug(
    this.id,
    this.name,
    this.description,
    this.category,
    this.manufacturer,
    this.dosage_form,
    this.usage,
    this.side_effects,
    this.thumbnail_url,
  );

  factory Drug.fromJson(Map<String, dynamic> json) => _$DrugFromJson(json);
  
  Map<String, dynamic> toJson() => _$DrugToJson(this);
  
}

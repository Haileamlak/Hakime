// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drug.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Drug _$DrugFromJson(Map<String, dynamic> json) => Drug(
      json['id'] as String,
      json['name'] as String,
      json['description'] as String,
      json['category'] as String,
      json['manufacturer'] as String,
      json['dosageForm'] as String,
      json['usage'] as String,
      (json['sideEffects'] as List<dynamic>).map((e) => e as String).toList(),
      json['thumbnailUrl'] as String,
    );

Map<String, dynamic> _$DrugToJson(Drug instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'manufacturer': instance.manufacturer,
      'dosageForm': instance.dosage_form,
      'usage': instance.usage,
      'sideEffects': instance.side_effects,
      'thumbnailUrl': instance.thumbnail_url,
    };

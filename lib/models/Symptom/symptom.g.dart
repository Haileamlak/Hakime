// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symptom.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Symptom _$SymptomFromJson(Map<String, dynamic> json) => Symptom(
      json['id'] as String,
      json['name'] as String,
      json['description'] as String,
      (json['treatment'] as List<dynamic>).map((e) => e as String).toList(),
      (json['prevention'] as List<dynamic>).map((e) => e as String).toList(),
      json['duration'] as String,
      json['thumbnailUrl'] as String,
    );

Map<String, dynamic> _$SymptomToJson(Symptom instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'treatment': instance.treatments,
      'prevention': instance.preventions,
      'duration': instance.duration,
      'thumbnailUrl': instance.thumbnail_url,
    };

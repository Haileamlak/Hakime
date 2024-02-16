// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disease.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Disease _$DiseaseFromJson(Map<String, dynamic> json) => Disease(
      json['id'] as String,
      json['name'] as String,
      json['description'] as String,
      (json['symptoms'] as List<dynamic>).map((e) => e as String).toList(),
      (json['treatments'] as List<dynamic>).map((e) => e as String).toList(),
      (json['prevention'] as List<dynamic>).map((e) => e as String).toList(),
      json['thumbnailUrl'] as String,
    );

Map<String, dynamic> _$DiseaseToJson(Disease instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'symptoms': instance.symptoms,
      'treatments': instance.treatments,
      'prevention': instance.preventions,
      'thumbnailUrl': instance.thumbnail_url,
    };

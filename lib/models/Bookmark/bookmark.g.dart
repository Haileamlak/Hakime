// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bookmark _$BookmarkFromJson(Map<String, dynamic> json) => Bookmark(
      id: json['id'] as String,
      diseases: (json['diseases'] as List<dynamic>)
          .map((e) => Disease.fromJson(e as Map<String, dynamic>))
          .toList(),
      drugs: (json['drugs'] as List<dynamic>)
          .map((e) => Drug.fromJson(e as Map<String, dynamic>))
          .toList(),
      userId: json['userId'] as String,
      symptoms: (json['symptoms'] as List<dynamic>)
          .map((e) => Symptom.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookmarkToJson(Bookmark instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'diseases': instance.diseases,
      'drugs': instance.drugs,
      'symptoms': instance.symptoms,
    };

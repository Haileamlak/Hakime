// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';
import 'package:tenawo_beslkwo/models/Disease/disease.dart';
import 'package:tenawo_beslkwo/models/Drug/drug.dart';
import 'package:tenawo_beslkwo/models/Symptom/symptom.dart';

part 'bookmark.g.dart';

@JsonSerializable()
class Bookmark {
  String id;
  String userId;
  List<Disease> diseases;
  List<Drug> drugs;
  List<Symptom> symptoms;

  Bookmark({
    required this.id,
    required this.diseases,
    required this.drugs,
    required this.userId,
    required this.symptoms,
  });
  
  factory Bookmark.fromJson(Map<String, dynamic> json) =>
      _$BookmarkFromJson(json);

  Map<String, dynamic> toJson() => _$BookmarkToJson(this);
}


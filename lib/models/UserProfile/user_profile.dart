// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';
import 'package:tenawo_beslkwo/models/Bookmark/bookmark.dart';
import 'package:tenawo_beslkwo/models/User/user.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile {
  final User user;
  final Bookmark bookmark;

  const UserProfile({required this.user, required this.bookmark});

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}

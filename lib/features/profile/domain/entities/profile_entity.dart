// ignore_for_file: public_member_api_docs, sort_constructors_first
class Profile {
  final String name;
  final String description;
  final List<dynamic> likedIds;
  final List<dynamic> matchedIds;
  final List<dynamic> photos;
  final String sex;
  final Map<String, dynamic> tags;
  Profile({
    required this.name,
    required this.description,
    required this.photos,
    required this.likedIds,
    required this.matchedIds,
    required this.sex,
    required this.tags,
  });

  Profile copyWith({
    String? name,
    String? description,
    List<dynamic>? likedIds,
    List<dynamic>? matchedIds,
    List<dynamic>? photos,
    String? sex,
    Map<String, bool>? tags,
  }) {
    return Profile(
      name: name ?? this.name,
      description: description ?? this.description,
      likedIds: likedIds ?? this.likedIds,
      matchedIds: matchedIds ?? this.matchedIds,
      photos: photos ?? this.photos,
      sex: sex ?? this.sex,
      tags: tags ?? this.tags,
    );
  }
}

class BusinessCardData {
  final String name;
  final String birthdate;
  final String email;
  final String phone;
  final String? introduction;
  final Map<String, dynamic>? externalLink;
  final String nickname;
  final String followers;
  final String following;
  final String totalStars;
  final String totalCommits;
  final String avatarUrl;
  final Map<String, dynamic>? languages;
  final String skillProficiency;

  BusinessCardData({
    required this.name,
    required this.birthdate,
    required this.email,
    required this.phone,
    this.introduction,
    required this.externalLink,
    required this.nickname,
    required this.followers,
    required this.following,
    required this.totalStars,
    required this.totalCommits,
    required this.avatarUrl,
    required this.languages,
    required this.skillProficiency,
  });
}
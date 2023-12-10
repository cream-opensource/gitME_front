import 'package:flutter/foundation.dart';

class UserData with ChangeNotifier {
  String? accessToken;
  int? userIdx;
  int? kakaoId;
  String? name;
  String? birthDate;
  String? email;
  String? phone;
  String? introduce;
  Map<String, dynamic>? externalLink;
  String? nickname;
  int? followers;
  int? following;
  int? totalStars;
  int? totalCommits;
  String? avatarUrl;
  Map<String, int>? languages;

  void setAccessToken(String token) {
    accessToken = token;
    notifyListeners();
  }

  void setKId(int kId) {
    kakaoId = kId;
    notifyListeners();
  }
  void setIdx(int userId) {
    userIdx = userId;
    notifyListeners();
  }

  void setJoinData(String name, String phone, String email, String birthdate, String introduce) {
    this.name = name;
    this.phone = phone;
    this.email = email;
    this.birthDate = birthdate;
    this.introduce = introduce;

    notifyListeners();
  }

  void setExternalLinkData(List<Map<String, String>> externalLinkData) {
    externalLink = Map.fromIterable(
      externalLinkData,
      key: (link) => link['webpage'],
      value: (link) => link['url'],
    );
    notifyListeners();
  }

  void setLanguageData(Map<String, int> languageData) {
    languages = languageData;
    notifyListeners();
  }

  void setUserData(Map<String, dynamic> userData) {
    userIdx = userData['userIdx'];
    name = userData['name'];
    birthDate = userData['birthDate'];
    email = userData['email'];
    phone = userData['phone'];
    introduce = userData['introduce'];
    externalLink = Map<String, String>.from(userData['externalLink']);
    nickname = userData['nickname'];
    followers = userData['followers'];
    following = userData['following'];
    totalStars = userData['totalStars'];
    totalCommits = userData['totalCommits'];
    avatarUrl = userData['avatarUrl'];
    languages = Map<String, int>.from(userData['languages']);

    notifyListeners();
  }

  Map<String, dynamic> getUserData() {
    return {
      'userIdx': userIdx,
      'name': name,
      'birthDate': birthDate,
      'email': email,
      'phone': phone,
      'introduce': introduce,
      'externalLink': externalLink,
      'nickname': nickname,
      'followers': followers,
      'following': following,
      'totalStars': totalStars,
      'totalCommits': totalCommits,
      'avatarUrl': avatarUrl,
      'languages': languages,
    };
  }
}

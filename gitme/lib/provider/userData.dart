import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserData with ChangeNotifier {
  String? accessToken;
  int? userIdx;
  int? kakaoId;
  String? name;
  String? birthDate;
  String? email;
  String? phone;
  String? introduction;
  Map<String, dynamic>? externalLink;
  String? nickname;
  int? followers;
  int? following;
  int? totalStars;
  int? totalCommits;
  String? avatarUrl;
  Map<String, int>? languages;
  String? skillProficiency;


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

  void setJoinData(String name, String phone, String email, String birthdate, String introduction) {
    this.name = name;
    this.phone = phone;
    this.email = email;
    this.birthDate = birthdate;
    this.introduction = introduction;

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
    if (userData['name'] != null) {
      name = utf8.decode(userData['name'].toString().codeUnits);
    }
    birthDate = userData['birthDate'];
    email = userData['email'];
    phone = userData['phone'];
    if (userData['introduce'] != null) {
      introduction = utf8.decode(userData['introduction'].toString().codeUnits);
    }
    externalLink = Map<String, String>.from(userData['externalLink']);
    nickname = userData['nickname'];
    followers = userData['followers'];
    following = userData['following'];
    totalStars = userData['totalStars'];
    totalCommits = userData['totalCommits'];
    avatarUrl = userData['avatarUrl'];
    languages = Map<String, int>.from(userData['languages']);
    skillProficiency = userData['skillProficiency'];

    notifyListeners();
  }

  Map<String, dynamic> getUserData() {
    return {
      'userIdx': userIdx,
      'name': name,
      'birthDate': birthDate,
      'email': email,
      'phone': phone,
      'introduction': introduction,
      'externalLink': externalLink,
      'nickname': nickname,
      'followers': followers,
      'following': following,
      'totalStars': totalStars,
      'totalCommits': totalCommits,
      'avatarUrl': avatarUrl,
      'languages': languages,
      'skillProficiency' : skillProficiency,
    };
  }
}

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserData with ChangeNotifier {

  List<Map<String, String>> externalLinks = [];

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
  Map<String, String>? skill;
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

  void setJoinData(String name, String phone, String email, String birthdate, String introduce) {
    this.name = name;
    this.phone = phone;
    this.email = email;
    this.birthDate = birthdate;
    this.introduction = introduce;

    notifyListeners();
  }

  void setExternalLinkData(List<Map<String, String>> externalLinkData) {
    externalLinks = List.from(externalLinkData);
    notifyListeners();
  }

  void updateExternalLink(String newKey, String newValue, int index) {
    if (index >= 0 && index < externalLinks.length) {
      externalLinks[index] = {newKey: newValue};
      notifyListeners();
    }
  }

  void updateSkill(String key, String value) {
    if (skill == null) {
      skill = {};
    }

    // key가 이미 존재하는 경우 해당 값 업데이트, 아닌 경우 새로운 항목 추가
    if (skill!.containsKey(key)) {
      skill!.remove(key); // 기존 key 제거
    }

    skill![value] = key; // 새로운 key-value 쌍 추가

    notifyListeners();
  }

  void setLanguageData(Map<String, int> languageData) {
    languages = languageData;
    notifyListeners();
  }

  void updateIntroduction(String newIntroduction) {
    introduction = newIntroduction;
    notifyListeners();
  }

  void updateEmail(String newEmail) {
    email = newEmail;
    notifyListeners();
  }

  void updateBirthDate(String newBirthDate) {
    birthDate = newBirthDate;
    notifyListeners();
  }

  void updatePhone(String newPhone) {
    phone = newPhone;
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
      introduction = utf8.decode(userData['introduce'].toString().codeUnits);
    }
    externalLink = Map<String, String>.from(userData['externalLink']);
    skill = Map<String, String>.from(userData['externalLink']);
    nickname = userData['nickname'];
    followers = userData['followers'];
    following = userData['following'];
    totalStars = userData['totalStars'];
    totalCommits = userData['totalCommits'];
    avatarUrl = userData['avatarUrl'];
    languages = Map<String, int>.from(userData['languages']);
    skill =  Map<String, String>.from(userData['skill']);
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
      'introduce': introduction,
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
import 'package:flutter/foundation.dart';

class UserData with ChangeNotifier {
  String? accessToken;
  int? id;
  int? userIdx;
  String? kakaoId;
  String? name;
  String? birthDate;
  String? email;
  String? phone;
  Map<String, String>? externalLink;
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

  void setId(int Id) {
    id = Id;
    notifyListeners();
  }
  void setIdx(int userId) {
    userIdx = userId;
    notifyListeners();
  }

  void setUserData(Map<String, dynamic> userData) {
    userIdx = userData['userIdx'];
    kakaoId = userData['kakaoId'];
    name = userData['name'];
    birthDate = userData['birthDate'];
    email = userData['email'];
    phone = userData['phone'];
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
}

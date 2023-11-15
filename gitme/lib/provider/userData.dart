import 'package:flutter/foundation.dart';

class UserData with ChangeNotifier {
  String? accessToken;

  void setAccessToken(String token) {
    accessToken = token;
    notifyListeners(); // 변경을 구독하는 위젯에 알림
  }
}
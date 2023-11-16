import 'package:flutter/foundation.dart';

class UserData with ChangeNotifier {
  String? accessToken;
  int? id;
  void setAccessToken(String token) {
    accessToken = token;
    notifyListeners();
  }
  void setId(int Id) {
    id = Id;
    notifyListeners();
  }
}
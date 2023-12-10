import 'dart:convert';

import 'package:gitme/screens/main_screen.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../provider/userData.dart';
import '../screens/join_screen.dart';

class ServerApiService {
  static Future<int?> getUserIdFromKakaoId(int kakaoId) async {
    try {
      final response = await http.get(
        Uri.parse('https://port-0-gitme-server-1igmo82clotquec0.sel5.cloudtype.app/sign/$kakaoId'),
      );

      print('Server Response (sign): ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['userIdx'];
      } else if (response.statusCode == 404) {
        throw JoinScreenNavigationError();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error in getUserIdFromKakaoId: $e');
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> getCardInfo(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('https://port-0-gitme-server-1igmo82clotquec0.sel5.cloudtype.app/cardInfo/$userId'),
      );

      print('Server Response (cardInfo): ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error in getCardInfo: $e');
      rethrow;
    }
  }
}

class JoinScreenNavigationError implements Exception {
  const JoinScreenNavigationError();
}

class DataHandler {
  Future<void> fetchDataFromServer(BuildContext context) async {
    try {
      final userData = Provider.of<UserData>(context, listen: false);
      final kakaoId = userData.kakaoId;

      if (kakaoId != null) {
        final userIdx = await ServerApiService.getUserIdFromKakaoId(kakaoId);

        if (userIdx != null) {
          final cardInfoData = await ServerApiService.getCardInfo(userIdx);

          userData.setUserData(cardInfoData);

          print('apiService 성공: $cardInfoData');

        } else {
          print('Failed to get userIdx from KakaoId');
        }
      } else {
        print('Failed to get kakaoId from provider');
      }
    } catch (e) {
      if (e is JoinScreenNavigationError) {
        Navigator.of(context).pushReplacementNamed(JoinScreen.route);
      } else {
        print('apiService 에러 : $e');
      }
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../provider/userData.dart';

class YourApi {
  static Future<Map<String, dynamic>> fetchDataFromServer(int userId) async {
    final response = await http.get(
      Uri.parse('https://port-0-gitme-server-1igmo82clotquec0.sel5.cloudtype.app/cardInfo/10'),
    );

    print('Server Response: ${response.statusCode} - ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      print(userId);
      throw Exception('Failed to load data');
    }
  }
}

class ServerCommunication {
  Future<void> fetchDataFromServer(BuildContext context) async {
    UserData userData = Provider.of<UserData>(context, listen: false);
    int? userId = userData.id;

    if (userId != null) {
      try {
        final data = await YourApi.fetchDataFromServer(userId);
        // 받아온 데이터를 UserData 프로바이더에 저장
        userData.setUserData(data);
        // 필요한 데이터들을 userData에 저장하는 로직을 추가
        print(' apiService 성공: $data');

      } catch (e) {
        print('apiService 에러 : $e');
      }
    }
  }
}

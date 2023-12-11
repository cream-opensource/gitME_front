import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gitme/widgets/card1.dart';
import 'package:gitme/widgets/card2.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../provider/userData.dart';
import '../service/apiService.dart';
import '../service/business_card_data.dart';
import '../widgets/card3.dart';
import '../widgets/card4.dart';
import 'main_screen.dart';

class ShareScreen extends StatefulWidget {
  static const route = 'share-screen';
  final int userIdx;
  final int templateIdx;

  ShareScreen({super.key, required this.userIdx, required this.templateIdx});

  @override
  _SharePageState createState() => _SharePageState();
}

class _SharePageState extends State<ShareScreen> {
  BusinessCardData? cardData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCardData();
  }

  Future<void> _loadCardData() async {
    try {
      final cardInfoData = await ServerApiService.getCardInfo(widget.userIdx);
      setState(() {
        cardData = BusinessCardData(
          name: cardInfoData['name'] != null ? utf8.decode(cardInfoData['name'].toString().codeUnits) : "",
          birthdate: cardInfoData['birthDate'] ?? "",
          email: cardInfoData['email'] ?? "",
          phone: cardInfoData['phone'] ?? "",
          introduce: cardInfoData['introduce'] != null ? utf8.decode(cardInfoData['introduce'].toString().codeUnits) : "",
          externalLink: Map<String, String>.from(cardInfoData['externalLink'] ?? {}),
          nickname: cardInfoData['nickname'] ?? "",
          followers: cardInfoData['followers']?.toString() ?? "",
          following: cardInfoData['following']?.toString() ?? "",
          totalStars: cardInfoData['totalStars']?.toString() ?? "",
          totalCommits: cardInfoData['totalCommits']?.toString() ?? "",
          avatarUrl: cardInfoData['avatarUrl'] ?? "",
          languages: Map<String, int>.from(cardInfoData['languages'] ?? {}),
        );
      });
    } catch (e) {
      print('Error loading card data: $e');
      _showSnackBar('명함 데이터 조회 중 오류가 발생했습니다.');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Widget _buildBusinessCard(int templateIdx, BusinessCardData cardData) {
    switch (templateIdx + 1) {
      case 1:
        return BusinessCard1(cardData);
      case 2:
        return BusinessCard2(cardData);
      case 3:
        return BusinessCard3(cardData);
      case 4:
        return BusinessCard4(cardData);
      default:
        throw Exception("Invalid card index");
    }
  }

  Widget _buildBottomButtons() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButton('저장', _saveCardData),
            _buildButton('나가기', () => Navigator.of(context).pushReplacementNamed(MainScreen.route)),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF56CC94),
        onPrimary: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 18),
        textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Future<void> _saveCardData() async {
    try {
      final userData = Provider.of<UserData>(context, listen: false);
      final Map<String, dynamic> data = {
        'userIdx': userData.userIdx,
        'targetUserIdx': widget.userIdx,
        'template': widget.templateIdx,
      };
      final String jsonData = jsonEncode(data);

      final response = await http.post(
        Uri.parse('https://port-0-gitme-server-1igmo82clotquec0.sel5.cloudtype.app/cardWallet'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonData,
      );

      if (response.statusCode == 200) {
        _showSnackBar('카드 데이터가 성공적으로 저장되었습니다.');
      } else {
        _showSnackBar('카드 데이터 저장에 실패했습니다.');
      }
    } catch (e) {
      print('Error loading card data: $e');
      _showSnackBar('데이터 저장 중 오류가 발생했습니다.');
    } finally {
      Navigator.of(context).pushReplacementNamed(MainScreen.route);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: cardData != null ? _buildBusinessCard(widget.templateIdx, cardData!) : CircularProgressIndicator(),
              ),
            ),
            _buildBottomButtons(),
          ],
        ),
      ),
    );
  }
}

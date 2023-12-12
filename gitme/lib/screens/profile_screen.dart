import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gitme/widgets/main_drawer.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../provider/userData.dart';
import 'main_screen.dart';

final storage = FlutterSecureStorage();

class ProfileScreen extends StatefulWidget {
  static const route = 'profile-screen';

  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isEditing = false; // 추가: 편집 모드 여부를 나타내는 변수

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final userData = Provider.of<UserData>(context, listen: false);
    int externalLinkCount = userData.externalLink?.length ?? 0;
    print("편집모드: " + (isEditing ? "on" : "off"));
    print("external: $externalLinkCount");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF4F4F4),
        leading: IconButton(
          icon: Image.asset(
            'assets/back_button.png',
            width: 20,
            height: 20,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(MainScreen.route);
          },
        ),
        title: Text(
          '마이페이지',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = MediaQuery.of(context).size.width;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.06),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenWidth * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Consumer<UserData>(
                          builder: (context, userData, child) {
                            return userData.avatarUrl != null
                                ? Container(
                                    width: screenWidth * 0.4,
                                    height: screenWidth * 0.4,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.black12,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: ClipOval(
                                      child: Image.network(
                                        userData.avatarUrl!,
                                        width: screenWidth * 0.4,
                                        height: screenWidth * 0.4,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Container();
                          },
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Consumer<UserData>(
                                builder: (context, userData, child) {
                                  return Text(
                                    userData.name ?? '',
                                    style: TextStyle(
                                        fontSize: screenWidth * 0.06,
                                        fontWeight: FontWeight.w800),
                                  );
                                },
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/git_icon.png',
                                    width: screenWidth * 0.035,
                                    height: screenWidth * 0.035,
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.012,
                                  ),
                                  Consumer<UserData>(
                                    builder: (context, userData, child) {
                                      return Text(
                                        userData.nickname ?? '',
                                        style: TextStyle(
                                            fontSize: screenWidth * 0.035,
                                            fontWeight: FontWeight.w500),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  // '내 정보 수정하기' 버튼을 누를 때 편집 모드 토글
                                  setState(() {
                                    isEditing = !isEditing;

                                    // 수정 완료 버튼을 눌렀을 때 API 호출
                                    if (!isEditing) {
                                      _saveChanges();
                                    }
                                  });
                                },
                                child: Text(
                                  isEditing ? '수정 완료' : '내 정보 수정하기',
                                  // 수정 완료 또는 내 정보 수정하기로 텍스트 변경
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.03,
                                    color: Colors.white,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Color(isEditing ? 0xFF567FCC : 0xFF56CC94),
                                  padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  fixedSize: Size(screenWidth * 0.3, screenWidth * 0.1), // Set the fixed size
                                ),
                              ),
                            ]),
                      ],
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.01),
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      buildSkillWidget(isEditing, userData.skill, Icon(Icons.settings), Provider.of<UserData>(context, listen: false).updateSkill),
                      buildUserWidget(isEditing, userData.introduction, Icon(Icons.person), Provider.of<UserData>(context, listen: false).updateIntroduction),
                      buildUserWidget(isEditing, userData.email, Icon(Icons.email), Provider.of<UserData>(context, listen: false).updateEmail),
                      buildUserWidget(isEditing, userData.birthDate, Icon(Icons.cake_outlined), Provider.of<UserData>(context, listen: false).updateBirthDate),
                      buildUserWidget(isEditing, userData.phone, Icon(Icons.call), Provider.of<UserData>(context, listen: false).updatePhone),
                    ],
                  ),

                ],
              ),
            ),
          );
        },
      ),
      drawer: MainDrawer(),
    );
  }

  Widget buildExternalLinkWidget(
      bool isEditing,
      Map<String, String>? externalLinkData,
      int index,
      Icon userIcon,
      void Function(String, String) updateFunction,
      ) {
    List<MapEntry<String, String>> entryList = externalLinkData?.entries.toList() ?? [];

    if (index >= 0 && index < entryList.length) {
      MapEntry<String, String> entry = entryList[index];
      String key = entry.key;
      String value = entry.value;

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (isEditing)
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                        decoration: InputDecoration(
                          icon: userIcon,
                        ),
                        initialValue: key,
                        onChanged: (newKey) {
                          updateFunction(newKey, value);
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                        decoration: InputDecoration(),
                        initialValue: value,
                        onChanged: (newValue) {
                          updateFunction(key, newValue);
                        },
                      ),
                    ),
                  ),
                ],
              )
            else
              ListTile(
                leading: userIcon,
                title: Text(
                  key,
                  style: TextStyle(fontSize: 16),
                ),
                subtitle: Text(
                  value,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            Divider(),
          ],
        ),
      );
    } else {
      // Handle index out of bounds
      return Container(); // or any other widget/message indicating the issue
    }
  }


  Widget buildSkillWidget(
      bool isEditing,
      Map<String, String>? skillData,
      Icon userIcon,
      void Function(String, String) updateFunction,
      ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          isEditing
              ? Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    icon: userIcon,
                  ),
                  initialValue: skillData?.keys.first ?? '',
                  onChanged: (value) {
                    updateFunction(skillData?.keys.first ?? '', value);
                  },
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(),
                  initialValue: skillData?.values.first ?? '',
                  onChanged: (value) {
                    updateFunction(skillData?.keys.first ?? '', value);
                  },
                ),
              ),
            ],
          )
              : ListTile(
            leading: userIcon,
            title: Text(
              skillData?.keys.first ?? '',
              style: TextStyle(fontSize: 16),
            ),
            subtitle: Text(
              skillData?.values.first ?? '',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  

  Widget buildUserWidget(
      bool isEditing,
      String? userData,
      Icon userIcon,
      void Function(String) updateFunction, // 추가: 프로바이더를 업데이트하는 함수
      ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          isEditing
              ? TextFormField(
            decoration: InputDecoration(
              icon: userIcon,
            ),
            initialValue: userData ?? '',
            onChanged: (value) {
              // 텍스트가 변경될 때 사용자 데이터 업데이트
              updateFunction(value); // 프로바이더 업데이트 함수 호출
            },
          )
              : ListTile(
            leading: userIcon,
            title: Text(userData ?? ''),
          ),
          Divider(), // TextFormField 또는 ListTile 아래에 Divider 추가
        ],
      ),
    );
  }

  Future<void> _logout() async {
    await storage.delete(key: 'login_token');
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => MyApp(),
    ));
  }

  void _saveChanges() async {
    try {
      final userData = Provider.of<UserData>(context, listen: false);
      final apiUrl = 'https://port-0-gitme-server-1igmo82clotquec0.sel5.cloudtype.app/userData';

      final requestBody = {
        'userIdx': userData.userIdx,
        'kakaoId': userData.kakaoId,
        'name': userData.name,
        'birthDate': userData.birthDate,
        'email': userData.email,
        'phone': userData.phone,
        'introduce': userData.introduction,
        'externalLink': userData.externalLink,
        'skill': userData.skill,
        'skillProficiency' : userData.skillProficiency

      };

      // 바디 데이터 출력
      print('Request Body: $requestBody');

      final response = await http.put(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print('Server response: ${response.body}');
        final decodedData = jsonDecode(response.body);
        print('Decoded data: $decodedData');
      } else {
        print('Failed to update user data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while updating user data: $e');
    }
  }
}

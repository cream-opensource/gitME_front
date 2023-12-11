import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gitme/screens/externallink_screen.dart';
import 'package:gitme/screens/loading_screen.dart';
import 'package:gitme/screens/main_screen.dart';
import 'package:gitme/widgets/github_button.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../provider/userData.dart';

class AfterLanguageScreen extends StatefulWidget {
  static final route = 'after-language-screen';

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<AfterLanguageScreen> {
  final formKey = GlobalKey<FormState>();
  bool isLinked = false;

  String selectedLanguage = 'Java';
  List<String> languageItemList = [
    'Java',
    'JavaScript',
    'Python',
    'Swift',
    'Dart',
    'C#',
    'PHP',
    'Ruby',
  ];
  String selectedFrameLib = ''; // 추가된 변수
  List<String> frameLibItemList = [
    'Spring',
    'Hibernate',
    'JavaFX',
    'Struts',
    'MyBatis',
    'React',
    'Angular',
    'Vue.js',
    'Node.js',
    'Express',
    'Next.js',
    'Django', 'Flask', 'Pyramid', 'FastAPI', 'CherryPy',
    'UIKit', 'SwiftUI', 'Combine', 'RxSwift', '기타',
    'Flutter', 'Aqueduct', 'Get', 'Riverpod',
    '.NET Core', 'ASP.NET', 'Unity', 'WPF',
    'Laravel', 'Symfony', 'CodeIgniter', 'Yii',
    'Ruby on Rails', 'Sinatra', 'Hanami',
  ];

  List<String> achievementList = [
    'high', 'middle', 'low',
  ];
  String achievementDropdownValue = 'high';


  @override
  void initState() {
    super.initState();
    // languageItemList 초기화
    languageItemList = ['Java', 'JavaScript', 'Python', 'Swift', 'Dart'];
    // FrameLibItemList 초기화
    frameLibItemList = [];
    // 초기값 설정
    selectedLanguage = 'Java';
    updateFrameLibDropdownItems(selectedLanguage);
  }

  void _onConfirmButtonPressed() {
    print('Selected Language: $selectedLanguage');
    print('Selected Frame/Library: $selectedFrameLib');
    print('Selected Achievement: $achievementDropdownValue');


    sendUserDataToServer(selectedLanguage, selectedFrameLib, achievementDropdownValue);
  }

  Future<void> sendUserDataToServer(String language, String framework, String achievement) async {
    UserData userData = Provider.of<UserData>(context, listen: false);
    String? accessToken = userData.accessToken;
    String? kakaoId = userData.kakaoId?.toString();
    String? name = userData.name;
    String? phone = userData.phone;
    String? email = userData.email;
    String? birthdate = userData.birthDate;
    String? introduce = userData.introduce;


    Map<String, dynamic>? externalLink = userData.externalLink;

    Map<String, dynamic> convertedExternalLink = {};

    if (externalLink != null) {
      externalLink.forEach((key, value) {
        convertedExternalLink[key] = value;
      });
    }

    final Map<String, dynamic> data = {
      'kakaoId' : kakaoId ?? '',
      'name': name ?? '',
      'phone': phone ?? '',
      'email': email ?? '',
      'birthDate': birthdate ?? '',
      'introduction' : introduce ?? '',
      'gitAccessToken': accessToken ?? '',
      "externalLink": convertedExternalLink,
      'skill': { language : framework },
      'skillProficiency': achievement,
    };

    final String jsonData = jsonEncode(data);

    final response = await http.post(
      Uri.parse('https://port-0-gitme-server-1igmo82clotquec0.sel5.cloudtype.app/signUp'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonData,
    );

    if (response.statusCode == 201) {
      Navigator.pushReplacementNamed(
        context,
        LoadingScreen.route,
      );
    } else {
      print('요청 실패: ${response.reasonPhrase}');
    }

    print('보낼 데이터 확인: $jsonData');
  }

  @override
  Widget build(BuildContext context) {
    String? userName = Provider.of<UserData>(context).name;
    Map<String, int>? languages = Provider.of<UserData>(context).languages;
    print("이름: $userName");
    print("언어: $languages");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/back_button.png',
            width: 20,
            height: 20,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(ExternalLinkScreen.route);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(50, 5, 50, 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Final",
                      style: TextStyle(
                        fontSize: 36,
                        color: Color(0xFF56CC94),
                        fontFamily: 'DarkerGrotesque',
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.8,
                      ),
                    ),
                  ],
                ),
                Text(
                  "3 / 3",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF56CC94),
                    fontFamily: 'DarkerGrotesque',
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.8,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            GitHubButton(isButtonEnabled: false),
            SizedBox(height: 20),
            Center(
              child: Text(
                "$userName 님의 github 내 사용 언어",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF8D919F),
                  fontFamily: 'DarkerGrotesque',
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.8,
                ),
              ),
            ),
            SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 5.0,
              runSpacing: 10.0,
              children: languages != null
                  ? languages.keys.map((languageName) {
                int languageValue = languages[languageName] ?? 0;
                return IntrinsicWidth(
                  child: _buildRoundedText("$languageName: $languageValue"),
                );
              }).toList()
                  : [],
            ),
            SizedBox(height: 13),
            Divider(),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  buildDropdownInput(
                      "주사용 언어", languageItemList, selectedLanguage,
                          (String newValue) {
                        setState(() {
                          selectedLanguage = newValue;
                          updateFrameLibDropdownItems(selectedLanguage);
                        });
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  buildDropdownInput("주사용 프레임워크 & 라이브러리", frameLibItemList,
                      selectedFrameLib, (String newValue) {
                        setState(() {
                          selectedFrameLib = newValue;
                        });
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  buildDropdownInput(
                    "성취도",
                    achievementList,
                    achievementDropdownValue,
                        (String newValue) {
                      setState(() {
                        achievementDropdownValue = newValue;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: ElevatedButton(
                      onPressed: _onConfirmButtonPressed,
                      child: Text('확인'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF56CC94),
                        onPrimary: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 18),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoundedText(String text) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Color(0xFF56CC94)),
        color: Color(0xFF56CC94),
      ),
      padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
      child: Center(
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: 15)),
      ),
    );
  }

  Widget buildDropdownInput(
      String key, List<String> list, String value, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "* " + key + "  ",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF8D919F),
            fontFamily: 'DarkerGrotesque',
            fontWeight: FontWeight.w800,
            letterSpacing: -0.8,
          ),
        ),
        SizedBox(height: 10),
        Container(
          child: DropdownButton<String>(
            value: value,
            menuMaxHeight: 300,
            items: list.map((String itemText) {
              return DropdownMenuItem<String>(
                value: itemText,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Text(
                    itemText,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              onChanged(newValue ?? '');
            },
            icon: Icon(Icons.arrow_drop_down, color: Colors.black),
            iconSize: 24,
            isExpanded: true,
            elevation: 16,
            style: TextStyle(color: Colors.black),
            underline: Container(),
          ),
        ),
      ],
    );
  }

  void updateFrameLibDropdownItems(String selectedLanguage) {
    setState(() {
      frameLibItemList = [];

      switch (selectedLanguage) {
        case 'Java':
          frameLibItemList = ['Spring', 'Hibernate', 'JavaFX', 'Struts', 'MyBatis', '기타'];
          selectedFrameLib = 'Spring';
          break;
        case 'JavaScript':
          frameLibItemList = ['React', 'Angular', 'Vue.js', 'Node.js', 'Express', 'Next.js', '기타'];
          selectedFrameLib = 'React';
          break;
        case 'Python':
          frameLibItemList = ['Django', 'Flask', 'Pyramid', 'FastAPI', 'CherryPy', '기타'];
          selectedFrameLib = 'Django';
          break;
        case 'Swift':
          frameLibItemList = ['UIKit', 'SwiftUI', 'Combine', 'RxSwift', '기타'];
          selectedFrameLib = 'UIKit';
          break;
        case 'Dart':
          frameLibItemList = ['Flutter', 'Aqueduct', 'Get', 'Riverpod', '기타'];
          selectedFrameLib = 'Flutter';
          break;
        case 'C#':
          frameLibItemList = ['.NET Core', 'ASP.NET', 'Unity', 'WPF', '기타'];
          selectedFrameLib = '.NET Core';
          break;
        case 'PHP':
          frameLibItemList = ['Laravel', 'Symfony', 'CodeIgniter', 'Yii', '기타'];
          selectedFrameLib = 'Laravel';
          break;
        case 'Ruby':
          frameLibItemList = ['Ruby on Rails', 'Sinatra', 'Hanami', '기타'];
          selectedFrameLib = 'Ruby on Rails';
          break;
        default:
          frameLibItemList = ['다른 언어를 선택하세요'];
          selectedFrameLib = frameLibItemList.first;
          break;
      }
    });
  }
}

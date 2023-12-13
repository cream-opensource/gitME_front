import 'package:flutter/material.dart';
import 'package:gitme/screens/cardList_screen.dart';
import 'package:gitme/screens/cardWallet_screen.dart';
import 'package:gitme/screens/login_screen.dart';
import 'package:gitme/screens/profile_screen.dart';
import 'package:provider/provider.dart';

import '../provider/userData.dart';
import '../screens/share_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key});

  Widget _buildListTile(BuildContext context, IconData icon, String title, String route) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom : BorderSide(
            color: Color(0xFFCCCCCC),
            width: 1.0,
          ),
        ),
      ),
      child: ListTile(
        onTap: () => Navigator.pushReplacementNamed(context, route),
        leading: Icon(icon),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 15,
            color: Color(0xFF676A66),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    bool confirmLogout = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('로그아웃 하시겠습니까?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // '아니오'를 선택하면 false 반환
              },
              child: Text('아니오'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // '예'를 선택하면 true 반환
              },
              child: Text('예'),
            ),
          ],
        );
      },
    );
    if (confirmLogout == true) {
      await storage.delete(key: 'login_token');
      Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen(onLoginSuccess: () {})));
    }
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context, listen: false);

    return Drawer(
      width: 256,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            color: Color(0xFF56CC94),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 45),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(bottom: 10),
                      width: 150,
                      height: 150,
                      child: ClipOval(
                        child: Image.network(
                          userData.avatarUrl ?? 'fallback_url_for_empty_avatar',
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  userData.name ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  userData.nickname ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                _buildListTile(context, Icons.person, '마이페이지', ProfileScreen.route),
                _buildListTile(context, Icons.badge, '내 명함', CardListScreen.route),
                _buildListTile(context, Icons.wallet, '명함 지갑', CardWalletScreen.route),
                _buildListTile(context, Icons.wallet, '교환스크린', ShareScreen.route),
              ],
            ),
          ),
          SizedBox(height: 100),
          ListTile(
            onTap: () {
              _logout(context);
            },
            leading: Icon(Icons.exit_to_app),
            title: Text(
              '로그아웃',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF676A66),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

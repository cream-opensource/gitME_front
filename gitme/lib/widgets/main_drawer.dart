import 'package:flutter/material.dart';
import 'package:gitme/screens/cardList_screen.dart';
import 'package:gitme/screens/cardWallet_screen.dart';
import 'package:gitme/screens/profile_screen.dart';

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

  @override
  Widget build(BuildContext context) {
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
                SizedBox(height: 33),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(bottom: 10),
                      width: 138,
                      height: 138,
                      child: Image.asset('assets/jjj.png'),
                    )
                  ],
                ),
                SizedBox(height: 40),
                Text(
                  '조재중',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'm-a-king',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 44),
              ],
            ),
          ),
          _buildListTile(context, Icons.person, '마이페이지', ProfileScreen.route),
          _buildListTile(context, Icons.badge, '내 명함', CardListScreen.route),
          _buildListTile(context, Icons.wallet, '명함 지갑', CardWalletScreen.route),
          _buildListTile(context, Icons.wallet, '교환스크린', ShareScreen.route),
          SizedBox(height: 120),
        ],
      ),
    );
  }
}

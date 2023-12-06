import 'package:flutter/material.dart';
import 'package:gitme/screens/cardList_screen.dart';
import 'package:gitme/screens/cardWallet_screen.dart';
import 'package:gitme/screens/custom_screen.dart';
import 'package:gitme/screens/join_screen.dart';
import 'package:gitme/screens/login_screen.dart';
import 'package:gitme/screens/main_screen.dart';
import 'package:gitme/screens/profile_screen.dart';
import 'package:gitme/screens/qr_scan_screen.dart';

import '../screens/test_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 200,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(bottom: 10),
                width: 50,
                height: 50,
                child: Image.asset('assets/default-user.png'),
              )
            ],
          ),
          SizedBox(height: 30),
          ListTile(
            onTap: () => Navigator.pushReplacementNamed(
              context,
              MainScreen.route,
            ),
            leading: Icon(Icons.account_circle),
            title: Text(
              'HOME',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),

          ListTile(
            onTap: () => Navigator.pushReplacementNamed(
              context,
              ProfileScreen.route,
            ),
            leading: Icon(Icons.account_circle),
            title: Text(
              '내정보',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          ListTile(
            onTap: () => Navigator.pushReplacementNamed(
              context,
              CardListScreen.route,
            ),
            leading: Icon(Icons.account_circle),
            title: Text(
              '내명함',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          ListTile(
            onTap: () => Navigator.pushReplacementNamed(
              context,
              CardWalletScreen.route,
            ),
            leading: Icon(Icons.account_circle),
            title: Text(
              '명함지갑',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          ListTile(
            onTap: () => Navigator.pushReplacementNamed(
              context,
              QRScanScreen.route,
            ),
            leading: Icon(Icons.account_circle),
            title: Text(
              'QRScan',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          ListTile(
            onTap: () => Navigator.pushReplacementNamed(
              context,
              CustomScreen.route,
            ),
            leading: Icon(Icons.account_circle),
            title: Text(
              '커스텀스크린(임시)',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),

          // ListTile(
          //   onTap: () => Navigator.pushReplacementNamed(
          //     context,
          //     TestScreen.route,
          //   ),
          //   leading: Icon(Icons.account_circle),
          //   title: Text(
          //     '테스트화면',
          //     style: TextStyle(
          //       fontSize: 20,
          //     ),
          //   ),
          // ),
          SizedBox(height: 240.0),

          ListTile(
            onTap: () => Navigator.pushReplacementNamed(
              context,
              LoginScreen.route,
            ),
            leading: Icon(Icons.logout),
            title: Text(
              '로그아웃',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );

  }
}

import 'package:flutter/material.dart';
import 'package:gitme/provider/userData.dart';

import 'package:gitme/screens/cardList_screen.dart';
import 'package:gitme/screens/cardWallet_screen.dart';
import 'package:gitme/screens/custom_screen.dart';
import 'package:gitme/screens/externallink_screen.dart';
import 'package:gitme/screens/join_screen.dart';
import 'package:gitme/screens/loading_screen.dart';
import 'package:gitme/screens/login_screen.dart';
import 'package:gitme/screens/main_screen.dart';
import 'package:gitme/screens/profile_screen.dart';
import 'package:gitme/screens/qr_scan_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  mainAsync();
}

void mainAsync() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase 초기화

  runApp(
    ChangeNotifierProvider(
      create: (context) => UserData(),
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Drawer without AppBar',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(),
        routes: {
          MainScreen.route: (_) => MainScreen(),
          LoginScreen.route: (_) => LoginScreen(),
          CardListScreen.route: (_) => CardListScreen(),
          ProfileScreen.route: (_) => ProfileScreen(),
          CardWalletScreen.route: (_) => CardWalletScreen(),
          CustomScreen.route: (_) => CustomScreen(),
          JoinScreen.route: (_) => JoinScreen(),
          QRScanScreen.route: (_) => QRScanScreen(),
          LoadingScreen.route: (_) => LoadingScreen(),
          ExternalLinkScreen.route: (_) => ExternalLinkScreen()
        },
      );
  }
}
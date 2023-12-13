import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gitme/provider/userData.dart';
import 'package:gitme/screens/cardList_screen.dart';
import 'package:gitme/screens/cardWallet_screen.dart';
import 'package:gitme/screens/custom_screen.dart';
import 'package:gitme/screens/externallink_screen.dart';
import 'package:gitme/screens/git_loading_screen.dart';
import 'package:gitme/screens/join_screen.dart';
import 'package:gitme/screens/language_screen_after.dart';
import 'package:gitme/screens/loading_screen.dart';
import 'package:gitme/screens/login_screen.dart';
import 'package:gitme/screens/main_screen.dart';
import 'package:gitme/screens/profile_screen.dart';
import 'package:gitme/screens/qr_scan_screen.dart';
import 'package:gitme/screens/share_screen.dart';
import 'package:provider/provider.dart';

final storage = FlutterSecureStorage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase 초기화

  runApp(
    ChangeNotifierProvider(
      create: (context) => UserData(),
      child: MyApp(),
    ),
  );
}

class AppNavigationState {
  final bool loggedIn;
  final bool dynamicLink;
  final int userIdx;
  final int templateIdx;

  AppNavigationState({this.loggedIn = false, this.dynamicLink = false, this.userIdx = 0, this.templateIdx = 0});
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
      // home: FutureBuilder(
      //   future: _initializeApp(context),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return CircularProgressIndicator();
      //     } else {
      //       final state = snapshot.data ?? AppNavigationState();
      //       return _navigateBasedOnState(context, state);
      //     }
      //   },
      // ),
      home: ExternalLinkScreen(),
      routes: {
        MainScreen.route: (_) => MainScreen(),
        LoginScreen.route: (_) => LoginScreen(onLoginSuccess: () {}),
        CardListScreen.route: (_) => CardListScreen(),
        ProfileScreen.route: (_) => ProfileScreen(),
        CardWalletScreen.route: (_) => CardWalletScreen(),
        CustomScreen.route: (_) => CustomScreen(),
        JoinScreen.route: (_) => JoinScreen(),
        QRScanScreen.route: (_) => QRScanScreen(),
        LoadingScreen.route: (_) => LoadingScreen(onLoadingComplete: () {}),
        ExternalLinkScreen.route: (_) => ExternalLinkScreen(),
        GitLoadingScreen.route: (_) => GitLoadingScreen(),
        AfterLanguageScreen.route: (_) => AfterLanguageScreen(),
      },
    );
  }

  Future<AppNavigationState> _initializeApp(BuildContext context) async {
    final token = await storage.read(key: 'login_token');
    final dynamicLinkData = await FirebaseDynamicLinks.instance.getInitialLink();
    int userIdx = 0;
    int templateIdx = 0;

    if (dynamicLinkData != null) {
      final queryParams = dynamicLinkData.link.queryParameters;
      userIdx = int.tryParse(queryParams['userIdx'] ?? '0') ?? 0;
      templateIdx = int.tryParse(queryParams['templateIdx'] ?? '0') ?? 0;
    }

    if (token != null) {
      final userId = utf8.decode(base64.decode(token));
      Provider.of<UserData>(context, listen: false).setKId(int.parse(userId));

      return AppNavigationState(loggedIn: true, dynamicLink: dynamicLinkData != null, userIdx: userIdx, templateIdx: templateIdx);
    } else {
      return AppNavigationState(loggedIn: false, dynamicLink: dynamicLinkData != null, userIdx: userIdx, templateIdx: templateIdx);
    }
  }

  Widget _navigateBasedOnState(BuildContext context, AppNavigationState state) {
    if (state.dynamicLink) {
     if (state.loggedIn) {
       return _navigateToScreen(context, () => ShareScreen(userIdx: state.userIdx, templateIdx: state.templateIdx));
     } else {
       return _loginAndNavigate(context, () => ShareScreen(userIdx: state.userIdx, templateIdx: state.templateIdx));
     }
    } else {
      if (state.loggedIn) {
        return _navigateToScreen(context, () => MainScreen());
      } else {
        return _loginAndNavigate(context, () => MainScreen());
      }
    }
  }

  Widget _navigateToScreen(BuildContext context, Widget Function() screenBuilder) {
    return LoadingScreen(onLoadingComplete: () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => screenBuilder(),
      ));
    });
  }

  Widget _loginAndNavigate(BuildContext context, Widget Function() screenBuilder) {
    return LoginScreen(onLoginSuccess: () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => LoadingScreen(onLoadingComplete: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => screenBuilder(),
          ));
        }),
      ));
    });
  }
}